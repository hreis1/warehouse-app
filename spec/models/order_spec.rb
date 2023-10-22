require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'attributes cannot be blank' do
      order = Order.new

      order.valid?
      expect(order.errors[:estimated_delivery_date]).to include('não pode ficar em branco')
      expect(order.errors[:supplier]).to include('é obrigatório(a)')
      expect(order.errors[:warehouse]).to include('é obrigatório(a)')
    end
  end
end
