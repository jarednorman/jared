require 'jared/screen'
require 'jared/buffer/line'

module JarEd
  class Buffer
    def initialize(file)
      @file = file
      @window_position = 0
      @cursor_row = 0
      @cursor_column = 0
    end

    # @todo Make this method not awful.
    def to_screen(width:, height:)
      screen_lines = lines.reduce([]) do |acc, line|
        line.wrap(width: width).each do |chunk|
          if acc.length < height
            acc << chunk
          end
        end

        acc
      end

      screen_cursor_column =
        if cursor_column < width
          cursor_column
        else
          cursor_column % width
        end

      # FIXME: Make this readable/understandable.
      screen_cursor_row =
        lines.reduce(0) do |acc, line|
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
        cursor(column: cursor_column - 1)
      when "j"
        cursor(row: cursor_row + 1)
      when "k"
        cursor(row: cursor_row - 1)
      when "l"
        cursor(column: cursor_column + 1)
      end
    end

    def lines
      @lines ||= file.each_line.to_a.map { |line| Line.new(line) }
    end

    private

    attr_reader :file,
                :window_position

    attr_accessor :cursor_row,
                  :cursor_column

    def cursor(row: cursor_row, column: cursor_column)
      row = [0, row].max
      row = [row, lines.length - 1].min
      @cursor_row = row

      column = [0, column].max
      column = [column, current_line.raw_text.length - 1].min
      @cursor_column = column
    end

    def current_line
      lines[cursor_row]
    end
  end
end
