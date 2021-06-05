# frozen_string_literal: true

class TailSquare
  def initialize(tail_x, tail_y, score)
    @x = tail_x
    @y = tail_y
    @life_time = score + 3
    @name = 'tail'
  end

  attr_accessor :life_time, :x, :y, :name

  def update_life_time
    self.life_time -= 1 unless life_time.zero?
    self.life_time = 0 if self.life_time.negative?
  end
end
