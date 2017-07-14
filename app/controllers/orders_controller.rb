class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @only_open = params[:open]
    @orders = @only_open ? Order.includes(:wine, :customer).where(shipped: false) : Order.includes(:wine, :customer).all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new
    set_attributes_and_association_from_params

    if @order.save
      redirect_to @order, notice: 'Bestellung gespeichert!'
    else
      render :new
    end
  end

  def update
    @order = Order.find(params[:id])
    set_attributes_and_association_from_params

    if @order.save
      redirect_to @order, notice: 'Änderungen gespeichert!'
    else
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])

    @order.destroy

    redirect_to orders_url, notice: 'Bestellung gelöscht!'
  end

  private

  def set_attributes_and_association_from_params
    @order.attributes = {
      boxes: order_params[:boxes],
      bottles: order_params[:bottles],
      shipped: order_params[:shipped]
    }

    first_name, last_name = order_params[:customer_name].split(' ')
    @order.customer = Customer.find_by(first_name: first_name, last_name: last_name)

    @order.wine = Wine.find(order_params[:wine_id])
  end

  def order_params
    params.require(:order).permit(:customer_name, :wine_id, :boxes, :bottles, :shipped)
  end
end
