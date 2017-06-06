class WinesController < ApplicationController
  before_action :authenticate_user!

  def index
    @wines = Wine.all
  end

  def show
    @wine = Wine.find(params[:id])
  end

  def new
    @wine = Wine.new
  end

  def edit
    @wine = Wine.find(params[:id])
  end


  def create
    @wine = Wine.new(wine_params)

    if @wine.save
      redirect_to @wine, notice: 'Wein gespeichert!'
    else
      render :new
    end
  end

  def update
    @wine = Wine.find(params[:id])

    if @wine.update(wine_params)
      redirect_to @wine, notice: 'Wein gespeichert!'
    else
      render :edit
    end
  end

  def destroy
    @wine = Wine.find(params[:id])

    @wine.destroy

    redirect_to wines_url, notice: 'Wein gelöscht!'
  end

  private

  def wine_params
    params.require(:wine).permit(:name, :volume, :bottle_price, :box_price, :year, :from, :wine_type)
  end
end
