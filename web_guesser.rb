require 'sinatra'
require 'sinatra/reloader'
number = rand(101)
secret_number_line = ''
get '/' do
  guess = params['guess']
  message = check_guess(guess, number)
  secret_number_line = correct_guess?(guess, number)
  style = style(message)
  erb :index, :locals => { :message => message, 
                           :secret_number_line => secret_number_line, 
                           :style => style
                          }
end

def check_guess(guess, number)
  if params['guess'].nil?
    message = 'Guess my mystery number.'
  elsif params['guess'].to_i < number - 5
    message = 'Way too low!'
  elsif params['guess'].to_i > number + 5
    message = 'Way too high!'
  elsif params['guess'].to_i > number
    message = 'Too high!'
  elsif params['guess'].to_i < number
    message = 'Too low!'
  elsif params['guess'].to_i == number
    message = 'You got it right!'
  end
end

def correct_guess?(guess, number)
  params['guess'].to_i == number ? secret_number_line = "The secret number was #{number}." : ''
end

def style(message)
  if message == 'Way too high!' || message == 'Way too low!'
    color = '#f02'
  elsif message == 'Too low!' || message == 'Too high!'
    color = '#f99'
  elsif message == 'You got it right!'
    color = '#0f0'
  end
 "body {\nbackground: #{color};\n}"
end