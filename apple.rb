# frozen_string_literal: true

class Apple
  def initialize(grid)
    @grid = grid
    @name = 'apple'
  end

  attr_accessor :x, :y, :name

  def spawn
    arr_x = *(0...@grid.length_x)
    arr_y = *(0...@grid.length_y)
    @x = arr_x.sample
    @y = arr_y.sample
    spawn if @grid.grid[x][y] == 'tail' || @grid.grid[x][y] == 'head'
  end
end
