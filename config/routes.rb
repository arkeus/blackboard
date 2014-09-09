Blackboard::Application.routes.draw do
	# Index
  root "index#index"
  post "/login", to: "index#login", as: :login
  post "/logout", to: "index#logout", as: :logout
  post "/register", to: "index#register", as: :register
  # Write
  get "/write(/:day)", to: "write#write", as: :write
  put "/write/:day/update_title", to: "write#update_title", as: :update_title
  put "/write/:day/update_content", to: "write#update_content", as: :update_content
  get "/write/share/:day", to: "write#share", as: :share_document
  # Share
  get "/share/:user_id/:day", to: "share#share", as: :shared
end
