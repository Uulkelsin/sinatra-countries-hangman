require "sinatra"
require "sinatra/reloader" if development?

require "./lib/hangman"
require "./lib/dictionary"

configure do
  @@dictionary = Dictionary.new("./lib/dictionary.txt")
  set :hangman, Hangman.new(@@dictionary)
end

get "/" do
  guess   = params["guess"] || ""
  restart = params["restart"]

  settings.hangman = Hangman.new(@@dictionary) if restart

  settings.hangman.check(guess)

  @secret_word      = settings.hangman.secret_word.join
  @hidden_word      = settings.hangman.hidden_word.join(" ")
  @wrong_characters = settings.hangman.wrong_characters.join(" ")
  @guesses_left     = settings.hangman.guesses_left
  @game_finished    = settings.hangman.game_finished
  @game_result      = settings.hangman.game_result

  erb :index
end
