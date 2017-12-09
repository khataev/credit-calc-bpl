Rails.application.routes.draw do
  root 'loans#index'

  resources :loans do
    member do
      patch :calc_profit
    end
    resources :tranches, shallow: true do
      resources :repayments, shalow: true do
        collection do
          delete :clear_repayments
          delete :delete_last_repayment
        end
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
