require "curses"
require "logger"
require "jared/version"
require "jared/pane"
require "jared/buffer"

module JarEd
  class << self
    def start(args)
      pane = Pane.new
      pane.buffer = Buffer.new File.open(args[0], "r")

      take_input do |char|
        # FIXME: This should normalize incoming escape sequences and such.
        pane.send_input char
        pane.refresh(window)
      end
    end

    def norman
      "Jared Norman"
    end

    def logger
      @logger ||=
        begin
          log_directory_path = File.join(jared_folder_path, "logs")
          FileUtils.mkdir_p log_directory_path
          log_file_path = File.join(log_directory_path, "jared.log")
          logger = Logger.new(log_file_path, 10)
          logger.level = Logger::DEBUG
          logger
        end
    end

    private

    def jared_folder_path
      @jared_folder_path ||=
        begin
          path = File.join(Dir.home, ".jared")
          FileUtils.mkdir_p(path)
          path
        end
    end

    def window
      @window ||= Curses::Window.new(0, 0, 0, 0)
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
          begin
            yield Curses.getch.chr
          rescue RangeError
            yield nil
          end

          Curses.doupdate
        end
      ensure
        Curses.close_screen
      end
    end
  end
end
