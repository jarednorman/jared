module JarEd
  class Pane
    attr_accessor :buffer

    def refresh(window)
      screen = buffer.to_screen(width: Curses.cols, height: Curses.lines)
      validate!(screen)
      draw_screen(window, screen)
      window.setpos(screen.cursor_row, screen.cursor_column)
      window.noutrefresh
    end

    private

    def draw_screen(window, screen)
      screen.lines.each_with_index do |line, index|
        window.setpos index, 0
        window.addstr line
      end
    end

    # @todo Validate that the screen fits in the pane.
    def validate!(screen)
      screen.cursor_column >= 0 &&
        screen.cursor_row >= 0 &&
        screen.cursor_column < screen.width &&
        screen.cursor_row < screen.height ||
        raise("Invalid screen.")
    end
  end
end
