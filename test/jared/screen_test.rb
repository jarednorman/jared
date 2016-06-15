require 'test_helper'
require 'jared/screen'

class JarEd::ScreenTest < Minitest::Test
  def test_a_simple_screen
    screen = JarEd::Screen.new(
      cursor_column: 0,
      cursor_row: 1,
      lines: %w(aaa bbb ccc ddd)
    )

    assert_equal %w(aaa bbb ccc ddd), screen.lines
    assert_equal 4, screen.height
    assert_equal 3, screen.width
    assert_equal 0, screen.cursor_column
    assert_equal 1, screen.cursor_row
  end
end
