Rails.application.routes.draw do
  
  root "restaurants#index"
  
  namespace :admin do
    root "restaurants#index"
end

end

