class PohonTematikController < ApplicationController
  include ActionView::RecordIdentifier

  layout false

  def new
    tahun = cookies[:tahun]
    @tematiks = Tematik.all.where(type: nil).order(updated_at: :desc)
    @pohon = Pohon.new(pohonable_type: 'Tematik', role: 'pohon_kota', tahun: tahun)
  end

  def new_sub
    parent_pohon = Pohon.find(params[:id])
    @tematik = parent_pohon.pohonable
    @sub_tematiks = @tematik.sub_tematiks.order(updated_at: :desc)
    @pohon = Pohon.new(pohonable_type: 'SubTematik', role: 'sub_pohon_kota', tahun: parent_pohon.tahun,
                       pohon_ref_id: parent_pohon.id)
  end

  def new_opd_tematik
    parent_pohon = Pohon.find(params[:id])
    @sub_tematik = parent_pohon.pohonable
    @opds = Opd.opd_resmi.collect { |opd| [opd.nama_opd, opd.id] }
    @pohon = Pohon.new(pohonable_type: 'Opd', role: 'opd_pohon_kota', tahun: parent_pohon.tahun,
                       pohon_ref_id: parent_pohon.id)
  end

  def edit_opd_tematik
    @pohon = Pohon.find(params[:id])
    @sub_tematik = Pohon.find(@pohon.pohon_ref_id).pohonable
    @opds = Opd.opd_resmi.collect { |opd| [opd.nama_opd, opd.id] }
  end

  def pindah_opd_tematik
    @pohon = Pohon.find(params[:id])
    @tahun = @pohon.tahun
    @dahan_atas = Pohon.where(pohonable_type: 'SubTematik', role: 'sub_pohon_kota', tahun: @tahun)
                       .collect { |dahan| [dahan.pohonable.tema, dahan.id] }
  end

  def create_opd_tematik
    @pohon = Pohon.new(pohon_sub_tema_params)
    if @pohon.save
      html_content = render_to_string(partial: 'pohon_tematik/pohon_opd_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "OPD Tematik Ditambahkan", attachmentPartial: html_content }.to_json, status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_opd_tematik',
                                       formats: 'html',
                                       layout: false,
                                       locals: { pohon: @pohon })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  def update_opd_tematik
    @pohon = Pohon.find(params[:id])
    if @pohon.update(pohon_sub_tema_params)
      html_content = render_to_string(partial: 'pohon_tematik/pohon_opd_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "OPD Tematik Diupdate", attachmentPartial: html_content }.to_json, status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_opd_tematik',
                                       formats: 'html',
                                       layout: false,
                                       locals: { pohon: @pohon })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  def pindah_pohon
    @pohon = Pohon.find(params[:id])
    if @pohon.update(pohon_sub_tema_params)
      render json: { resText: "Jalur di-ubah" }.to_json,
             status: :created
    else
      render json: { resText: "Gagal Menyimpan" }.to_json, status: :unprocessable_entity
    end
  end

  def new_strategi_tematik
    parent_pohon = Pohon.find(params[:id])
    @opd = parent_pohon.pohonable
    @strategis = @opd.strategis.where(tahun: parent_pohon.tahun, role: 'eselon_2')
    @pohon = Pohon.new(pohonable_type: 'Strategi', role: 'strategi_pohon_kota', tahun: parent_pohon.tahun,
                       opd_id: @opd.id,
                       pohon_ref_id: parent_pohon.id)
  end

  def new_strategi
    parent_pohon = Pohon.find(params[:id])
    @pohon_ref_id = params[:id]
    @opd = parent_pohon.pohonable
    @strategi = Strategi.new(role: 'strategi_pohon_kota', tahun: parent_pohon.tahun,
                             opd_id: @opd.id)
  end

  def new_tactical_tematik
    parent_pohon = Pohon.find(params[:id])
    @opd = parent_pohon.opd
    @strategis = @opd.strategis.where(tahun: parent_pohon.tahun, role: 'eselon_3')
    @pohon = Pohon.new(pohonable_type: 'Strategi', role: 'tactical_pohon_kota', tahun: parent_pohon.tahun,
                       opd_id: @opd.id,
                       pohon_ref_id: parent_pohon.id)
  end

  def new_tactical
    parent_pohon = Pohon.find(params[:id])
    @pohon_ref_id = params[:id]
    @opd = parent_pohon.opd
    @tactical = Strategi.new(role: 'tactical_pohon_kota', tahun: parent_pohon.tahun,
                             opd_id: @opd.id)
  end

  def new_operational_tematik
    parent_pohon = Pohon.find(params[:id])
    @opd = parent_pohon.opd
    @strategis = @opd.strategis.where(tahun: parent_pohon.tahun, role: 'eselon_4')
    @pohon = Pohon.new(pohonable_type: 'Strategi', role: 'operational_pohon_kota', tahun: parent_pohon.tahun,
                       opd_id: @opd.id,
                       pohon_ref_id: parent_pohon.id)
  end

  def new_operational
    parent_pohon = Pohon.find(params[:id])
    @pohon_ref_id = params[:id]
    @opd = parent_pohon.opd
    @operational = Strategi.new(role: 'operational_pohon_kota', tahun: parent_pohon.tahun,
                                opd_id: @opd.id)
  end

  def create
    @pohon = Pohon.new(pohon_params)
    if @pohon.save
      html_content = render_to_string(partial: 'pohon_tematik/pohon_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "Pohon Tematik Dibuat", attachmentPartial: html_content }.to_json, status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form',
                                       formats: 'html',
                                       layout: false,
                                       locals: { pohon: @pohon })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  def create_sub_tema
    @pohon = Pohon.new(pohon_sub_tema_params)
    if @pohon.save
      html_content = render_to_string(partial: 'pohon_tematik/pohon_sub_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "Pohon Sub-Tematik Dibuat", attachmentPartial: html_content }.to_json, status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_sub_tematik',
                                       formats: 'html',
                                       layout: false,
                                       locals: { pohon: @pohon })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  def create_strategi_tematik
    @pohon = Pohon.new(pohon_strategi_tema_params)
    if @pohon.save
      html_content = render_to_string(partial: 'pohon_tematik/pohon_strategi_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "Strategi Tematik Ditambahkan", attachmentPartial: html_content }.to_json,
             status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_strategi_tematik',
                                       formats: 'html',
                                       layout: false,
                                       locals: { pohon: @pohon })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  def create_strategi_tematik_baru
    @strategi = Strategi.new(strategi_params)
    if @strategi.save
      @pohon = new_pohon!
      html_content = render_to_string(partial: 'pohon_tematik/pohon_strategi_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "Strategi Tematik Ditambahkan", attachmentPartial: html_content }.to_json,
             status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_strategi_tematik_baru',
                                       formats: 'html',
                                       layout: false,
                                       locals: { strategi: @strategi })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  def create_tactical_tematik
    @pohon = Pohon.new(pohon_strategi_tema_params)
    if @pohon.save
      html_content = render_to_string(partial: 'pohon_tematik/pohon_tactical_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "Tactical Tematik Ditambahkan", attachmentPartial: html_content }.to_json,
             status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_tactical_tematik',
                                       formats: 'html',
                                       layout: false,
                                       locals: { pohon: @pohon })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  def create_tactical_tematik_baru
    @strategi = Strategi.new(strategi_params)
    if @strategi.save
      @pohon = new_pohon!
      html_content = render_to_string(partial: 'pohon_tematik/pohon_tactical_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "Tactical Tematik Ditambahkan", attachmentPartial: html_content }.to_json,
             status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_tactical_tematik_baru',
                                       formats: 'html',
                                       layout: false,
                                       locals: { strategi: @strategi })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  def create_operational_tematik
    @pohon = Pohon.new(pohon_strategi_tema_params)
    if @pohon.save
      html_content = render_to_string(partial: 'pohon_tematik/pohon_operational_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "Operational Tematik Ditambahkan", attachmentPartial: html_content }.to_json,
             status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_operational_tematik',
                                       formats: 'html',
                                       layout: false,
                                       locals: { pohon: @pohon })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  def create_operational_tematik_baru
    @strategi = Strategi.new(strategi_params)
    if @strategi.save
      @pohon = new_pohon!
      html_content = render_to_string(partial: 'pohon_tematik/pohon_operational_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "Operational Tematik Ditambahkan", attachmentPartial: html_content }.to_json,
             status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_operational_tematik_baru',
                                       formats: 'html',
                                       layout: false,
                                       locals: { strategi: @strategi })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  private

  def new_pohon_params
    @tahun = params[:strategi][:tahun]
    @role = params[:strategi][:role]
    @pohon_ref_id = params[:strategi][:pohon_ref_id]
    @opd_id = params[:strategi][:opd_id]
    @keterangan = params[:strategi][:keterangan]
  end

  def new_pohon!
    new_pohon_params
    Pohon.create!(pohonable_type: 'Strategi', pohonable_id: @strategi.id,
                  role: @role, tahun: @tahun,
                  keterangan: @keterangan,
                  pohon_ref_id: @pohon_ref_id, opd_id: @opd_id)
  end

  def pohon_params
    params.require(:pohon).permit(:pohonable_id, :pohonable_type, :role, :tahun, :keterangan)
  end

  def pohon_sub_tema_params
    params.require(:pohon).permit(:pohonable_id, :pohonable_type, :role, :tahun, :keterangan, :pohon_ref_id)
  end

  def pohon_strategi_tema_params
    params.require(:pohon).permit(:pohonable_id, :pohonable_type, :role, :tahun,
                                  :opd_id,
                                  :keterangan, :pohon_ref_id)
  end

  def strategi_params
    params.require(:strategi).permit(:role, :tahun,
                                     :strategi, :opd_id)
  end
end
