class PdfController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def customers
    @customers = Customer.order(:last_name, :first_name)

    render pdf: 'customers', header: { right: '[page] of [topage]' }
  end

  def orders
    @presenter = OpenOrdersPresenter.new

    render pdf: 'orders', header: { right: '[page] of [topage]' }
  end
end
