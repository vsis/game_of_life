require_relative "../../src/gmap"
require "test/unit"

class TestGmap < Test::Unit::TestCase
    def test_index_normalization_3x3
        test_map = Gmap.new(3,3)
        assert_equal(0, test_map._map_indexes(0, 0))
        assert_equal(1, test_map._map_indexes(0, 1))
        assert_equal(2, test_map._map_indexes(0, 2))
        assert_equal(3, test_map._map_indexes(1, 0))
        assert_equal(4, test_map._map_indexes(1, 1))
        assert_equal(5, test_map._map_indexes(1, 2))
        assert_equal(6, test_map._map_indexes(2, 0))
        assert_equal(7, test_map._map_indexes(2, 1))
        assert_equal(8, test_map._map_indexes(2, 2))
    end

    def test_index_normalization_2x3
        test_map = Gmap.new(2,3)
        assert_equal(0, test_map._map_indexes(0, 0))
        assert_equal(1, test_map._map_indexes(0, 1))
        assert_equal(2, test_map._map_indexes(0, 2))
        assert_equal(3, test_map._map_indexes(1, 0))
        assert_equal(4, test_map._map_indexes(1, 1))
        assert_equal(5, test_map._map_indexes(1, 2))
    end
   
    def test_index_normalization_3x4
        test_map = Gmap. new(3, 4)
        assert_equal(0, test_map._map_indexes(0, 0))
        assert_equal(1, test_map._map_indexes(0, 1))
        assert_equal(2, test_map._map_indexes(0, 2))
        assert_equal(3, test_map._map_indexes(0, 3))
        assert_equal(4, test_map._map_indexes(1, 0))
        assert_equal(5, test_map._map_indexes(1, 1))
        assert_equal(6, test_map._map_indexes(1, 2))
        assert_equal(7, test_map._map_indexes(1, 3))
        assert_equal(8, test_map._map_indexes(2, 0))
        assert_equal(9, test_map._map_indexes(2, 1))
        assert_equal(10, test_map._map_indexes(2, 2))
        assert_equal(11, test_map._map_indexes(2, 3))
    end
    
    def test_index_denormalization_2x3
       test_map = Gmap.new(2, 3)
       assert_equal([0,0], test_map._map_indexes_denorm(0))
       assert_equal([0,1], test_map._map_indexes_denorm(1))
       assert_equal([0,2], test_map._map_indexes_denorm(2))
       assert_equal([1,0], test_map._map_indexes_denorm(3))
       assert_equal([1,1], test_map._map_indexes_denorm(4))
       assert_equal([1,2], test_map._map_indexes_denorm(5))
    end

    def test_index_denormalization_3x3
       test_map = Gmap.new(3, 3)
       assert_equal([0,0], test_map._map_indexes_denorm(0))
       assert_equal([0,1], test_map._map_indexes_denorm(1))
       assert_equal([0,2], test_map._map_indexes_denorm(2))
       assert_equal([1,0], test_map._map_indexes_denorm(3))
       assert_equal([1,1], test_map._map_indexes_denorm(4))
       assert_equal([1,2], test_map._map_indexes_denorm(5))
       assert_equal([2,0], test_map._map_indexes_denorm(6))
       assert_equal([2,1], test_map._map_indexes_denorm(7))
       assert_equal([2,2], test_map._map_indexes_denorm(8))
    end

    def test_index_denormalization_3x4
       test_map = Gmap.new(3, 4)
       assert_equal([0,0], test_map._map_indexes_denorm(0))
       assert_equal([0,1], test_map._map_indexes_denorm(1))
       assert_equal([0,2], test_map._map_indexes_denorm(2))
       assert_equal([0,3], test_map._map_indexes_denorm(3))
       assert_equal([1,0], test_map._map_indexes_denorm(4))
       assert_equal([1,1], test_map._map_indexes_denorm(5))
       assert_equal([1,2], test_map._map_indexes_denorm(6))
       assert_equal([1,3], test_map._map_indexes_denorm(7))
       assert_equal([2,0], test_map._map_indexes_denorm(8))
       assert_equal([2,1], test_map._map_indexes_denorm(9))
       assert_equal([2,2], test_map._map_indexes_denorm(10))
       assert_equal([2,3], test_map._map_indexes_denorm(11))
    end


    def test_set_cell_3x3
        test_map = Gmap.new(3, 3)
        3.times do |i|
            3.times do |j|
                assert_equal(false, test_map.cell(i, j))
            end
        end
        test_map.set_cell(true, 0, 0)
        assert_equal(true, test_map.cell(0, 0))
        test_map.set_cell(false, 0, 0)
        assert_equal(false, test_map.cell(0, 0))
    end

    def test_blinker_4x4
        blinker = [
            [false, true, false, false],
            [false, true, false, false],
            [false, true, false, false,],
            [false, false, false, false]
        ]

        post_blinker = [
            [false, false, false, false],
            [true, true, true, false],
            [false, false, false, false],
            [false, false, false, false]
        ]
        test_map = Gmap.new(4, 4)
        4.times do |i|
            4.times do |j|
                test_map.set_cell(blinker[i][j], i, j)
            end
        end
        test_map.next_generation()
        4.times do |i|
            4.times do |j|
                assert_equal(post_blinker[i][j], test_map.cell(i, j))
            end
        end
        test_map.next_generation()
        4.times do |i|
            4.times do |j|
                assert_equal(blinker[i][j], test_map.cell(i, j))
            end
        end
    end

    def test_swap_3x3
        test_map = Gmap.new(3, 3)
        test_map.set_cell(true, 0, 0)
        assert_equal(true, test_map.cell(0, 0))
        assert_equal(false, test_map.cell(0, 1))
        assert_equal(false, test_map.cell(0, 2))
        assert_equal(false, test_map.cell(1, 0))
        assert_equal(false, test_map.cell(1, 1))
        assert_equal(false, test_map.cell(1, 2))
        assert_equal(false, test_map.cell(2, 0))
        assert_equal(false, test_map.cell(2, 1))
        assert_equal(false, test_map.cell(2, 2))
        test_map._swap
        assert_equal(false, test_map.cell(0, 0))
        assert_equal(false, test_map.cell(0, 1))
        assert_equal(false, test_map.cell(0, 2))
        assert_equal(false, test_map.cell(1, 0))
        assert_equal(false, test_map.cell(1, 1))
        assert_equal(false, test_map.cell(1, 2))
        assert_equal(false, test_map.cell(2, 0))
        assert_equal(false, test_map.cell(2, 1))
        assert_equal(false, test_map.cell(2, 2))
        test_map._swap
        assert_equal(true, test_map.cell(0, 0))
        assert_equal(false, test_map.cell(0, 1))
        assert_equal(false, test_map.cell(0, 2))
        assert_equal(false, test_map.cell(1, 0))
        assert_equal(false, test_map.cell(1, 1))
        assert_equal(false, test_map.cell(1, 2))
        assert_equal(false, test_map.cell(2, 0))
        assert_equal(false, test_map.cell(2, 1))
        assert_equal(false, test_map.cell(2, 2))
    end

    def test_next_cell_2x2
        test_map = Gmap.new(2, 2)
        test_map.set_cell(true, 0, 0)
        assert_equal(true, test_map.cell(0, 0))
        assert_equal(false, test_map.next_cell(0, 0))
    end

    def tests_change_cell_2x2
        test_map = Gmap.new(2, 2)
        assert_equal(false, test_map.cell(0, 0))
        assert_equal(false, test_map.cell(0, 1))
        assert_equal(false, test_map.cell(1, 0))
        assert_equal(false, test_map.cell(1, 1))
        test_map.change_cell(0, 0)
        assert_equal(true, test_map.cell(0, 0))
        assert_equal(false, test_map.cell(0, 1))
        assert_equal(false, test_map.cell(1, 0))
        assert_equal(false, test_map.cell(1, 1))
        test_map.change_cell(0, 0)
        assert_equal(false, test_map.cell(0, 0))
        assert_equal(false, test_map.cell(0, 1))
        assert_equal(false, test_map.cell(1, 0))
        assert_equal(false, test_map.cell(1, 1))
    end

    def tests_get_diff_2x2
        test_map = Gmap.new(2, 2)
        test_map.set_cell(true, 0, 0)
        test_map.next_generation
        diff = test_map.get_diff
        assert_equal([[0,0]], diff)
        test_map.next_generation
        diff = test_map.get_diff
        assert_equal([], diff)
    end
end

