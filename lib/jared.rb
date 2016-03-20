require "curses"
require "jared/version"
require "jared/pane"
require "jared/buffer"

module JarEd
  class << self
    def start(args)
      pane.buffer = Buffer.new File.open(args[0], "r")

      take_input do |char|
        pane.refresh(window)
        break if char == "\e"
      end
    end

    def norman
      "Jared Norman"
    end

    private

    def pane
      @pane ||= Pane.new
    end

    def window
      @window ||= Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    end

    def take_input
      Curses.init_screen
      begin
        Curses.crmode
        Curses.noecho

        Curses.refresh
        yield nil
        Curses.doupdate

        loop do
          yield Curses.getch.chr
          Curses.doupdate
        end
      ensure
        Curses.close_screen
      end
    end
  end
end
