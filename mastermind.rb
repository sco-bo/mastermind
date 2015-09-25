
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
      welcome
    end

    def play_game
      @available = [0,1,2,3]
      @computer = Player.new(get_random_choice)
      human_instructions
      choose_message
      @human = Player.new(get_human_choice)
      compare_with_index
      @@guess_iterations = 1
      @@guesses_hash = Hash.new
      guess_loop_human
    end

    def comp_guesses
      @available = [0,1,2,3]
      choose_message
      @human = Player.new(get_human_choice)
      @computer = Player.new(get_random_choice)
      compare_with_index
      @@guess_iterations = 1
      @@guesses_hash = Hash.new
      guess_loop_comp
    end

    def welcome
      puts "Welcome to Mastermind."
      puts "========================================================"
      who_creates_code
    end

    def human_instructions
      puts "You will be given 12 chances to guess the code that was chosen by the computer."
      puts "========================================================"
      puts "There are 6 colors from which to choose (Red, Blue, Green, Yellow, Orange, Purple)"
      puts "========================================================"
    end

    def who_creates_code
      puts "Would you like to choose the code and have the computer guess? (yes/no)"
      chooser = gets.chomp.downcase 
      input_validation(chooser)
    end

    def input_validation(response)
      if response == "yes"
        comp_guesses
      elsif response == "no"
        play_game
      else
        puts "Response not valid"
        who_creates_code
      end
    end

    def choose_message
      puts "Please choose four colors, separated by a comma (ex: B,O,Y,G)"  
    end

    def get_random_choice
      puts "The computer is now choosing..."
      colors = ["R", "B", "G", "Y", "O", "P"]
      choice = colors.sample(4)
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
          @available -= [index]
        elsif color_match(n) && color_available(n)
          @color_count += 1
        end
      end
      @count_index
    end

    def color_match(color)
      human.color_choices.include?(color)
    end

    def color_available(color)
      @available.include?(human.color_choices.index(color))
    end

    def matches_message
      "You have #{@count_index} color(s) in the right spot and #{@color_count} correctly chosen color(s)"
    end

    def guess_loop_comp
      while @@guess_iterations <= 12 && !victory
        store_guess_comp
        board
        puts matches_message
        computer.color_choices = new_choice
        compare_with_index
        @@guess_iterations += 1
      end
      game_over
    end

    def guess_loop_human
      while @@guess_iterations <= 12 && !victory
        store_guess_human
        board
        puts matches_message
        guess_again_message
        human.color_choices = get_human_choice
        compare_with_index
        @@guess_iterations += 1
      end
      game_over
    end

    def store_guess_human
      @@guesses_hash[human.color_choices] = matches_message
    end

    def store_guess_comp
      @@guesses_hash[computer.color_choices] = matches_message
    end

    def board
      Board.new
    end

    def guess_again_message
      puts "Guess again, please choose four colors, separated by a comma (ex: B,O,Y,G)"
    end

    def available
      @available.shuffle!.pop
    end
      
    def new_choice
      colors = ["R", "B", "G", "Y", "O", "P"]
      new_color = []
      computer.color_choices.each_with_index do |n, index|
        if human.color_choices[index] != n && !color_available(n)
          new_color[index] = colors.sample
        else
          new_color[index] = n
        end
      end
      new_color
      keep_color(new_color)
    end

    def keep_color(new_array)
      computer.color_choices.each do |i|
        if color_available(i) 
          new_array[available.to_i] = i
        end
      end
      p new_array
      new_array
    end

    def victory
      if compare_with_index == 4
        store_guess_comp
        board
        puts "Victory!"
        true
      end
    end

    def game_over
      if @@guess_iterations > 12 && !victory
        puts "Game Over"
      end
    end

  end

  class Board < Game

    def initialize
      render_board
    end

    def render_board
      (13- @@guess_iterations.to_i).times do 
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