Rails.application.routes.draw do

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  resources :users do
    get 'export', on: :collection
    get 'datatables_index_role', on: :collection # Displays users for showed role
    patch 'account_off', on: :member
    patch 'account_on', on: :member
  end

  resources :roles do
    get 'export', on: :collection
    get 'datatables_index_user', on: :collection # Displays roles for showed user
    resources :users, only: [:create, :destroy], controller: 'roles/users'
  end    

  resources :surveys do
    get 'export', on: :collection
    get 'send_score', on: :collection 
  end

  resources :works, only: [:index] do
    post 'datatables_index', on: :collection # for User
    post 'datatables_index_trackable', on: :collection # for Trackable
    post 'datatables_index_user', on: :collection # for User
  end

  resources :charts, only: [] do
    get 'departments_by_question_pie', on: :collection
    get 'departments_by_question_column', on: :collection
    get 'departments_sum_pie', on: :collection
    get 'departments_sum_column', on: :collection
    get 'point_files', on: :collection
    get 'xml_miejsce_realizacji_tables', on: :collection
  end


  get 'datatables/lang'

  get 'static_pages/home'
  get 'static_pages/introduction'
  get 'static_pages/job_1'
  get 'static_pages/job_2'
  get 'static_pages/job_3'
  get 'static_pages/job_4'
  get 'static_pages/job_5'

  root to: 'static_pages#home'

end
