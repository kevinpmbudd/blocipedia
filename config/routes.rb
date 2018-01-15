Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations' }
  devise_scope :user do
    post '/downgrade' => 'users/registrations#downgrade', as: :downgrade
  end

  resources :wikis do
    resources :collaborators, only: :create
  end

  resources :charges, only: [:new, :create]

  root 'welcome#index'
end
