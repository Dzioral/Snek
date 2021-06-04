# frozen_string_literal: true

class Grid
  def initialize(grid_square_size, how_many_squares_horizontal, how_many_squares_vertical, start_x, start_y)
    @grid_square_size = grid_square_size
    @how_many_squares_horizontal = how_many_squares_horizontal
    @how_many_squares_vertical = how_many_squares_vertical
    @start_x = start_x
    @start_y = start_y
    @color = 'black'
    draw
  end

  attr_accessor :grid_square_size, :how_many_squares_horizontal, :how_many_squares_vertical, :start_x, :start_y

  def possible_possitions_x
    possible_possitions_x = *(0...how_many_squares_horizontal)
    possible_possitions_x.map! { |x| @start_x + x * @grid_square_size }
    possible_possitions_x
  end

  def possible_possitions_y
    possible_possitions_y = *(0...how_many_squares_vertical)
    possible_possitions_y.map! { |y| @start_y + y * @grid_square_size }
    possible_possitions_y
  end

  private

  def draw
    draw_vertical_lines
    draw_horizontal_lines
  end

  def draw_vertical_lines
    lines_vertical = *(0..@how_many_squares_horizontal)

    lines_vertical.each do |l|
      Line.new(
        x1: l * @grid_square_size + @start_x, y1: @start_y,
        x2: l * @grid_square_size + @start_x, y2: @how_many_squares_vertical * @grid_square_size + @start_y,
        width: 2,
        color: @color,
        z: 20
      )
    end
  end

  def draw_horizontal_lines
    lines_horizontal = *(0..@how_many_squares_vertical)

    lines_horizontal.each do |l|
      Line.new(
        x1: @start_x, y1: l * @grid_square_size + @start_y,
        x2: @how_many_squares_horizontal * @grid_square_size + @start_x, y2: l * @grid_square_size + @start_y,
        width: 2,
        color: @color,
        z: 20
      )
    end
  end

  # def initialize(grid_square_size, height, width, color, start_x, start_y)
  #   @grid_square_size = grid_square_size
  #   @height = height
  #   @width = width
  #   @color = color
  #   @start_x = start_x
  #   @start_y = start_y
  # end

  # def draw
  #   draw_vertical_lines
  #   draw_horizontal_lines
  # end

  # private

  # def draw_vertical_lines
  #   lines_vertical = *(0..(@width - @start_x) / @grid_square_size)

  #   lines_vertical.each do |l|
  #     Line.new(
  #       x1: l * @grid_square_size + @start_x, y1: 0 + @start_y,
  #       x2: l * @grid_square_size + @start_x, y2: @height,
  #       width: 2,
  #       color: @color,
  #       z: 20
  #     )
  #   end
  # end

  # def draw_horizontal_lines
  #   lines_horizontal = *(0..(@height - @start_y) / @grid_square_size)

  #   lines_horizontal.each do |l|
  #     Line.new(
  #       x1: @start_x, y1: l * @grid_square_size + @start_y,
  #       x2: @width, y2: l * @grid_square_size + @start_y,
  #       width: 2,
  #       color: @color,
  #       z: 20
  #     )
  #   end
  # end
end
