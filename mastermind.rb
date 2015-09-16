module Mastermind
  
  class Player
    attr_accessor :color_choices

    def initialize(color_choices)
      @color_choices = color_choices
    end

  end

  class Game
    attr_reader :computer, :human, :color_choices  

    def initialize
      play_game
      compare_with_index
    end

    def play_game
      @computer = Player.new(get_random_choice)
      welcome
      instructions
      @human = Player.new(get_human_choice)
      compare_with_index
      @guess_iterations = 1
      guesses
    end

    def welcome
      puts "Welcome to Mastermind. The computer is now choosing its colors..."
      puts "========================================================"
    end

    def instructions
      puts "You will be given 12 chances to guess the code that was chosen by the computer."
      puts "========================================================"
      puts "There are 6 colors from which to choose (Red, Blue, Green, Yellow, Orange, Purple)"
      puts "========================================================"
      puts "Please choose four colors, separated by a comma (ex: B,O,Y,G)"
    end

    def get_random_choice
      colors = ["R", "B", "G", "Y", "O", "P"]
      choice = colors.sample(4)
      p choice
    end

    def get_human_choice
      answer = gets.chomp.upcase
      human_colors = answer.split(",")
      p human_colors
    end

    def guesses
      while @guess_iterations <= 12
        compare_with_index
        @guess_iterations += 1
      end
    end

    def compare_with_index
     matches = computer.color_choices.zip(human.color_choices).map {|x, y| x == y}
      p matches
    end

  end

  class Board

    def initialize
    end

  end

  
end

Mastermind::Game.new