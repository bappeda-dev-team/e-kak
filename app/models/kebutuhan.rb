# == Schema Information
#
# Table name: kebutuhans
#
#  id         :bigint           not null, primary key
#  kebutuhan  :string
#  keterangan :string
#  tahun      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Kebutuhan < ApplicationRecord
  def to_s
    kebutuhan
  end
end
