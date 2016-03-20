module JarEd
  class Buffer
    attr_reader :window_position,
                :cursor_row,
                :cursor_column

    def initialize(file)
      @file = file
      @window_position = 0
      @cursor_row = 0
      @cursor_column = 0
    end

    def lines
      @lines ||= file.each_line.to_a
    end

    # @todo Restrict cursor position to file/line length.
    def cursor(rows, columns)
      @cursor_row = [0, cursor_row + rows].max
      @cursor_column = [0, cursor_column + columns].max
    end

    private

    attr_reader :file
  end
end
