Phonix::Application.routes.draw do
  get "deleted_youtube_videos/index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :deleted_youtube_videos , only: [:index], :defaults => { :format => 'json' }
  resources :youtube_videos, only: [:index, :show], :defaults => { :format => 'json' }
  root 'admin/youtube_videos#index'
end
