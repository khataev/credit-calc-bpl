Rails.application.routes.draw do
  root 'loans#index'

  get 'loans/index'

  get 'loans/edit'

  get 'loans/destroy'

  get 'loans/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
