class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    # SALVADOR
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-'*word.length
    # SALVADOR
  end

  # SALVADOR
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  # SALVADOR

  def guess new_guess
    character = /[[:alpha:]]/
    raise ArgumentError.new("Did not supply a letter") if not (new_guess =~ character)
    new_guess.downcase!
    if new_guess =~ character and !self.guesses.include?(new_guess) and !self.wrong_guesses.include?(new_guess)
      unless self.word.include? new_guess
        self.wrong_guesses=(self.wrong_guesses() + new_guess)
      else
        self.update_display_word(new_guess)
        self.guesses=(self.guesses() + new_guess) 
      end
    else
      false
    end
  end
  
  def update_display_word guess
    i = -1
    all = []
    x = self.word
    while i = x.index(guess,i+1)
      all << i
    end
    current_display = self.word_with_guesses
    all.each { |x| current_display[x] = guess }
    return nil
  end

  def word_with_guesses
    @word_with_guesses
  end

  def guess_several_letters letters
    letters.split('').each { |c| 
      self.guess(c)
    }
  end

  def check_win_or_lose
    if not self.word_with_guesses.include?('-')
      :win
    elsif self.wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
