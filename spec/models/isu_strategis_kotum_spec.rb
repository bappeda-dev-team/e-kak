# == Schema Information
#
# Table name: isu_strategis_kota
#
#  id            :bigint           not null, primary key
#  isu_strategis :string           not null
#  keterangan    :string
#  kode          :string           not null
#  tahun         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  lembaga_id    :bigint           default(1)
#
require "rails_helper"

RSpec.describe IsuStrategisKotum, type: :model do
  context "validation" do
    it { should validate_presence_of(:kode) }
    it { should validate_presence_of(:isu_strategis) }
    it { should validate_presence_of(:tahun) }
  end
end
