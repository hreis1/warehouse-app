class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_and_check_user, only: %i[new create]

  def new
    @order_item = OrderItem.new
    @product_models = @order.supplier.product_models
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    @order_item.order = @order
    if @order_item.save
      return redirect_to @order, notice: 'Item adicionado com sucesso'
    end
    @product_models = @order.supplier.product_models
    flash.now[:alert] = 'Não foi possível adicionar o item'
    render :new
  end

  private

  def order_item_params
    params.require(:order_item).permit(:product_model_id, :quantity)
  end

  def set_order_and_check_user
    @order = Order.find(params[:order_id])
    unless @order.user == current_user
      redirect_to root_path, alert: 'Você não tem permissão para acessar essa página'
    end
  end
end