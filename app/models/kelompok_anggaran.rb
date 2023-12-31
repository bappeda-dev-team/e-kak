# == Schema Information
#
# Table name: kelompok_anggarans
#
#  id            :bigint           not null, primary key
#  kelompok      :string
#  kode_kelompok :string
#  tahun         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class KelompokAnggaran < ApplicationRecord
  JENIS_KELOMPOK = %w[Murni Perubahan Percobaan].freeze

  validates :kelompok, presence: true,
                       inclusion: { in: JENIS_KELOMPOK, message: '- gunakan (Murni atau Perubahan)' },
                       uniqueness: { scope: :tahun,
                                     message: 'kelompok sudah ada di tahun yang sama' }
  validates :kode_kelompok, uniqueness: { scope: :tahun,
                                          message: 'kode kelompok sudah ada di tahun yang sama' }
  validates :tahun, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 2020, message: 'tahun minimal 2020' }

  default_scope { order(tahun: :asc) }

  after_validation :kode_kelompok_maker

  def kode_kelompok_maker
    return false if tahun.nil? || kelompok.nil?

    self.kode_kelompok = "#{tahun}_#{kelompok.downcase}"
  end

  def kode_tahun_sasaran
    "#{tahun}#{kelompok}".underscore
  end

  def tahun_kelompok
    "#{tahun} #{kelompok}"
  end

  def nama_sederhana_kelompok_tahun
    "#{tahun} #{initial_kelompok}"
  end

  def initial_kelompok
    if kelompok == 'Murni'
      ''
    elsif kelompok == 'Perubahan'
      kelompok[0]
    else
      kelompok
    end
  end

  def murni_perubahan
    kode_kelompok.match(/murni/) ? tahun : kode_kelompok
  end

  def tahun_asli
    kode_kelompok.match(/murni/) ? kode_kelompok[/[^_]\d*/, 0] : kode_kelompok
  end
end
