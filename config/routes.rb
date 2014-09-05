Woodpecker::Application.routes.draw do
  match "/"                          => "images#index",    via: :get,  constraints: { format: :html }
  match "/:q"                        => "images#index",    via: :get,  constraints: { format: :html }
  match "/images/:id"                => "images#index",    via: :get,  constraints: { format: :html }

  scope "api" do
    scope "0.9" do
      resources :images, only: [:index, :show]
    end
  end

  root to: "images#index"
end
