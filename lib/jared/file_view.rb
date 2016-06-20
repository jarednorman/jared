require 'jared/screen'

module JarEd
  class FileView
    attr_accessor :pane

    def initialize(buffer)
      @buffer = buffer
      @row_offset = 0
      @cursor_row = 0
      @cursor_column = 0
    end

    # @todo Make this method not awful.
    def to_screen
      screen_lines = buffer.lines.reduce([]) do |lines, line|
        line.wrap(width: width).each do |chunk|
          if lines.length < height
            lines << chunk
          end
        end

        lines
      end

      screen_cursor_column =
        if cursor_column < width
          cursor_column
        else
          cursor_column % width
        end

      # FIXME: Make this readable/understandable.
      screen_cursor_row =
        buffer.lines.reduce(0) do |acc, line|
          if line == current_line
            if cursor_column < width
              break acc
            else
              break acc + cursor_column / width
            end
          else
            acc + line.wrap(width: width).length
          end
        end

      Screen.new(
        cursor_column: screen_cursor_column,
        cursor_row: screen_cursor_row,
        lines: screen_lines
      )
    end

    def send_input(input)
      case input
      when "h"
        update_cursor(column: cursor_column - 1)
      when "j"
        update_cursor(row: cursor_row + 1)
      when "k"
        update_cursor(row: cursor_row - 1)
      when "l"
        update_cursor(column: cursor_column + 1)
      end
    end

    private

    attr_reader :buffer,

    attr_accessor :cursor_row,
                  :cursor_column,
                  :row_offset

    def width
      pane.width
    end

    def height
      pane.height
    end

    def update_cursor(row: cursor_row, column: cursor_column)
      row = [0, row].max
      row = [row, buffer.lines.length - 1].min
      @cursor_row = row

      column = [0, column].max
      column = [column, current_line.raw_text.length - 1].min
      @cursor_column = column

      if row < row_offset
        self.row_offset = row
      elsif false # off end of screen
        # bring it back
      end
    end

    def current_line
      buffer.lines[cursor_row]
    end
  end
end
