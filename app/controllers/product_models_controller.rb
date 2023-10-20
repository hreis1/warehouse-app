class ProductModelsController < ApplicationController
  before_action :set_product_model, only: [:show]

  def index
    @product_models = ProductModel.all
  end
  
  def show; end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)
    @suppliers = Supplier.all

    if @product_model.save
      redirect_to @product_model, notice: 'Modelo de Produto cadastrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível cadastrar o Modelo de Produto'
      render :new
    end
  end

  private

  def product_model_params
    params.require(:product_model).permit(:name, :sku, :height, :width, :depth, :weight, :supplier_id)
  end

  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end
end