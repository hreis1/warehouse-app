require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid' do
    it 'false when name is blank' do
      user = User.new(name:'', email:'email@email.com', password:'123456')
      expect(user.valid?).to eq false
    end
  end
end
