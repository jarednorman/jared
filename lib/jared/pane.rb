module JarEd
  class Pane
    attr_accessor :buffer

    def refresh(window)
      window.setpos(0, 0)
      draw_lines(window)
      window.noutrefresh
    end

    private

    def draw_lines(window)
      buffer.lines.each do |line|
        # line_height = line.scan(/.{1,#{Curses.cols}}/)
        window.addstr line
      end
    end
  end
end
