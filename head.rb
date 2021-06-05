# frozen_string_literal: true

class Head
  def initialize(grid)
    @x = 1
    @y = 1
    @speed_x = 1
    @speed_y = 0
    @grid = grid
    @name = 'head'
  end

  def reset
    @x = 1
    @y = 1
    @speed_x = 1
    @speed_y = 0
  end

  attr_accessor :x, :y, :speed_x, :speed_y, :name

  def update
    @x += @speed_x
    @y += @speed_y
  end

  def movement_valid
    return false if out_of_grid == true || hitting_tail == true

    true
  end

  def ate_apple
    return true if out_of_grid == false && @grid.grid[x][y] == 'apple'

    false
  end

  private

  def out_of_grid
    return true if x >= @grid.length_x ||
                   y >= @grid.length_y ||
                   x.negative? ||
                   y.negative?

    false
  end

  def hitting_tail
    return true if @grid.grid[x][y] == 'tail'

    false
  end
end
