# frozen_string_literal: true

class Tail
  def initialize
    @squares = []
  end

  attr_accessor :squares

  def update
    @squares.each do |s|
      s.update_life_time
      @squares.delete(s) if s.life_time.zero?
    end
  end

  def purge
    @squares = []
  end
end
