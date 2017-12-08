class CustomersController < ApplicationController
  before_action :authenticate_user!

  def index
    @customers = Customer.all
  end

  def search
    results = Customer.search(params.fetch(:query), limit: 8, fields: [:id, :first_name, :last_name], match: :word_start)
    render json: results
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer, notice: 'Kunde angelegt!'
    else
      render :new
    end
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Kunde gespeichert!'
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])

    @customer.destroy

    redirect_to customers_url, notice: 'Kunde gelöscht!'
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :address, :phone, :email)
  end
end
