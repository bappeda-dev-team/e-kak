# == Schema Information
#
# Table name: pokpirs
#
#  id         :bigint           not null, primary key
#  alamat     :string
#  usulan     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Pokpir, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end