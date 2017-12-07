class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  #這裏會有原來的程式碼
end
