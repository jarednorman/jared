require 'test_helper'
require 'jared/screen'

class JarEd::ScreenTest < Minitest::Test
  def test_a_simple_screen
    screen = JarEd::Screen.new(
      cursor_x: 0,
      cursor_y: 1,
      lines: %w(aaa bbb ccc ddd)
    )

    assert_equal %w(aaa bbb ccc ddd), screen.lines
    assert_equal 4, screen.height
    assert_equal 3, screen.width
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

  def test_text_equal
    screen_one = JarEd::Screen.new(
      cursor_x: 0,
      cursor_y: 0,
      lines: %w(aaa bbb ccc)
    )
    screen_two = JarEd::Screen.new(
      cursor_x: 1,
      cursor_y: 2,
      lines: %w(aaa bbb ccc)
    )
    screen_three = JarEd::Screen.new(
      cursor_x: 1,
      cursor_y: 2,
      lines: %w(aaa xxx ccc)
    )

    assert screen_one.same_text? screen_two
    refute screen_one.same_text? screen_three
    refute screen_two.same_text? screen_three
  end
end
