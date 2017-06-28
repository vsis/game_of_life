require_relative "../../src/gmap_reader"
require "test/unit"

class TestGmapReader < Test::Unit::TestCase
    def test_load_glider
        file_path = "tests/glider.map"
        glider_loader = GmapReader.new(file_path)
        glider = glider_loader.get_map
        assert_equal(false, glider.cell(0, 0))
        assert_equal(false, glider.cell(0, 1))
        assert_equal(false, glider.cell(0, 2))
        assert_equal(false, glider.cell(0, 3))
        assert_equal(false, glider.cell(0, 4))
        assert_equal(false, glider.cell(1, 0))
        assert_equal(false, glider.cell(1, 1))
        assert_equal(true, glider.cell(1, 2))
        assert_equal(false, glider.cell(1, 3))
        assert_equal(false, glider.cell(1, 4))
        assert_equal(false, glider.cell(2, 0))
        assert_equal(false, glider.cell(2, 1))
        assert_equal(false, glider.cell(2, 2))
        assert_equal(true, glider.cell(2, 3))
        assert_equal(false, glider.cell(2, 4))
        assert_equal(false, glider.cell(3, 0))
        assert_equal(true, glider.cell(3, 1))
        assert_equal(true, glider.cell(3, 2))
        assert_equal(true, glider.cell(3, 3))
        assert_equal(false, glider.cell(3, 4))
        assert_equal(false, glider.cell(4, 0))
        assert_equal(false, glider.cell(4, 1))
        assert_equal(false, glider.cell(4, 2))
        assert_equal(false, glider.cell(4, 3))
        assert_equal(false, glider.cell(4, 4))
    end
end
