# require_relative "board.rb"

class HumanPlayer

  attr_accessor :name, :points

  def initialize(name = get_name)
    @name = name
    @points = 0
  end

  def get_name
    puts "What is your name?"
    new_name = gets.chomp
    new_name.upcase
  end

  def get_play
    puts "choose a row position"
    row = gets.chomp
    puts "choose a column position"
    col = gets.chomp
    return [row,col]
  end

  def place_ship(board)
    5.times do

      pos = self.get_play
      until board.valid_move?(pos)
        puts "Invalid move. Try again"
        pos = self.get_play
      end
      pos = pos.map(&:to_i)
      board[pos] = :s
    end
  end

  def play_turn(board)
    pos = self.get_play
    until board.valid_move?(pos)
      puts "Invalid move. Try again"
      pos = self.get_play
    end
    pos = pos.map(&:to_i)

    if board[pos] == :s
      @points += 1
      puts "You destroyed a ship! Fuck yea!"
    else
      puts "That was an empty space. No ship was destroyed"
    end
    board.attack(pos)
  end

end
