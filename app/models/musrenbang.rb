# == Schema Information
#
# Table name: musrenbangs
#
#  id         :bigint           not null, primary key
#  tahun      :string
#  usulan     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Musrenbang < ApplicationRecord
  validates :usulan, presence: true
  validates :tahun, presence: true, numericality: { only_integer: true }
  has_rich_text :usulan
end
