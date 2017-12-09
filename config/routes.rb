Rails.application.routes.draw do
  root 'loans#index'

  resources :loans do
    resources :tranches, shallow: true
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
