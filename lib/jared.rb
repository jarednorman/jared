require "curses"
require "jared/version"

module JarEd
  class << self
    def start(args)
      with_screen do
        loop do
          stop! if Curses.getch == 'q'
          Curses.doupdate
          break if stop
        end
      end
    end

    def norman
      "Jared Norman"
    end

    def stop!
      @stop = true
    end

    private

    attr_reader :stop

    def with_screen
      Curses.init_screen
      begin
        Curses.crmode
        Curses.noecho
        yield
      ensure
        Curses.close_screen
      end
    end
  end
end
