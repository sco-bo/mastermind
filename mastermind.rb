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
      compare_with_index
      @@guess_iterations = 1
      @@guesses_hash = Hash.new
      store_guess_with_message
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
      @count_index = 0
      @color_count = 0
      computer.color_choices.each_with_index do |n, index|
        if human.color_choices[index] == n
          @count_index += 1  
        elsif human.color_choices.include?(n)
          @color_count += 1
        end
      end
      @count_index
    end

    def matches_message
      "You have #{@count_index} color(s) in the right spot and #{@color_count} correctly chosen color(s)"
    end

    def store_guess_with_message
      @@guesses_hash[human.color_choices] = matches_message
    end

    def board
      Board.new
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
      while @@guess_iterations < 12 && !victory
        store_guess_with_message
        board
        puts matches_message
        guess_again_message
        human.color_choices = get_human_choice
        compare_with_index
        @@guess_iterations += 1
      end
      puts "Game Over"
    end

  end

  class Board < Game

    def initialize
      render_board
    end

    def render_board
      (12- @@guess_iterations.to_i).times do 
        puts "| X | X | X | X |"
      end
      display_hash
    end

    def display_hash
      @@guesses_hash.each do |k,v|
        puts "================="
        puts "| " + k.join(" | ") + " | " + v
        puts "================="
      end
    end

  end

  
end

Mastermind::Game.new