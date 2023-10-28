require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#valid?' do
    it 'attributes cannot be blank' do
      order_item = OrderItem.new

      order_item.valid?

      expect(order_item.errors[:quantity]).to include('não pode ficar em branco')
      expect(order_item.errors[:product_model]).to include('é obrigatório(a)')
      expect(order_item.errors[:order]).to include('é obrigatório(a)')
    end

    it 'quantity must be greater than 0' do
      order_item = OrderItem.new(quantity: 0)

      order_item.valid?

      expect(order_item.errors[:quantity]).to include('deve ser maior que 0')
    end
  end
end
