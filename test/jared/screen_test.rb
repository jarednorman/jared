require 'test_helper'
require 'jared/screen'

class JarEd::ScreenTest < Minitest::Test
  def test_a_simple_screen
    screen = JarEd::Screen.new(
      cursor_x: 0,
      cursor_y: 1,
      lines: %w(aaaa bbbb cccc dddd)
    )

    assert_equal %w(aaaa bbbb cccc dddd), screen.lines
    assert_equal 0, screen.cursor_x
    assert_equal 1, screen.cursor_y
    assert screen.valid?
  end

  def test_invalid_lines
    screen = JarEd::Screen.new(
      cursor_x: 0,
      cursor_y: 0,
      lines: %w(aaaaa bbbb cccc dddd)
    )
    refute screen.valid?
  end

  def test_invalid_cursor_x
    screen = JarEd::Screen.new(
      cursor_x: -1,
      cursor_y: 0,
      lines: %w(aaaa bbbb cccc dddd)
    )
    refute screen.valid?
    screen = JarEd::Screen.new(
      cursor_x: 4,
      cursor_y: 0,
      lines: %w(aaaa bbbb cccc dddd)
    )
    refute screen.valid?
  end

  def test_invalid_cursor_y
    screen = JarEd::Screen.new(
      cursor_x: 0,
      cursor_y: -1,
      lines: %w(aaaa bbbb cccc dddd)
    )
    refute screen.valid?
    screen = JarEd::Screen.new(
      cursor_x: 0,
      cursor_y: 4,
      lines: %w(aaa bbb ccc ddd)
    )
    refute screen.valid?
  end
end
