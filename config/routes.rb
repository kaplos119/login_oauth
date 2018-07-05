Kapil::Application.routes.draw do
  match '/login' => 'login#index', :only => [:get]
  match '/login/callback' => 'login#callback_handling', :only => %i[get post]
end
