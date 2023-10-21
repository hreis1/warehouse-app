class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update]
  before_action :authenticate_user!

  def index
    @suppliers = Supplier.all
  end
  
  def show
    @product_models = @supplier.product_models
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      return redirect_to @supplier, notice: "Fornecedor cadastrado com sucesso"
    end
      flash.now[:alert] = "Não foi possível cadastrar o fornecedor"
      render :new
  end

  def edit; end

  def update
    if @supplier.update(supplier_params)
      return redirect_to @supplier, notice: "Fornecedor atualizado com sucesso"
    end
      flash.now[:alert] = "Não foi possível atualizar o fornecedor"
      render :edit
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, :phone)
  end
end