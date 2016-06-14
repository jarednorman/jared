module JarEd
  class Screen
    attr_reader :lines, :cursor_x, :cursor_y

    def initialize(lines:, cursor_x:, cursor_y:)
      @lines = lines
      @cursor_x = cursor_x
      @cursor_y = cursor_y
    end

    def valid?
      line_length = lines.first.length
      lines.all? { |line| line.length == line_length } &&
        cursor_x >= 0 &&
        cursor_y >= 0 &&
        cursor_x < line_length &&
        cursor_y < lines.length
    end
  end
end
