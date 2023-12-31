class RincianBelanjaController < ApplicationController
  before_action :set_user
  before_action :set_tahun

  def index
    kak = KakQueries.new(opd: @user.opd, tahun: @tahun, user: @user)
    @subkegiatan_sasarans = kak.pk_sasarans
  end

  def index_atasan
    @subkegiatan_sasarans = @user.program_sasarans_tahun(@tahun)
  end

  def show
    @sasaran = Sasaran.find(params[:id])
  end

  def edit
    @sasaran = Sasaran.find(params[:id])
  end

  def show_subkegiatan
    @subkegiatan = ProgramKegiatan.find(params[:id])
    @sasarans = @subkegiatan.sasarans_subkegiatan(@tahun)
    @rekening_sub = @subkegiatan.rekening_belanja(@tahun)
  end

  def edit_rankir_gelondong
    @sasaran = Sasaran.find(params[:id])
    @tahapans = @sasaran.tahapans.includes(%i[anggarans])
  end

  def edit_penetapan
    @sasaran = Sasaran.find(params[:id])
    @tahapans = @sasaran.tahapans.includes(%i[anggarans])
  end

  private

  def set_user
    @user = current_user
  end

  def set_tahun
    @tahun = cookies[:tahun]
  end
end
