require "curses"
require "jared/version"

module JarEd
  class << self
    def start(args)
      take_input do |char|
        puts char
        break if char == "\e"
      end
    end

    def norman
      "Jared Norman"
    end

    private

    def take_input
      Curses.init_screen
      begin
        Curses.crmode
        Curses.noecho
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
