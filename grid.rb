# frozen_string_literal: true

class Grid
  def initialize
    @length_x = 40
    @length_y = 40
    @grid = Array.new(@length_x) { Array.new(length_y) { 0 } }
  end

  attr_accessor :length_x, :length_y, :grid

  def cleanup
    self.grid = Array.new(@length_x) { Array.new(length_y) { 0 } }
  end

  def update(head, tail, apple)
    cleanup
    update_object(head)
    tail.squares.each do |s|
      update_object(s)
    end
    update_object(apple)
  end

  def update_object(object)
    grid[object.x][object.y] = object.name
  end
end
