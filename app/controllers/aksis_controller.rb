class AksisController < ApplicationController
  before_action :set_sasaran
  before_action :set_aksi, only: %i[show edit update destroy]

  # GET /aksis or /aksis.json
  def index
    @aksis = Aksi.all
  end

  # GET /aksis/1 or /aksis/1.json
  def show; end

  # GET /aksis/new
  def new
    # @aksi = Aksi.new
    @aksi = @tahapan.aksis.build
    @bulan = params[:bulan]
  end

  # GET /aksis/1/edit
  def edit
    @bulan = params[:bulan]
    @type = params[:type]
  end

  # POST /aksis or /aksis.json
  def create
    @aksi = @tahapan.aksis.build(aksi_params)
    @aksi.id_aksi_bulan = SecureRandom.base36(6)
    respond_to do |format|
      if @aksi.save
        flash[:success] = "Sukses menambah target"
        format.js { render 'update.js.erb' }
        format.html { redirect_to sasaran_path(@sasaran), success: 'Sukses menambah target' }
        format.json { render :show, status: :created, location: @aksi }
      else
        flash[:error] = "Terjadi kesalahan"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @aksi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aksis/1 or /aksis/1.json
  def update
    @aksi.id_aksi_bulan = SecureRandom.base36(6) if @aksi.id_aksi_bulan.nil?
    respond_to do |format|
      if @aksi.update(aksi_params)
        format.html { redirect_to sasaran_path(@sasaran), success: 'Aksi was successfully updated.' }
        format.json { render :show, status: :ok, location: @aksi }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @aksi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aksis/1 or /aksis/1.json
  def destroy
    @aksi.destroy
    respond_to do |format|
      format.html { redirect_to sasaran_path(@sasaran), notice: 'Aksi was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sasaran
    @sasaran = Sasaran.find(params[:sasaran_id])
    @tahapan = @sasaran.tahapans.find(params[:tahapan_id])
  end

  def set_aksi
    @aksi = @tahapan.aksis.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def aksi_params
    params.require(:aksi).permit(:target, :realisasi, :bulan, :tahapan_id)
  end
end
