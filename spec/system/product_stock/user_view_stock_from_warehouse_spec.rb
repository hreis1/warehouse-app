require "rails_helper"

describe "User view stock from warehouse" do
  it "on home page" do
    user = User.create!(name: "Fulano Sicrano", email: "fs@email.com", password: "123456")
    login_as(user)

    supplier = Supplier.create!(corporate_name: "Apple", brand_name: "Apple", registration_number: "1234567891011", full_address: "Rua das Flores, 456", city: "Cidade 1", state: "CD", email: "contato@apple.com", phone: "11999999999")

    warehouse = Warehouse.create!(name: 'Galpão 1', code: 'ABC', address: 'Rua 1', area: 1000, city: 'Cidade A', description: 'Galpão com 1000m²', cep: '12345-678')

    product1 = ProductModel.create!(name: "Iphone 11", weight: 194, height: 150, width: 75, depth: 1,sku: "IPHONEABCDEFGHIJKLNM" ,supplier: supplier)
    product2 = ProductModel.create!(name: "S10", weight: 157, height: 70, width: 150, depth: 1,sku: "SAMSUNGABCDEFGHIJKLM" ,supplier: supplier)
    product3 = ProductModel.create!(name: "Notebook Dell", weight: 2000, height: 200, width: 300, depth: 20,sku: "NOTEBOOKABCDEFGHIJKL" ,supplier: supplier)
    
    order = Order.create!(supplier: supplier, warehouse: warehouse, estimated_delivery_date: Date.today.next_day, user: user)

    3.times { StockProduct.create!(order: order, product_model: product1, warehouse: warehouse) }
    2.times { StockProduct.create!(order: order, product_model: product2, warehouse: warehouse) }

    visit root_path
    click_on warehouse.name

    expect(page).to have_content("Itens em estoque")
    expect(page).to have_content("3 x #{product1.name}")
    expect(page).to have_content("2 x #{product2.name}")
    expect(page).not_to have_content("#{product3.name}")
  end

  it "on warehouse page" do
    # TODO
  end
end
