class SubSubTematiksController < TematiksController
  def create
    pohon_sub = params[:sub_sub_tematik][:pohon_sub]
    @sub_sub_tematik = SubSubTematik.new(sub_sub_tematik_params)
    tahun = cookies[:tahun]

    if @sub_sub_tematik.save
      @pohon = Pohon.create(pohonable_id: @sub_sub_tematik.id,
                            pohonable_type: @sub_sub_tematik.class.name,
                            role: 'sub_sub_pohon_kota',
                            tahun: tahun,
                            pohon_ref_id: pohon_sub,
                            keterangan: @sub_sub_tematik.keterangan)
      render json: { resText: "Pohon Sub Sub-Tematik Dibuat",
                     attachmentPartial: html_content('pohon_tematik/pohon_sub_sub_tematik') }.to_json,
             status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_sub_sub_tematik',
                                       formats: 'html',
                                       layout: false,
                                       locals: { sub_sub_tematik: @sub_sub_tematik })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tematiks/1 or /tematiks/1.json
  def update
    @sub_sub_tematik = SubSubTematik.find(params[:id])
    @pohon_sub = Pohon.find_by(pohonable_id: params[:id], pohonable_type: 'SubSubTematik')

    if @sub_sub_tematik.update(sub_sub_tematik_params)
      @pohon_sub.update(keterangan: @sub_sub_tematik.keterangan)
      @pohon = @pohon_sub
      render json: { resText: "Pohon Sub Sub-Tematik diperbarui",
                     attachmentPartial: html_content('pohon_tematik/pohon_sub_sub_tematik') }.to_json,
             status: :ok
    else
      render json: { resText: "Gagal memperbarui", res: @tematik.errors }.to_json, status: :unprocessable_entity
    end
  end

  private

  def html_content(partial)
    render_to_string(partial: partial,
                     formats: 'html',
                     layout: false,
                     locals: { pohon: @pohon })
  end

  def sub_sub_tematik_params
    params.require(:sub_sub_tematik).permit(:tema, :keterangan, :tematik_ref_id, :type, indikators_attributes)
  end

  def indikators_attributes
    { indikators_attributes: %i[id kode kode_opd indikator target satuan _destroy] }
  end
end
