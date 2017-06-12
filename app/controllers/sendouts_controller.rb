class SendoutsController < ApplicationController
  def new
    @wines_with_orders = Order.includes(:wine).where(shipped: false).group_by(&:wine)
    @total = @wines_with_orders.values.flatten.sum(&:full_price)
  end

  def create
    orders = Order.includes(:wine).where(shipped: false)

    ProviderMailer.orders_mail(params[:custom_text], orders).deliver_now

    orders.update_all(shipped: true)

    redirect_to root_path, notice: 'Bestellungen abgeschickt!'
  end
end
