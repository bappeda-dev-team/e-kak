class PokpirsController < ApplicationController
  before_action :set_pokpir, only: %i[show edit update destroy aktifkan_pokpir non_aktifkan_pokpir]

  # GET /pokpirs or /pokpirs.json
  def index
    @pokpirs = Pokpir.all
  end

  # GET /pokpirs/1 or /pokpirs/1.json
  def show; end

  def aktifkan_pokpir
    respond_to do |format|
      format.js { render :aktifkan_pokpir } if @pokpir.update_attribute(:is_active, 1)
    end
  end

  def non_aktifkan_pokpir
    respond_to do |format|
      format.js { render :non_aktifkan_pokpir } if @pokpir.update_attribute(:is_active, 0)
    end
  end

  # GET /pokpirs/new
  def new
    @pokpir = Pokpir.new
  end

  # GET /pokpirs/1/edit
  def edit; end

  # POST /pokpirs or /pokpirs.json
  def create
    @pokpir = Pokpir.new(pokpir_params)

    respond_to do |format|
      if @pokpir.save
        format.js
        format.html { redirect_to pokpirs_path, notice: 'Pokpir was successfully created.' }
        format.json { render :show, status: :created, location: @pokpir }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pokpir.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pokpirs/1 or /pokpirs/1.json
  def update
    respond_to do |format|
      if @pokpir.update(pokpir_params)
        format.js
        format.html { redirect_to @pokpir, notice: 'Pokpir was successfully updated.' }
        format.json { render :show, status: :ok, location: @pokpir }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pokpir.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokpirs/1 or /pokpirs/1.json
  def destroy
    @pokpir.destroy
    respond_to do |format|
      format.html { redirect_to pokpirs_url, notice: 'Pokpir was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pokpir
    @pokpir = Pokpir.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pokpir_params
    params.require(:pokpir).permit(:usulan, :alamat, :tahun, :sasaran_id, :nip_asn)
  end
end
