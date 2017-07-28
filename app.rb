require "sinatra"
require "sinatra/reloader" if development?

require "./lib/hangman"

@@hangman = Hangman.new

get "/" do
  guess = params["guess"] || ""
  restart = params["restart"]

  @@hangman = Hangman.new if restart

  @@hangman.check(guess)

  secret_word      = @@hangman.secret_word.join
  hidden_word      = @@hangman.hidden_word.join(" ")
  wrong_characters = @@hangman.wrong_characters
  guesses_left     = @@hangman.guesses_left
  game_finished    = @@hangman.game_finished
  game_result      = @@hangman.game_result

  erb :index, locals: { secret_word:      secret_word,
                        hidden_word:      hidden_word,
                        wrong_characters: wrong_characters,
                        guesses_left:     guesses_left,
                        game_finished:    game_finished,
                        game_result:      game_result }
end
