require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    it 'false when corporate_name is blank' do
      supplier = Supplier.new(corporate_name: '', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores, 123', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com')
      expect(supplier.valid?).to eq false
    end

    it 'false when brand_name is blank' do
      supplier = Supplier.new(corporate_name: 'Fornecedor ABC', brand_name: '', registration_number: '1234567891011', full_address: 'Rua das Flores, 123', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com')
      expect(supplier.valid?).to eq false
    end

    it 'false when registration_number is blank' do
      supplier = Supplier.new(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '', full_address: 'Rua das Flores, 123', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com')
      expect(supplier.valid?).to eq false
    end

    it 'false when full_address is blank' do
      supplier = Supplier.new(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: '', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com')
      expect(supplier.valid?).to eq false
    end

    it 'false when city is blank' do
      supplier = Supplier.new(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores, 123', city: '', state: 'AB', email: 'contato@abc.com')
      expect(supplier.valid?).to eq false
    end

    it 'false when state is blank' do
      supplier = Supplier.new(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores, 123', city: 'Cidade 1', state: '', email: 'contato@abc.com')
      expect(supplier.valid?).to eq false
    end

    it 'false when email is blank' do
      supplier = Supplier.new(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores, 123', city: 'Cidade 1', state: 'AB', email: '')
      expect(supplier.valid?).to eq false
    end
  end
end
