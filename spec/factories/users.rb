# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  kode_opd               :string
#  nama                   :string
#  nik                    :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (kode_opd => opds.kode_opd)
#
FactoryBot.define do
  factory :user do
    nama { "NOOR AFLAH" }
    nik {"197609072003121007"}
    email {"197609072003121007@madiunkota.go.id"}
    password {"123456"}
    association :opd
  end
end