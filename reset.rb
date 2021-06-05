# frozen_string_literal: true

class Reset
  def run(tail, grid, head, apple)
    tail.purge
    grid.cleanup
    head.reset
    grid.update_object(head)
    apple.spawn

    true
  end
end
