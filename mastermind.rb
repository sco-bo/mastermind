module Mastermind
  
  class Player
    attr_accessor :color_choices

    def initialize(color_choices)
      @color_choices = color_choices
    end

  end

  class Game
    attr_accessor :computer, :human, :color_choices  

    def initialize
      play_game
    end

    def play_game
      @computer = Player.new(get_random_choice)
      welcome
      instructions
      @human = Player.new(get_human_choice)
      compare_flow
      @guess_iterations = 1
      guess
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
    end

    def compare_with_index
      matches = computer.color_choices.zip(human.color_choices).map {|x, y| x == y}
      matches.count(true)
    end

    def matches_with_index
      puts "You have #{compare_with_index} correct color(s) in the correct spot."
    end

    def compare_flow
      compare_with_index
      matches_with_index
    end

    def victory
      if compare_with_index == 4
        puts "You've won!"
        true
      end
    end

    def guess_again_message
        puts "Guess again, please choose four colors, separated by a comma (ex: B,O,Y,G)"
    end

    def guess
      while @guess_iterations <= 12 && !victory
        guess_again_message
        human.color_choices = get_human_choice
        compare_flow
        @guess_iterations += 1
      end
    end

  end

  class Board

    def initialize
    end

  end

  
end

Mastermind::Game.new