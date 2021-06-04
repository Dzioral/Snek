# frozen_string_literal: true

require 'ruby2d'
require_relative 'grid'
require_relative 'tail'
require_relative 'apple'

height = 800
width = 1200

@time_between_frames = 0.08
@grid_square_size = 25
@grid_vertical_squares = 20
@grid_horizontal_squares = 30
@grid_start_x = 25
@grid_start_y = 25
@snake_head_start_x = (@grid_start_x + 50)
@snake_head_start_y = (@grid_start_y + 50)
@x_speed = @grid_square_size
@y_speed = 0
@score = 0
@snake_head_hitbox = false
@button_pressed = false
@game_is_on = false
@tail = []

set title: 'TAJEMNE TESTY'
set background: '#007239'
set width: width
set height: height

@snake_head = Square.new(x: @snake_head_start_x, y: @snake_head_start_y, size: @grid_square_size - 1, color: 'white')
@text = Text.new('')
@reset_text = Text.new('', x: @grid_square_size * @grid_horizontal_squares + @grid_square_size * 2, y: 25)
@grid = Grid.new(
  @grid_square_size,
  @grid_horizontal_squares,
  @grid_vertical_squares,
  @grid_start_x,
  @grid_start_y
)
@apple = Apple.new(@grid)

def can_and_pressed_w(event_key)
  return true if event_key == 'w' && @y_speed.zero? && @button_pressed == false
end

def can_and_pressed_s(event_key)
  return true if event_key == 's' && @y_speed.zero? && @button_pressed == false
end

def can_and_pressed_a(event_key)
  return true if event_key == 'a' && @x_speed.zero? && @button_pressed == false
end

def can_and_pressed_d(event_key)
  return true if event_key == 'd' && @x_speed.zero? && @button_pressed == false
end

def can_and_pressed_reset(event_key)
  return true if event_key == 'r' && @game_is_on == false
end

# checks if snake_head is about  cross the boundry of the grid

def illegal_moves
  return false unless
  (@snake_head.x + @x_speed) > @grid_square_size * @grid_horizontal_squares ||
  (@snake_head.x + @x_speed) < @grid_start_x ||
  (@snake_head.y + @y_speed) > @grid_square_size * @grid_vertical_squares ||
  (@snake_head.y + @y_speed) < @grid_start_y

  true
end

def tail_update
  @tail.each do |t|
    @snake_head_hitbox = true if t.life_time != (1) && (@snake_head.contains? t.x, t.y)
    t.update_life_time unless @snake_head_hitbox == true
    @tail.delete(t) if t.life_time == 1 && @snake_head_hitbox == false
  end
end

def tail_purge
  @tail.each(&:purge)
  @tail = []
end

def snake_head_movement
  @snake_head.x += @x_speed
  @snake_head.y += @y_speed
end

def reset_game
  tail_purge
  @snake_head_hitbox = false
  @snake_head.x = @snake_head_start_x
  @snake_head.y = @snake_head_start_y
  @x_speed = @grid_square_size
  @y_speed = 0
  @apple.remove
  @apple.spawn
  @game_is_on = true
end

on :key_down do |event|
  if can_and_pressed_a(event.key) == true
    @x_speed = -@grid_square_size
    @y_speed = 0
    @button_pressed = true
  elsif can_and_pressed_d(event.key) == true
    @x_speed = @grid_square_size
    @y_speed = 0
    @button_pressed = true
  elsif can_and_pressed_w(event.key) == true
    @x_speed = 0
    @y_speed = -@grid_square_size
    @button_pressed = true
  elsif can_and_pressed_s(event.key) == true
    @x_speed = 0
    @y_speed = @grid_square_size
    @button_pressed = true
  elsif can_and_pressed_reset(event.key) == true
    reset_game
  end
end

update do
  @reset_text.text = 'Press r to start' if @game_is_on == false
  @reset_text.text = '' if @game_is_on == true

  if @game_is_on == true
    sleep @time_between_frames

    tail_update unless @game_is_on == false # hitbox and length

    @snake_head_hitbox = illegal_moves if @snake_head_hitbox == false

    @text.text = @snake_head_hitbox

    @game_is_on = false if @snake_head_hitbox == true

    snake_head_movement unless @game_is_on == false

    if @game_is_on == true
      @tail << Tail.new(
        @snake_head.x - @x_speed,
        @snake_head.y - @y_speed,
        @grid_square_size,
        @score
      )
    end

    @button_pressed = false
  end
end

show
