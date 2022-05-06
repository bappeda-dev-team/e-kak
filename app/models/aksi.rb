# == Schema Information
#
# Table name: aksis
#
#  id              :bigint           not null, primary key
#  bulan           :integer
#  id_aksi_bulan   :string
#  id_rencana_aksi :string
#  realisasi       :integer
#  target          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  tahapan_id      :bigint
#
# Indexes
#
#  index_aksis_on_id_aksi_bulan  (id_aksi_bulan) UNIQUE
#  index_aksis_on_tahapan_id     (tahapan_id)
#
class Aksi < ApplicationRecord
  belongs_to :tahapan, foreign_key: 'id_rencana_aksi', primary_key: 'id_rencana_aksi'
  after_save :update_total_target_bulan
  after_save :update_total_realisasi_bulan
  after_save :update_waktu
  after_save :update_progress
  after_update :update_total_target_bulan
  after_update :update_total_realisasi_bulan
  after_update :update_waktu
  after_update :update_progress
  after_destroy  :update_total_target_bulan
  after_destroy  :update_total_realisasi_bulan
  after_destroy  :update_waktu
  after_destroy  :update_progress

  validates :target, presence: true, numericality: { only_integer: true }
  # validates :realisasi, numericality: { only_integer: true }

  def sync_total
    run_callbacks :update do
      puts '- save'
    end
  end

  def update_total_target_bulan
    tahapan = self.tahapan
    tahapan.jumlah_target = tahapan.aksis.sum :target
    tahapan.save
  end

  def update_total_realisasi_bulan
    tahapan = self.tahapan
    tahapan.jumlah_realisasi = tahapan.aksis.sum :realisasi
    tahapan.save
  end

  def update_waktu
    tahapan = self.tahapan
    tahapan.waktu = tahapan.aksis.count(:bulan)
    tahapan.save
  end

  def update_progress
    tahapan = self.tahapan
    t = tahapan.jumlah_target
    r = tahapan.jumlah_realisasi
    check = r * t
    tahapan.progress = if check.zero?
                         0
                       else
                         r / t * 100
                       end
    tahapan.save
  end
end
