# == Schema Information
#
# Table name: musrenbangs
#
#  id         :bigint           not null, primary key
#  alamat     :text
#  is_active  :boolean          default(FALSE)
#  nip_asn    :string
#  opd        :string
#  tahun      :string
#  usulan     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sasaran_id :bigint
#
# Indexes
#
#  index_musrenbangs_on_sasaran_id  (sasaran_id)
#
class Musrenbang < ApplicationRecord
  validates :usulan, presence: true
  validates :tahun, presence: true, numericality: { only_integer: true }
  # has_rich_text :usulan

  belongs_to :sasaran, optional: true
  has_many :usulans, as: :usulanable

  default_scope { order(created_at: :desc) }
end
