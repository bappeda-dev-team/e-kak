# == Schema Information
#
# Table name: inovasis
#
#  id         :bigint           not null, primary key
#  manfaat    :string
#  nip_asn    :string
#  opd        :string
#  tahun      :string
#  usulan     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sasaran_id :bigint
#
# Indexes
#
#  index_inovasis_on_sasaran_id  (sasaran_id)
#
require 'rails_helper'

RSpec.describe Inovasi, type: :model do
  context 'validations' do
    it { should validate_presence_of(:usulan) }
  end
  context 'relationship' do
    it { should belong_to(:sasaran).optional }
  end
end
