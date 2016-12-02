require 'sinatra'
mystery_number = rand(101)
get '/' do
  "The secret number is #{mystery_number}. Don't tell anyone."
end