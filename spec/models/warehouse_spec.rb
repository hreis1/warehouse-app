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

    context 'when code is unique, has 3 letters and is entirely composed of uppercase letters' do
      it 'false when code is not unique' do
        Warehouse.create!(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
        warehouse = Warehouse.new(name: 'Galpão B', code: 'ABC', city: 'Cidade B', area: '2000', address: 'Rua B', cep: '87654321', description: 'Galpão com 2000m²')
        expect(warehouse).not_to be_valid
      end

      it 'false when code length is different from 3' do
        warehouse = Warehouse.new(name: 'Galpão A', code: 'ABCD', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
        expect(warehouse).not_to be_valid
      end

      it 'false when code is not entirely composed of uppercase letters' do
        warehouse = Warehouse.new(name: 'Galpão A', code: 'abc', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
        expect(warehouse).not_to be_valid
      end

      it 'false when code is not entirely composed of letters' do
        warehouse = Warehouse.new(name: 'Galpão A', code: 'AB3', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
        expect(warehouse).not_to be_valid
      end
    end

    it 'false when name is not unique' do
      Warehouse.create!(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      warehouse = Warehouse.new(name: 'Galpão A', code: 'DEF', city: 'Cidade B', area: '2000', address: 'Rua B', cep: '87654321', description: 'Galpão com 2000m²')
      expect(warehouse).not_to be_valid
    end

    it 'false when area is not a number' do
      warehouse = Warehouse.new(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: 'mil', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      expect(warehouse).not_to be_valid
    end

    context 'when cep is not in the format 12345-678 or 12345678' do
      it 'false when cep is not in the format 12345-678' do
        warehouse = Warehouse.new(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345.678', description: 'Galpão com 1000m²')
        expect(warehouse).not_to be_valid
      end
      
      it 'false when cep is not in the format 12345678' do
        warehouse = Warehouse.new(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '1234567', description: 'Galpão com 1000m²')
        expect(warehouse).not_to be_valid
      end
    end
  end

  describe '#full_address' do
    it 'returns the full address' do
      warehouse = Warehouse.new(name: 'Galpão A', code: 'ABC', city: 'Cidade A', area: '1000', address: 'Rua A', cep: '12345678', description: 'Galpão com 1000m²')
      expect(warehouse.full_address).to eq 'Cidade A - Rua A - CEP: 12345678'
    end
  end

  describe '#full_description' do
    it 'returns the full description' do
      warehouse = Warehouse.new(name: 'Galpão A', code: 'ABC')
      expect(warehouse.full_description).to eq 'ABC - Galpão A'
    end
  end
end
