load "battleship.rb"
# g = BattleshipGame.new
load "battleship.rb"
g = BattleshipGame.new(HumanPlayer.new, ComputerPlayer.new, Board.new, Board.new)
g.play
