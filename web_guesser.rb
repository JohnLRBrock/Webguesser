require 'sinatra'
require 'sinatra/reloader'
mystery_number = rand(101)
get '/' do
  erb :index, :locals => {:mystery_number => mystery_number }
end