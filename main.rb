# frozen_string_literal: true

require 'ruby2d'
require_relative 'grid'
require_relative 'tail'
require_relative 'apple'
require_relative 'head'
require_relative 'screen'
require_relative 'tail_square'
require_relative 'reset'

height = 1200
width = 1500

@time_between_frames = 0.066
@score = 0
@button_pressed = false
@game_is_on = false

set title: 'TAJEMNE TESTY'
set background: '#007239'
set width: width
set height: height
set resizable: true

@grid = Grid.new
@head = Head.new(@grid)
@apple = Apple.new(@grid)
@tail = Tail.new
@reset = Reset.new
@screen = Screen.new(@grid, width, height)

on :key_down do |event|
  if can_and_pressed_a(event.key) == true
    @head.speed_x = -1
    @head.speed_y = 0
    @button_pressed = true
  elsif can_and_pressed_d(event.key) == true
    @head.speed_x = 1
    @head.speed_y = 0
    @button_pressed = true
  elsif can_and_pressed_w(event.key) == true
    @head.speed_x = 0
    @head.speed_y = -1
    @button_pressed = true
  elsif can_and_pressed_s(event.key) == true
    @head.speed_x = 0
    @head.speed_y = 1
    @button_pressed = true
  elsif can_and_pressed_reset(event.key)
    @game_is_on = @reset.run(@tail, @grid, @head, @apple)
  end
end

def can_and_pressed_w(event_key)
  return true if event_key == 'w' && @head.speed_y.zero? && @button_pressed == false
end

def can_and_pressed_s(event_key)
  return true if event_key == 's' && @head.speed_y.zero? && @button_pressed == false
end

def can_and_pressed_a(event_key)
  return true if event_key == 'a' && @head.speed_x.zero? && @button_pressed == false
end

def can_and_pressed_d(event_key)
  return true if event_key == 'd' && @head.speed_x.zero? && @button_pressed == false
end

def can_and_pressed_reset(event_key)
  return true if event_key == 'r' && @game_is_on == false
end

update do
  if @game_is_on == true
    sleep @time_between_frames

    @tail.update
    @grid.update(@head, @tail, @apple)
    @screen.remove_squares
    @screen.draw_objects_in_grid
    @head.update
    @tail.squares << TailSquare.new(
      @head.x - @head.speed_x,
      @head.y - @head.speed_y,
      @score
    )
    if @head.ate_apple == true
      @score += 1
      @apple.spawn
      @tail.squares.each do |t|
        t.life_time += 1
      end
    end

    @game_is_on = false if @head.movement_valid == false

    @button_pressed = false
  end
end

show
