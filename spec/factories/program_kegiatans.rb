# == Schema Information
#
# Table name: program_kegiatans
#
#  id                :bigint           not null, primary key
#  indikator_kinerja :string
#  nama_kegiatan     :string
#  nama_program      :string
#  nama_subkegiatan  :string
#  satuan            :string
#  target            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  opd_id            :integer
#
FactoryBot.define do
  factory :program_kegiatan do
    indikator_kinerja { "Indikator Program A" }
    nama_program { "PROGRAM PERENCANAAN, PENGENDALIAN DAN EVALUASI PEMBANGUNAN DAERAH" }
    nama_kegiatan { "Penyusunan Perencanaan dan Pendanaan" }
    nama_subkegiatan { "Pelaksanaan Musrenbang Kabupaten/Kota" }
    target { 100 }
    satuan { "persen" }
    association :opd
  end
end