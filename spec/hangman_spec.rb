require "./lib/dictionary"

describe Hangman do
  let(:hangman)          { described_class.new }
  let(:secret_word)      { hangman.secret_word }
  let(:hidden_word)      { hangman.hidden_word }
  let(:wrong_characters) { hangman.wrong_characters }
  let(:guesses_left)     { hangman.guesses_left }
  let(:game_result)      { hangman.game_result }
  let(:characters)       { ("a".."z").to_a }

  describe "#check" do
    context "when the character is correct" do
      it "adds character to hidden word" do
        guess = secret_word.sample
        hangman.check(guess)
        expect(hidden_word).to include(guess)
      end
    end

    context "when the character is not correct" do
      it "adds character to wrong characters" do
        guess = characters.select { |chr| chr unless secret_word.include?(chr) }
                          .first

        hangman.check(guess)
        expect(wrong_characters).to include(guess)
      end
    end

    context "when the word entered is correct" do
      it "saves :player_wins in @result" do
        hangman.check(secret_word.join)
        expect(game_result).to be(:player_wins)
      end
    end

    context "when the word entered is not correct" do
      it "saves :player_loses in @result" do
        guess = secret_word.inject("") do |memo, _character|
          memo + characters.sample
        end
        hangman.check(guess)
        expect(game_result).to be(:player_loses)
      end
    end
  end
end
