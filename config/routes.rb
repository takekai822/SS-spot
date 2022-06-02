Rails.application.routes.draw do
  #ユーザー側
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  #管理者側
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessins: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
