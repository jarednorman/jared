module JarEd
  class Screen
    attr_reader :lines, :cursor_column, :cursor_row

    # @todo Rename these to cursor_row/column
    def initialize(lines:, cursor_column:, cursor_row:)
      @lines = lines
      @cursor_column = cursor_column
      @cursor_row = cursor_row
    end

    def width
      lines.map(&:length).max
    end

    def height
      lines.length
    end
  end
end
