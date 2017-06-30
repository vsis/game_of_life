require_relative "../../src/curses_map"
require "test/unit"

class TestCursesMap < Test::Unit::TestCase
   def test_get_map_col
        screen_map = CursesMap.new
        assert_equal(1, screen_map.get_map_col(3))
        assert_equal(15, screen_map.get_map_col(30))
        assert_equal(150, screen_map.get_map_col(300))
   end

   def test_get_screen_col
        screen_map = CursesMap.new
        assert_equal(0, screen_map.get_screen_col(0))
        assert_equal(2, screen_map.get_screen_col(1))
        assert_equal(20, screen_map.get_screen_col(10))
        assert_equal(200, screen_map.get_screen_col(100))
   end
end
