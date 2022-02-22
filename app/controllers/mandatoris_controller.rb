class MandatorisController < ApplicationController
  before_action :set_mandatori, only: %i[ show edit update destroy ]

  # GET /mandatoris or /mandatoris.json
  def index
    @mandatoris = Mandatori.all
  end

  # GET /mandatoris/1 or /mandatoris/1.json
  def show
  end

  # GET /mandatoris/new
  def new
    @mandatori = Mandatori.new
  end

  # GET /mandatoris/1/edit
  def edit
  end

  # POST /mandatoris or /mandatoris.json
  def create
    @mandatori = Mandatori.new(mandatori_params)

    respond_to do |format|
      if @mandatori.save
        format.html { redirect_to @mandatori, notice: "Mandatori was successfully created." }
        format.json { render :show, status: :created, location: @mandatori }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mandatori.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mandatoris/1 or /mandatoris/1.json
  def update
    respond_to do |format|
      if @mandatori.update(mandatori_params)
        format.html { redirect_to @mandatori, notice: "Mandatori was successfully updated." }
        format.json { render :show, status: :ok, location: @mandatori }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mandatori.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mandatoris/1 or /mandatoris/1.json
  def destroy
    @mandatori.destroy
    respond_to do |format|
      format.html { redirect_to mandatoris_url, notice: "Mandatori was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mandatori
      @mandatori = Mandatori.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mandatori_params
      params.require(:mandatori).permit(:usulan, :peraturan_terkait)
    end
end