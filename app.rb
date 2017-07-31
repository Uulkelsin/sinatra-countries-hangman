require "sinatra"
require "sinatra/reloader" if development?

require "./lib/hangman"
require "./lib/dictionary"

set :hangman, Hangman.new

get "/" do
  guess   = params["guess"] || ""
  restart = params["restart"]

  settings.hangman = Hangman.new if restart

  settings.hangman.check(guess)

  secret_word      = settings.hangman.secret_word.join
  hidden_word      = settings.hangman.hidden_word.join(" ")
  wrong_characters = settings.hangman.wrong_characters
  guesses_left     = settings.hangman.guesses_left
  game_finished    = settings.hangman.game_finished
  game_result      = settings.hangman.game_result

  erb :index, locals: { secret_word:      secret_word,
                        hidden_word:      hidden_word,
                        wrong_characters: wrong_characters,
                        guesses_left:     guesses_left,
                        game_finished:    game_finished,
                        game_result:      game_result }
end
