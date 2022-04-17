# == Schema Information
#
# Table name: pokpirs
#
#  id         :bigint           not null, primary key
#  alamat     :string
#  is_active  :boolean          default(FALSE)
#  nip_asn    :string
#  opd        :string
#  status     :enum             default("draft")
#  tahun      :string
#  uraian     :string
#  usulan     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sasaran_id :bigint
#
# Indexes
#
#  index_pokpirs_on_sasaran_id  (sasaran_id)
#  index_pokpirs_on_status      (status)
#
FactoryBot.define do
  factory :pokpir do
    usulan { "Usulan Pokok Pikiran 123" }
    alamat { "Alamat Entah" }
  end
end
