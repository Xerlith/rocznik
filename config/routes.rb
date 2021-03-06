Rails.application.routes.draw do

  get "/404" => "errors#not_found"
  get "/500" => "errors#internal_server_error"

  resources :issues do
    get :prepare_form, on: :member
    patch :prepare, on: :member
    patch :publish, on: :member
    get :show_reviews, on: :member
    get :show_reviewers, on: :member
  end
  resources :public_issues, only: [:index,:show]
  resources :people
  resources :submissions
  resources :public_submissions, only: [:new, :create] do
    get :authors, on: :collection
    post :add_author, on: :collection
    post :cancel
  end
  resources :affiliations, only: [:new, :create, :destroy] do
    get :institutions, on: :collection
    get :countries, on: :collection
    get :departments, on: :collection
  end
  resources :authorships, only: [:new, :create, :destroy]
  resources :reviews do
    post :ask, on: :member
    post :send_reminder, on: :member
    post :ask_for_review, on: :member
  end
  resources :public_reviews do
    get :new_reviewer, on: :collection
    post :create_reviewer, on: :collection
    get :finish, on: :collection
  end
  resources :article_revisions, only: [:new, :create, :destroy]
  resources :article_revisions
  resources :articles
  resources :public_articles, only: [:show]

  devise_for :users
  mount Storytime::Engine => "/"
  root to: "blog_posts#index"
end
