Rails.application.routes.draw do
devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}

#管理者サイド
get 'admin/homes/top' => 'admin/homes#top', as: 'admin_top'

namespace :admin do
	resources :tags, only: [:index, :create, :edit, :update]
	resources :notices
end


#利用者サイド
get 'users/:id/password' => 'user/users#password',as: 'password'

scope module: :user do
	resources :posts, only: [:index, :show, :new, :create, :destroy] do
	 resource :favorites, only: [:create, :destroy]
   resource :good_places, only: [:create, :destroy]
   resources :comments, only: [:create, :destroy]
	end
  resources :schedules, only: [:index, :create, :destroy]
  resources :users, only: [:show, :edit, :update]
end

end
