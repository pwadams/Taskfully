Rails.application.routes.draw do
    root 'welcome#index'

   get 'sign-up', to: 'registrations#new'
   post 'sign-up', to: 'registrations#create'
   get 'sign-in', to: 'authentication#new'
   post 'sign-in', to: 'authentication#create'
   get 'sign-out', to: 'authentication#destroy'

   get '/terms', to: 'terms#index'
   get '/about', to: 'about#index'
   get '/faq', to: 'common_questions#index'

   resources :users

   resources :projects do
      resources :tasks
      resources :memberships
end
end
