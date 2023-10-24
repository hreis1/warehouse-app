class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @order = Order.new
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
  end

  def create
    order_params = params.require(:order).permit(:estimated_delivery_date, :supplier_id, :warehouse_id)
    @order = Order.new(order_params)
    @order.user = current_user
    if @order.save
      return redirect_to @order, notice: 'Pedido registrado com sucesso!'
    end
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
    flash.now[:alert] = 'Não foi possível registrar o pedido'
    render :new
  end

  def show
    @order = Order.find(params[:id])
  end
end