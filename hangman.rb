require "sinatra"
require "sinatra/reloader" if development?

get "/" do
  message = "Hello again!"

  erb :index, locals: { message: message }
end
