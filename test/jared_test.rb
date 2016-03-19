require 'test_helper'

class JarEdTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::JarEd::VERSION
  end

  def test_say_my_name_say_my_name
    assert_equal "Jared Norman", JarEd.norman
  end
end
