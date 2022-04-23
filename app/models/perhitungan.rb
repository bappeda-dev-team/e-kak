# == Schema Information
#
# Table name: perhitungans
#
#  id          :bigint           not null, primary key
#  deskripsi   :string
#  harga       :integer
#  satuan      :string
#  spesifikasi :text
#  total       :integer
#  volume      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  anggaran_id :bigint
#  pajak_id    :bigint
#
# Indexes
#
#  index_perhitungans_on_anggaran_id  (anggaran_id)
#
# Foreign Keys
#
#  fk_rails_...  (pajak_id => pajaks.id) ON DELETE => nullify
#
class Perhitungan < ApplicationRecord
  after_save :update_jumlah_anggaran
  after_update :update_jumlah_anggaran
  after_destroy :update_jumlah_anggaran_destroy

  belongs_to :anggaran
  belongs_to :pajak, optional: true
  has_many :koefisiens
  accepts_nested_attributes_for :koefisiens

  validates :deskripsi, presence: true # uraian
  validates :satuan, presence: true
  validates :harga, presence: true, numericality: true

  def hitung_total
    unless destroyed?
      total_akhir = kalkulasi_harga_total
      update_column(:total, total_akhir)
    end
  end

  def kalkulasi_harga_total
    if koefisiens.any?
      total_volume = []
      koefisiens.map do |k|
        total_volume << k.volume
      end
      volume = total_volume.reduce(:*)
      total_harga = volume * harga
      pajak_anggaran = anggaran.pajak.potongan
      total_plus_pajak = total_harga * pajak_anggaran
      total_harga + total_plus_pajak.to_i
    else
      0
    end
  end

  def update_jumlah_anggaran
    anggaran.update_perhitungan
  end

  def update_jumlah_anggaran_destroy
    anggaran.update_perhitungan
  end

  def list_koefisien
    koefisiens.map { |m| "#{m.volume} #{m.satuan_volume}" }.join(' x ')
  end
end
