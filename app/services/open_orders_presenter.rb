class OpenOrdersPresenter
  def initialize()
    @orders = Order.includes(:wine).all
    @customers = Customer.all
  end

  def customers_with_open_orders
    @customers.select do |customer|
      orders_for_customer(customer).select { |order| order.shipped == false }.any?
    end.sort_by(&:last_name)
  end

  def orders_for_customer(customer)
    @orders.select do |order|
      customer.id == order.customer_id
    end.sort_by(&:wine_name)
  end

  def open_orders_for_customer(customer)
    orders_for_customer(customer).select { |order| order.shipped == false }
  end

  def sum_price_of_open_orders(customer)
    open_orders_for_customer(customer).sum(&:full_price)
  end
end
