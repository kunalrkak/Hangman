class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  #def initialize()
  #end
  
    attr_accessor :word
    attr_accessor :guesses
    attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    if letter == '' or letter == nil or letter.match(/[^a-zA-Z]/)
      raise(ArgumentError)
    end
    
    if not @guesses.upcase.include? letter.upcase and not @wrong_guesses.upcase.include? letter.upcase
      if @word.upcase.include? letter.upcase
        @guesses += letter
      else 
        @wrong_guesses += letter
      end
      return true
    end
    return false
  end
  
  def word_with_guesses
    display = ''
    @word.each_char do |x|
      if @guesses.upcase.include? x.upcase
        display += x 
      else 
        display += "-" 
      end
    end
    
    return display
  end
  
  def check_win_or_lose
    if not word_with_guesses.include? '-'
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

end
