class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def show; end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save
      return redirect_to root_path, notice: "Galpão cadastrado com sucesso!"
    end
    flash.now[:notice] = "Galpão não cadastrado"
    render :new
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params)
      return redirect_to warehouse_path(@warehouse), notice: "Galpão atualizado com sucesso!"
    end
    flash.now[:notice] = "Galpão não atualizado"
    render :edit
  end

  def destroy
    @warehouse.destroy
    redirect_to root_path, notice: "Galpão deletado com sucesso!"
  end

  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :cep, :description)
  end
end