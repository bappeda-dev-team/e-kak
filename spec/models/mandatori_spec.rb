# == Schema Information
#
# Table name: mandatoris
#
#  id                :bigint           not null, primary key
#  nip_asn           :string
#  opd               :string
#  peraturan_terkait :string
#  tahun             :string
#  usulan            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  sasaran_id        :bigint
#
# Indexes
#
#  index_mandatoris_on_sasaran_id  (sasaran_id)
#
require 'rails_helper'

RSpec.describe Mandatori, type: :model do
  context 'validation' do
    it { should validate_presence_of(:usulan) }
    it { should validate_presence_of(:peraturan_terkait) }
  end

  context 'association' do
    it { should belong_to(:sasaran).optional }
  end
end
