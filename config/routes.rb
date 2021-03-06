# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index', as: 'home'
  match 'friendships/search' => 'friendships#search', via: :get, as: 'friendships_search'
  match 'friendships/create' => 'friendships#create', via: :post, as: 'friendships_create'
  match 'friendships/delete/:friend_id' => 'friendships#destroy', via: :delete, as: 'friendships_delete'
  resources :posts
  match 'users/:id' => 'users#show', via: :get, as: 'profile_page'
  match 'users/:id' => 'users#remove', via: :delete, as: 'delete-user'
  resources :comments, except: [:new]
  get 'posts/:id/comments/new' => 'comments#new'
  resources :post_likes
  match 'posts/:id/post_likes/new' => 'post_likes#new', via: :get, as: 'post_likes_new'
  resources :comment_likes
  match 'comments/:id/comment_likes/new' => 'comment_likes#new', via: :get, as: 'comment_likes_new'
end
