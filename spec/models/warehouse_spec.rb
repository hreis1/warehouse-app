require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'when all attributes are present' do
      it 'false when name is blank' do
        warehouse = Warehouse.new(name: '', code: '123', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
        expect(warehouse.valid?).to eq false
      end

      it 'false when code is blank' do
        warehouse = Warehouse.new(name: 'Galpão A', code: '', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
        expect(warehouse.valid?).to eq false
      end

      it 'false when city is blank' do
        warehouse = Warehouse.new(name: 'Galpão A', code: '123', city: '', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
        expect(warehouse.valid?).to eq false
      end

      it 'false when area is blank' do
        warehouse = Warehouse.new(name: 'Galpão A', code: '123', city: 'Cidade A', area: '', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
        expect(warehouse.valid?).to eq false
      end

      it 'false when address is blank' do
        warehouse = Warehouse.new(name: 'Galpão A', code: '123', city: 'Cidade A', area: '1000', address: '', cep: '12345678', description: 'Galpão com 1000m²')
        expect(warehouse.valid?).to eq false
      end

      it 'false when cep is blank' do
        warehouse = Warehouse.new(name: 'Galpão A', code: '123', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '', description: 'Galpão com 1000m²')
        expect(warehouse.valid?).to eq false
      end

      it 'false when description is blank' do
        warehouse = Warehouse.new(name: 'Galpão A', code: '123', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: '')
        expect(warehouse.valid?).to eq false
      end
    end

    it 'false when code is not unique' do
      Warehouse.create!(name: 'Galpão A', code: '123', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      warehouse = Warehouse.new(name: 'Galpão B', code: '123', city: 'Cidade B', area: '2000', address: 'Rua B', cep: '87654321', description: 'Galpão com 2000m²')
      expect(warehouse).not_to be_valid
    end
  end
end
