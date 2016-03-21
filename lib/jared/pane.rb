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
      buffer.lines.each do |line|
        actual_lines = line.scan(/.{1,#{Curses.cols}}/)

        if actual_lines.any?
          actual_lines.last << "\n" # You didn't see this.
        else
          actual_lines = %W(\n)
        end

        actual_lines.each do |actual_line|
          window.addstr actual_line
        end
      end
    end
  end
end
