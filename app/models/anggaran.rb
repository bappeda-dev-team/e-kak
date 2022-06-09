# frozen_string_literal: true

# == Schema Information
#
# Table name: anggarans
#
#  id         :bigint           not null, primary key
#  jumlah     :decimal(, )
#  kode_rek   :string
#  level      :integer          default(0)
#  set_input  :string           default("0")
#  tahun      :integer
#  uraian     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pajak_id   :bigint
#  parent_id  :bigint
#  tahapan_id :bigint
#
# Indexes
#
#  index_anggarans_on_pajak_id    (pajak_id)
#  index_anggarans_on_parent_id   (parent_id)
#  index_anggarans_on_tahapan_id  (tahapan_id)
#
# Foreign Keys
#
#  fk_rails_...  (pajak_id => pajaks.id)
#
class Anggaran < ApplicationRecord
  # TODO: Tes method penting
  # TODO: Single Responsibility Principle, rekening_level violates this
  after_initialize :set_default_values
  # after_update :update_perhitungan

  belongs_to :tahapan
  has_many :perhitungans, dependent: :destroy
  # child untuk memanggil id isian bawahnya
  has_many :childs, class_name: 'Anggaran', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Anggaran', optional: true
  belongs_to :pajak, optional: true
  has_many :comments, dependent: :destroy

  scope :tanpa_pajak, -> { where(pajak_id: nil) }
  scope :ujung_anggaran, -> { where(level: 0) }
  scope :pangkal_anggaran, -> { where(level: 5) }

  validates :uraian, presence: true

  def set_default_values
    self.jumlah = 0 if new_record?
  end

  # get all anggaran with koefisiens
  def with_koefisiens
    perhitungans.includes(:koefisiens).map(&:koefisiens)
  end

  def the_parent
    parents = []
    unless parent.nil?
      parents << parent
      parents.concat(parent.the_parent)
    end
    parents
  end

  def grand_parent
    the_parent.last
  end

  def rekening_level
    return unless level == 4

    rek_level3 = kode_rek[0..-6]
    rek_level2 = kode_rek[0..-9]
    rek_level1 = kode_rek[0..-12]
    rek_level0 = kode_rek[0..-15]
    { 'level_3' => rek_level3, 'level_2' => rek_level2, 'level_1' => rek_level1, 'level_0' => rek_level0 }
  end

  def plus_pajak
    pajak.potongan * 100
  end

  def update_perhitungan
    perhitungan_semua = perhitungans.each(&:hitung_total)
    hasil_perhitungan = perhitungan_semua.map(&:total).sum
    update_column(:jumlah, hasil_perhitungan)
  end

  def perhitungan_jumlah
    perhitungan_semua = perhitungans.each(&:new_hitung_total)
    hasil_perhitungan = perhitungan_semua.map(&:total).sum
    update_column(:jumlah, hasil_perhitungan)
  end
end
