class Apple
  def initialize(grid)
    @grid = grid
  end

  attr_accessor :x, :y, :apple_square

  def spawn
    @x = @grid.possible_possitions_x.sample
    @y = @grid.possible_possitions_y.sample
    @size = @grid.grid_square_size - 1
    @apple_square = Square.new(x: @x, y: @y, size: @size, color: 'red')
  end

  def remove
    @apple_square.remove unless @apple_square.nil?
  end
end