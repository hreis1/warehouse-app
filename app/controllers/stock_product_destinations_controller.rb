class StockProductDestinationsController < ApplicationController
  def create
    warehouse = Warehouse.find(params[:warehouse_id])
    product_model = ProductModel.find(params[:product_model_id])
    stock_product = StockProduct.where(warehouse: warehouse, product_model: product_model).where.missing(:stock_product_destination).first

    if stock_product != nil
      stock_product.create_stock_product_destination!(recipient: params[:recipient], address: params[:address])
      redirect_to warehouse, notice: "Saída registrada com sucesso"
    end

  end
end