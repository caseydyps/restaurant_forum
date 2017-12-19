class Admin::RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash.now[:alert] = "restaurant was failed to create"
      render :new
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address, :description)
  end
before_action :set_restaurant, only: [:show, :edit, :update]

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant was successfully updated"
      redirect_to admin_restaurant_path(@restaurant)
    else
      flash.now[:alert] = "restaurant was failed to update"
      render :edit
    end
  end
  
  private
   #其他程式碼
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end


  
end
