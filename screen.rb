# frozen_string_literal: true

class Screen
  def initialize(grid, _width, _height)
    @grid = grid
    @square_size = 15
    @grid_start_x = 50
    @grid_start_y = 50
    @color = 'black'
    @squares = []
    draw_border
  end

  def draw_objects_in_grid
    x = *(0...@grid.length_x)
    y = *(0...@grid.length_y)
    x.each do |grid_x|
      y.each do |grid_y|
        draw_square(@grid.grid[grid_x][grid_y], grid_x, grid_y) unless (@grid.grid[grid_x][grid_y]) == 0
      end
    end
  end

  def remove_squares
    @squares.each(&:remove)
  end

  private

  def draw_border
    points = [[@grid_start_x, @grid_start_y],
              [@square_size * @grid.length_x + @grid_start_x, @grid_start_y],
              [@square_size * @grid.length_x + @grid_start_x, @square_size * @grid.length_y + @grid_start_y],
              [@grid_start_x, @square_size * @grid.length_y + @grid_start_y]]
    draw_border_lines(points)
  end

  def draw_border_lines(points)
    points.each_with_index do |p, index|
      next_point = index + 1
      next_point = 0 if next_point > 3
      draw_line(p, points[next_point])
    end
  end

  def draw_line(pt1, pt2)
    Line.new(
      x1: pt1[0], y1: pt1[1],
      x2: pt2[0], y2: pt2[1],
      width: 3,
      color: @color,
      z: 20
    )
  end

  def draw_square(object, object_x, object_y)
    color = 'red' if object == 'apple'
    color = 'white' if %w[tail head].include?(object)
    @squares << Square.new(
      x: object_x * @square_size + @grid_start_x,
      y: object_y * @square_size + @grid_start_y,
      size: @square_size,
      color: color
    )
  end
end
# Square.new(
#   x: 100, y: 200,
#   size: 125,
#   color: 'blue',
#   z: 10
# )
