module Api
  class TematikController < ActionController::API
    respond_to :json

    before_action :set_params

    def list_tematik
      pohon = PohonTematikQueries.new(tahun: @tahun)
      @tematiks = pohon.tematiks.map(&:pohonable).compact
    end

    def programs
      anggarans = AnggaranTematikQueries.new(tahun: @tahun, tematik_id: @tematik_id)
      @tematik = anggarans.tematik
      @opds = anggarans.program_with_pagu
      @jumlah = anggarans.total
    rescue ActiveRecord::RecordNotFound
      @error = "Tema tidak ditemukan"
      render json: { message: "terjadi kesalahan", errors: @error }.to_json,
             status: :not_found
    end

    def subkegiatans
      anggarans = AnggaranTematikQueries.new(tahun: @tahun, tematik_id: @tematik_id)
      @tematik = anggarans.tematik
      @opds = anggarans.subkegiatan_with_pagu
      @jumlah = anggarans.total_sub
    rescue ActiveRecord::RecordNotFound
      @error = "Tema tidak ditemukan"
      render json: { message: "terjadi kesalahan", errors: @error }.to_json,
             status: :not_found
    end

    private

    def set_params
      @tematik_id = params[:id_tematik]
      @tahun = params[:tahun]
    end
  end
end
