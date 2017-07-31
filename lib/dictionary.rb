# Holds logic for the dictionary.
class Dictionary
  attr_reader :dictionary

  def initialize(filename)
    @dictionary = []
    prepare_dictionary(filename)
  end

  def sample
    @dictionary.sample.split("")
  end

  private

  def prepare_dictionary(filename)
    @dictionary = File.read(filename).gsub(/\n/, "  ").split("  ")
    @dictionary = @dictionary.select { |word| (4..13).cover?(word.length) }
  end
end
