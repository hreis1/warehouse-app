require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid' do
    it 'false when name is blank' do
      user = User.new(name:'', email:'email@email.com', password:'123456')
      expect(user.valid?).to eq false
    end
  end
  describe '#description' do
    it 'returns the name' do
      user = User.new(name:'John Doe', email:'johnd@email.com')
      expect(user.description).to eq 'John Doe - johnd@email.com'
    end
  end
end
