require_relative "board.rb"
require "byebug"

class ComputerPlayer
  attr_accessor :name, :points

  def initialize(name = "Computer")
    @name = name.upcase
    @points = 0
  end

  def get_play(board)
    avail_pos = []
    (0..9).each do |row|
      (0..9).each do |col|
        pos = [row,col]
        avail_pos << pos if board[pos].nil? || board[pos] == :s
      end
    end
    avail_pos.sample
  end

  def place_ship(board)
    # byebug

    rand_row = rand(board.grid.length)
    rand_col = rand(board.grid.length)

    until board.grid.flatten.count(:s) == 5
      board.grid[rand_row][rand_col] = :s if board.grid[rand_row][rand_col] == nil
    end
  end

  def play_turn(board)
    pos = get_play(board)
    if board[pos] == :s
      @points += 1
      board.attack(pos)
    else
      board.attack(pos)
    end
  end


end
