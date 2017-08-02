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

  set_state

  erb :index
end

helpers do
  def set_state
    hangman = settings.hangman

    @secret_word      = hangman.secret_word.join
    @hidden_word      = hangman.hidden_word.join(" ")
    @wrong_characters = hangman.wrong_characters.join(" ")
    @guesses_left     = hangman.guesses_left
    @game_finished    = hangman.game_finished
    @game_result      = hangman.game_result
  end
end
