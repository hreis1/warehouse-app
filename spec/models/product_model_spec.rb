require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'when all attributes are present' do
      it 'false when name is blank' do
        apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
        pm = ProductModel.new(name: "", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: apple)
        expect(pm.valid?).to eq false
      end

      it 'false when weight is blank' do
        apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
        pm = ProductModel.new(name: "Iphone 11", weight: "", height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: apple)
        expect(pm.valid?).to eq false
      end
      
      it 'false when height is blank' do
        apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
        pm = ProductModel.new(name: "Iphone 11", weight: 194, height: "", width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: apple)
        expect(pm.valid?).to eq false
      end
   
      it 'false when width is blank' do
        apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
        pm = ProductModel.new(name: "Iphone 11", weight: 194, height: 150, width: "", depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: apple)
        expect(pm.valid?).to eq false
      end
   
      it 'false when depth is blank' do
        apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
        pm = ProductModel.new(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: "",sku: "IPHONEABCDEFGHIJKLNM" ,supplier: apple)
        expect(pm.valid?).to eq false
      end
   
      it 'false when sku is blank' do
        apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
        pm = ProductModel.new(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "" ,supplier: apple)
        expect(pm.valid?).to eq false
      end
   
      it 'false when supplier is blank' do
        pm = ProductModel.new(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM")
        expect(pm.valid?).to eq false
      end
    end
    
    it 'sku must be unique' do
      apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
      ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: apple)
      pm = ProductModel.new(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: apple)
      expect(pm.valid?).to eq false
    end

    it 'sku must have 20 characters' do
      apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
      pm = ProductModel.new(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKL" ,supplier: apple)
      expect(pm.valid?).to eq false
    end

    it 'weight must be greater than 0' do
      apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
      pm = ProductModel.new(name: "Iphone 11", weight: -1, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: apple)
      expect(pm.valid?).to eq false
    end

    it 'height must be greater than 0' do
      apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
      pm = ProductModel.new(name: "Iphone 11", weight: 194, height: -1, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: apple)
      expect(pm.valid?).to eq false
    end

    it 'width must be greater than 0' do
      apple = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 2", state: "CD", email: "contato@apple.com", phone: "11999999999")
      pm = ProductModel.new(name: "Iphone 11", weight: 194, height: 150, width: -1, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: apple)
      expect(pm.valid?).to eq false
    end
  end
end