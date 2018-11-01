require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'computer.rb'

require "byebug"

class BattleshipGame

  attr_accessor :player1, :player2, :current_player, :board1, :board2, :current_board

  def initialize(player1 = HumanPlayer.new, player2 = HumanPlayer.new, board1 = Board.new, board2 = Board.new)
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @board1 = board1
    @board2 = board2
    @current_board = board1
    @not_current_board = board2
  end

  def play
    setup

    until game_over?
      current_player.play_turn(@not_current_board)
      system('clear')
      switch_players!
      display_player
      display_status
      display_game_points
    end

    system('clear')
    display_game_points
    conclude

  end

  def over_half?
    return true if player1.points > 2
    return true if player2.points > 2
    false
  end

  def display_player
    puts "#{current_player.name}'S TURN"
    puts "___________________"
  end

  def display_game_points
    puts "#{player1.name} HAS SUNKEN: #{player1.points} ships"
    puts "~ ~ ~ ~ ~ ~ ~ ~ "
    puts "#{player2.name} HAS SUNKEN: #{player2.points} ships"
    puts "~ ~ ~ ~ ~ ~ ~ ~ "
    puts "SHIPS LEFT ON #{player1.name}'S BOARD: #{board2.count} ships left on the board"
    puts "~ ~ ~ ~ ~ ~ ~ ~ "
    puts "~ ~ ~ ~ ~ ~ ~ ~ "
    puts "SHIPS LEFT ON #{player2.name}'S BOARD: #{board1.count} ships left on the board"
  end

  def switch_players!
    if @current_player == @player1
      @current_player = @player2
      @current_board = @board2
      @not_current_board = @board1
    else
      @current_player = @player1
      @current_board = @board1
      @not_current_board = @board2
    end
  end

  def game_over?
    board1.won? || board2.won?
  end

  def count
    current_board.count
  end

  def display_status
    puts "#{player1.name}'S' BOARD: "
    puts "  0 1 2 3 4 5 6 7 8 9"
    board2.player_grid.each.with_index do | row, idx |
      print "#{idx}"
      row.each do |mark|
        mark.nil? ? (print " ~") : (print " #{mark}")
      end
      puts
    end

     puts "#{player2.name}'S' BOARD: "
     puts "  0 1 2 3 4 5 6 7 8 9"
     board1.player_grid.each.with_index do | row, idx |
       print "#{idx}"
       row.each do |mark|
         mark.nil? ? (print " ~") : (print " #{mark}")
       end
       puts
     end
  end


  def setup
    display_player
    display_game_points
    display_status
    # until board.grid.flatten.count(:s) == 10
    #   board.place_random_ship
    # end
    puts "#{current_player.name}, please place your ships"
    @current_player.place_ship(@current_board)
    switch_players!
    (puts "#{current_player.name}, please place your ships") unless @current_player.is_a?(ComputerPlayer)
    @current_player.place_ship(@current_board)
    switch_players!
    system('clear')
    display_player
    display_status
    display_game_points
  end

  def conclude
    if player1.points > player2.points
      puts "#{player1.name} HAS WON!"
    elsif player1.points == player2.points
      puts "IT'S A TIE. PLAY AGAIN"
    else
      puts "#{player2.name} HAS WON!"
    end
  end

end
