require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'when all attributes are present' do
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

      it 'false when phone is blank' do
        supplier = Supplier.new(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com', phone: '')
        expect(supplier.valid?).to eq false
      end
    end
    context 'registration_number validation' do
      it 'false when registration_number is not unique' do
        Supplier.create!(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores, 123', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com', phone: '11999999999')
        supplier = Supplier.new(corporate_name: 'Fornecedor XYZ', brand_name: 'XYZ', registration_number: '1234567891011', full_address: 'Rua das Flores, 123', city: 'Cidade 2', state: 'CD', email: 'contato@xyz.com', phone: '11999999999')
        expect(supplier).not_to be_valid
      end
      it 'false when registration_number length is different from 13' do
        supplier = Supplier.new(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '123456789101', full_address: 'Rua das Flores, 123', city: 'Cidade 1', state: 'AB', email: 'contato@xyz.com')
        expect(supplier).not_to be_valid
      end
    end

    it 'false when phone format is invalid' do
      supplier = Supplier.new(corporate_name: 'Fornecedor ABC', brand_name: 'ABC', registration_number: '1234567891011', full_address: 'Rua das Flores', city: 'Cidade 1', state: 'AB', email: 'contato@abc.com', phone: '119999999A9')
      expect(supplier).not_to be_valid
    end
  end
end