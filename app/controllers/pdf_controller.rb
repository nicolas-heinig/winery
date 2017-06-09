class PdfController < ApplicationController
  def index
  end

  def customers
    @customers = Customer.order(:last_name, :first_name)

    render pdf: 'customers', header: { right: '[page] of [topage]' }
  end
end