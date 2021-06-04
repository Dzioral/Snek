# frozen_string_literal: true

class Tail
  def initialize(x, y, size, score)
    @x = x
    @y = y
    @size = size - 1
    @life_time = score + 10
    @tail_square = Square.new(x: @x, y: @y, size: @size, color: 'white')
  end

  attr_accessor :life_time, :tail_square, :x, :y

  def update_life_time
    self.life_time -= 1 unless life_time == 1
    self.life_time = 1 unless self.life_time > 1
    purge if life_time == 1
  end

  def purge
    tail_square.remove
    # p tail_square
  end
end



