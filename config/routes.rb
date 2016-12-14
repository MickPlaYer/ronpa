Rails.application.routes.draw do
  root 'ronpa#index'

  resources :sentences
  
  mount ActionCable.server => '/cable'
end
