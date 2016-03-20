module JarEd
  class Buffer
    attr_reader :window_position,
                :cursor_line,
                :cursor_column

    def initialize(file)
      @file = file
      @window_position = 0
      @cursor_line = 0
      @cursor_column = 0
    end

    def lines
      @lines ||= file.each_line.to_a
    end

    private

    attr_reader :file
  end
end
