Rails.application.routes.draw do
devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations',
  passwords: 'users/passwords'
}

# guest_login
devise_scope :admin do
    post 'admins/guest_sign_in', to: 'admins/sessions#new_guest'
end

devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
end

#管理者サイド
get 'admin/homes/top' => 'admin/homes#top', as: 'admin_top'

namespace :admin do
  resources :users, only: [:index, :show, :edit, :update]
	resources :tags, only: [:index, :create, :edit, :update]
	resources :notices
  resources :posts, only: [:show, :update]
end


#利用者サイド
root 'user/homes#top'
get 'user/homes/notices/:id' => 'user/homes#notice',as: 'notice'
get 'users/:id/password' => 'user/users#password',as: 'password'
get 'users/favorite' => 'user/users#favorite',as: 'favorite'
get 'users/good_place' => 'user/users#good',as: 'good_place'
get 'users/japan_map' => 'user/posts#japan_map',as: 'japan_map'
get 'users/user_map' => 'user/users#user_map',as: 'user_map'

scope module: :user do
	resources :posts, only: [:index, :show, :new, :create, :destroy] do
	 resource :favorites, only: [:create, :destroy]
   resource :good_places, only: [:create, :destroy]
   resource :alerts,only: [:create, :destroy]
   resources :comments, only: [:create, :destroy]
   collection do
    match 'search' => 'posts#search',via: [:get, :post]
   end
	end
  resources :schedules, only: [:index, :create, :destroy]
  resources :users, only: [:show, :edit, :update]
end

end
