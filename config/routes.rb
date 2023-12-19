Rails.application.routes.draw do
  namespace :api do
    get 'local_plan_steps/index_by_robot/:robot_id', to: "local_plan_steps#index_by_robot"
    post 'local_plan_steps', to: "local_plan_steps#create"
    put 'local_plan_steps/:id', to: "local_plan_steps#update"
    delete 'local_plan_steps/:robot_id', to: "local_plan_steps#delete"
    delete 'local_plan_steps/step/:robot_id', to: "local_plan_steps#delete_step"
  end

  get 'local_plan_steps/:robot_id', to: "local_plan_steps#index"

  get 'hello/world'
  get 'hello/worldGet', to: "hello#index" 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
