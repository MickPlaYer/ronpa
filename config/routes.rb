Rails.application.routes.draw do
  root 'ronpa#index'

  mount ActionCable.server => '/cable'
end
