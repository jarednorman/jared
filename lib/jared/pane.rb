module JarEd
  class Pane
    attr_accessor :buffer

    def refresh(window)
      window.setpos(0, 0)
      draw_lines(window)
      window.setpos(buffer.cursor_row, buffer.cursor_column)
      window.noutrefresh
    end

    private

    def draw_lines(window)
      screen = buffer.to_screen(width: Curses.cols, height: Curses.lines)
      raise "Invalid screen" unless screen.valid?

      screen.lines.each do |line|
        window.addstr line
      end
    end
  end
end
