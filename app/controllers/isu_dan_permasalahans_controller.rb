class IsuDanPermasalahansController < ApplicationController
  before_action :set_params

  def index; end

  def filter_isu
    programs = KakService.new(tahun: @tahun, kode_unik_opd: @kode_unik_opd).program_kegiatans_by_opd
    @program_kegiatans = programs
  end

  private

  def set_params
    @kode_unik_opd = params[:kode_unik_opd]
    @tahun = params[:tahun]
  end
end
