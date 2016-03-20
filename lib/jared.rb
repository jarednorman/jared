require "curses"
require "jared/version"
require "jared/pane"
require "jared/buffer"

module JarEd
  class << self
    def start(args)
      buffer = Buffer.new File.open(args[0], "r")
      pane.buffer = buffer

      take_input do |char|
        case char
        when "h"
          buffer.cursor(0, -1)
        when "j"
          buffer.cursor(1, 0)
        when "k"
          buffer.cursor(-1, 0)
        when "l"
          buffer.cursor(0, 1)
        when "\e"
          break
        end
        pane.refresh(window)
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
