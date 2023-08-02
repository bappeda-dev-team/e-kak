class PohonTematikController < ApplicationController
  include ActionView::RecordIdentifier

  layout false, only: %i[new new_sub new_opd_tematik new_strategi_tematik edit]

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
    @opds = Opd.opd_resmi
    @pohon = Pohon.new(pohonable_type: 'Opd', role: 'opd_pohon_kota', tahun: parent_pohon.tahun,
                       pohon_ref_id: parent_pohon.id)
  end

  def new_strategi_tematik
    parent_pohon = Pohon.find(params[:id])
    @opd = parent_pohon.pohonable
    @strategis = @opd.strategis.where(tahun: parent_pohon.tahun, role: 'eselon_2')
    @pohon = Pohon.new(pohonable_type: 'Strategi', role: 'strategi_pohon_kota', tahun: parent_pohon.tahun,
                       pohon_ref_id: parent_pohon.id)
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

  def create_strategi_tematik
    @pohon = Pohon.new(pohon_strategi_tema_params)
    if @pohon.save
      html_content = render_to_string(partial: 'pohon_tematik/pohon_strategi_tematik',
                                      formats: 'html',
                                      layout: false,
                                      locals: { pohon: @pohon })
      render json: { resText: "OPD Tematik Ditambahkan", attachmentPartial: html_content }.to_json, status: :created
    else
      error_content = render_to_string(partial: 'pohon_tematik/form_strategi_tematik',
                                       formats: 'html',
                                       layout: false,
                                       locals: { pohon: @pohon })
      render json: { resText: "Gagal Menyimpan", errors: error_content }.to_json, status: :unprocessable_entity
    end
  end

  private

  def pohon_params
    params.require(:pohon).permit(:pohonable_id, :pohonable_type, :role, :tahun, :keterangan)
  end

  def pohon_sub_tema_params
    params.require(:pohon).permit(:pohonable_id, :pohonable_type, :role, :tahun, :keterangan, :pohon_ref_id)
  end

  def pohon_strategi_tema_params
    params.require(:pohon).permit(:pohonable_id, :pohonable_type, :role, :tahun,
                                  :keterangan,
                                  :pohon_ref_id, strategis_attributes: %i[strategi tahun role type])
  end
end
