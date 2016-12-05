require 'sinatra'
require 'sinatra/reloader'
@@number = rand(101)
secret_number_line = ''
@@guesses = 5
get '/' do
  guess = params['guess'].nil? ? nil : params['guess'].to_i
  cheat_mode = cheat_mode? ? "The number is #{@@number}." : ''
  message = check_guess(guess)
  style = style(guess)
  erb :index, :locals => { :message => message, 
                           :style => style,
                           :cheat_mode => cheat_mode
                         }
end


def check_guess(guess)
  @@correct = false
  if guess.nil?
    message = 'Guess my mystery number. You have 5 turns.'
  elsif correct_guess?(guess)
    @@correct = true
    @@guesses = 5
    @@number = rand(101)
    'You got it right! I have a new number. You have 5 turns.'
  elsif @@guesses < 2
    @@guesses = 5
    @@number == rand(101)
    'You ran out of guesses! I have a new number. You have 5 turns.'
  elsif guess < @@number - 5
    @@guesses -= 1
    "Way too low! You have #{@@guesses} turns."
  elsif guess > @@number + 5
    @@guesses -= 1
    "Way too high! You have #{@@guesses} turns."
  elsif guess > @@number
    @@guesses -= 1
    "Too high! You have #{@@guesses} turns."
  elsif guess < @@number
    @@guesses -= 1
    "Too low! You have #{@@guesses} turns."
  end
end

def correct_guess?(guess)
  guess == @@number
end

def style(guess)
  if @@correct
    color = '#0f0'
  elsif params['guess'].nil?
    color = '#99f'
  elsif guess < @@number - 5 || guess > @@number + 5
    color = '#f02'
  elsif guess < @@number || guess > @@number
    color = '#f99'
  end
 "body {\nbackground: #{color};\n}"
end

def cheat_mode?
  params['cheat']
end