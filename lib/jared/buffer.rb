require 'jared/buffer_line'

module JarEd
  class Buffer
    def initialize(filename)
      @file = File.open(filename, "r")
    end

    def lines
      @lines ||= file.each_line.to_a.map { |line| BufferLine.new(line) }
    end

    def wrapped_lines(width:, height:, offset:)
      lines.
        slice(offset, lines.length - 1).
        flat_map { |line| line.wrap(width: width) }.
        first(height)
    end

    private

    attr_reader :file
  end
end
