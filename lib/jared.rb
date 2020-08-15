require "logger"
require "jared/editor"
require "jared/version"

module JarEd
  class << self
    def start(args)
      Editor.new(argv: args).start
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
  end
end
