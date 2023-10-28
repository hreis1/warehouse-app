class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: [:show, :edit, :update]
  
  def index
    @orders = current_user.orders
  end
  
  def new
    @order = Order.new
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
  end

  def create
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

  def show; end

  def edit
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
  end

  def update
    if @order.update(order_params)
      return redirect_to @order, notice: 'Pedido atualizado com sucesso'
    end
    @suppliers = Supplier.all
    @warehouses = Warehouse.all
    flash.now[:alert] = 'Não foi possível atualizar o pedido'
    render :edit
  end

  def search
    @query = params[:query]
    if @query.blank?
      return redirect_to request.referrer, alert: 'Digite algo para buscar'
    end
    @orders = Order.where('code LIKE ?', "%#{@query}%")
  end

  private

  def set_order_and_check_user
    @order = Order.find(params[:id])
    if @order.user != current_user
      return redirect_to root_path, alert: 'Você não tem permissão para acessar essa página'
    end
  end

  def order_params
    params.require(:order).permit(:estimated_delivery_date, :supplier_id, :warehouse_id)
  end
end