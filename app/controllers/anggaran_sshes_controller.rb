class AnggaranSshesController < ApplicationController
  before_action :set_anggaran_ssh, only: %i[show edit update destroy]
  layout false, only: %i[new edit]

  # GET /anggaran_sshes or /anggaran_sshes.json
  def index
    @anggaran_sshes = if current_user.id == 1
                        AnggaranSsh.all
                      else
                        AnggaranSsh.where(opd_id: current_user.opd.id)
                      end
  end

  def anggaran_ssh_search
    param = params[:q] || ''
    tahun = params[:tahun]
    jenis_uraian = params[:jenisUraian]
    @anggaran_sshes = Search::AllAnggaran
                      .where('uraian_barang ILIKE ? or spesifikasi ILIKE ?',
                             "%#{param}%", "%#{param}%")
                      .where('tahun = ?', tahun)
                      .where(searchable_type: jenis_uraian)
                      .limit(80)
                      .includes(:searchable)
                      .collect(&:searchable)
  end

  def anggaran_spesifikasi_search
    param = params[:q] || ''
    @anggaran_sshes = AnggaranSsh.where('kode_barang ILIKE ?', "%#{param}%").limit(30)
  end

  def anggaran_jenis_search
    @jenis_anggarans = Search::AllAnggaran.distinct.pluck(:searchable_type)
  end

  # GET /anggaran_sshes/1 or /anggaran_sshes/1.json
  def show; end

  # GET /anggaran_sshes/new
  def new
    @anggaran_ssh = AnggaranSsh.new
  end

  # GET /anggaran_sshes/1/edit
  def edit; end

  # POST /anggaran_sshes or /anggaran_sshes.json
  def create
    @anggaran_ssh = AnggaranSsh.new(anggaran_ssh_params)

    respond_to do |format|
      if @anggaran_ssh.save
        format.html { redirect_to anggaran_sshes_url, success: 'Anggaran ssh was successfully created.' }
        format.json { render :show, status: :created, location: @anggaran_ssh }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @anggaran_ssh.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /anggaran_sshes/1 or /anggaran_sshes/1.json
  def update
    respond_to do |format|
      if @anggaran_ssh.update(anggaran_ssh_params)
        format.html { redirect_to anggaran_sshes_url, success: 'Anggaran ssh was successfully updated.' }
        format.json { render :show, status: :ok, location: @anggaran_ssh }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @anggaran_ssh.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /anggaran_sshes/1 or /anggaran_sshes/1.json
  def destroy
    @anggaran_ssh.destroy
    respond_to do |format|
      format.html { redirect_to anggaran_sshes_url, warning: 'Anggaran ssh was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_anggaran_ssh
    @anggaran_ssh = AnggaranSsh.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def anggaran_ssh_params
    params.require(:anggaran_ssh).permit(:kode_kelompok_barang, :uraian_kelompok_barang, :kode_barang,
                                         :tahun, :id_standar_harga, :opd_id,
                                         :uraian_barang, :spesifikasi, :satuan, :harga_satuan)
  end
end
