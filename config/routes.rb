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

scope module: :user do
	resources :posts, only: [:index, :show, :new, :create, :destroy]
end

end
