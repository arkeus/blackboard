Blackboard::Application.routes.draw do
	# Index
  root "index#index"
  post "/login", to: "index#login", as: :login
  post "/logout", to: "index#logout", as: :logout
  post "/register", to: "index#register", as: :register
  # Write
  get "/write(/:day)", to: "write#write", as: :write
end
