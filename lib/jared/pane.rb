module JarEd
  class Pane
    def refresh(window)
      screen = view.to_screen
      validate!(screen)
      window.clear
      draw_screen(window, screen)
      window.setpos(screen.cursor_row, screen.cursor_column)
      window.noutrefresh
    end

    def send_input(char)
      view.send_input(char)
    end

    def view=(view)
      view.pane = self
      @view = view
    end

    def width
      Curses.cols
    end

    def height
      Curses.lines
    end

    private

    attr_reader :view

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
        screen.cursor_column < width &&
        screen.cursor_row < height ||
        raise("Invalid screen.")
    end
  end
end
