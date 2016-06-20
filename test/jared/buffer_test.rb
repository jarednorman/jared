require 'test_helper'
require 'support/file_fixtures'

module JarEd
  class BufferTest < JarEd::Test
    include JarEd::Test::FileFixtures

    def test_moving_the_cursor
      buffer = JarEd::Buffer.new(readme)
      subject = -> { [buffer.cursor_column, buffer.cursor_row] }

      assert_equal [0, 0], subject.call
      buffer.send_input "h"
      assert_equal [0, 0], subject.call
      buffer.send_input "l"
      assert_equal [1, 0], subject.call
      buffer.send_input "j"
      assert_equal [1, 1], subject.call
      buffer.send_input "j"
      assert_equal [1, 0], subject.call
      buffer.send_input "k"
      buffer.send_input "h"
      assert_equal [0, 0], subject.call
      buffer.send_input "k"
      assert_equal [0, 0], subject.call
    end

    def test_rendering_screen
      mock_file = Minitest::Mock.new
      mock_file.expect :each_line, %W(1234567\n 1234\n 123\n \n 1\n 12345\n)

      buffer = JarEd::Buffer.new(mock_file)
      screen = buffer.to_screen(width: 3, height: 9)

      assert_equal [
        "123",
        "456",
        "7",
        "123",
        "4",
        "123",
        "",
        "1",
        "123"
      ], screen.lines
      assert_equal 0, screen.cursor_column
      assert_equal 0, screen.cursor_row

      mock_file.verify
    end
  end
end
