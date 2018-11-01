class Board
  attr_accessor :grid, :player_grid

  def initialize(grid = Board.default_grid, player_grid = Board.default_grid)
    @grid = grid
    @player_grid = player_grid
  end

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def count
    grid.flatten.count(:s)
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos, mark)
    @grid[pos[0]][pos[1]] = mark
  end

  def empty?(pos = nil)
    if pos == nil
      grid.flatten.all? { |position| position.nil? }
    else
      row = pos[0]
      col = pos[1]
      grid[row][col].nil?
    end
  end

  def full?
    grid.flatten.none? { |position| position == nil }
  end

  def attack(pos)
    if self[pos] == :s
      self.player_grid[pos[0]][pos[1]] = :s #<- can we use bracket notation here?
    else
      self.player_grid[pos[0]][pos[1]] = :x #<- ...and here?
    end
    self[pos] = :x
  end

  def valid_move?(pos)
    pos_to_i = pos.map(&:to_i)
    row = pos_to_i[0]
    col = pos_to_i[1]
    return false if player_grid[row][col] == :s || player_grid[row][col] == :x
    true
  end

  def valid_input?(pos)
    range = [*("0".."9")]

    pos.all? do |num|
      range.include?(num)
    end
  end

  def count_sunken_ships
    player_grid.flatten.count(:s)
  end

  def won?
    grid.flatten.none? {|position| position == :s}
  end

end
