require 'rails_helper'
require 'shoulda/matchers'

RSpec.describe Store, type: :model do
  context 'associations' do
    it { should have_many(:vehicles).dependent(:destroy) }
  end
end


