Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :categories, only: [:create]
      resources :ideas, only: [:create, :index]
    end
  end
end
