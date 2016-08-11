Rails.application.routes.draw do
  namespace 'v1' do
    resources :projects
    resources :workers
    resources :macro_tasks
    resources :micro_tasks
    resources :break_points
  end
end
