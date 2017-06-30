class Gmap
    def initialize(rows, cols)
        array_length = rows * cols
        @rows = rows
        @cols = cols
        @current_map = Array.new(array_length, false)
        @next_map = Array.new(array_length, false)
    end

    def rows
        return @rows
    end

    def cols
        return @cols
    end

    def get_alive_cells
        counter = 0
        @current_map.each do |cell|
            counter += 1 if cell
        end
        return counter
    end

    def _swap()
        temporary = @current_map
        @current_map = @next_map
        @next_map = temporary
    end

    def _map_indexes(i, j)
        def _normalize_number(n, max)
            if n < 0
                return (max + n)
            elsif n >= max
                return (n % max)
            else
                return n
            end
        end
        i_index = _normalize_number(i, @rows)
        j_index = _normalize_number(j, @cols)
        return ((i_index * @cols) + j_index)
    end

    def _map_indexes_denorm(i)
        row = i / @cols
        col = i % @cols
        return [row, col]
    end

    def _get_cell(current, i, j)
        array_index = _map_indexes(i, j)
        if current
            map = @current_map
        else
            map = @next_map
        end
        return map[array_index]
    end

    def cell(i, j)
        return _get_cell(true, i, j)
    end

    def next_cell(i, j)
        return _get_cell(false, i, j)
    end

    def _set_next_cell(value, i, j)
        array_index = _map_indexes(i, j)
        @next_map[array_index] = value
    end

    def set_cell(value, i, j)
        array_index = _map_indexes(i, j)
        @current_map[array_index] = value
    end

    def change_cell(i, j)
        array_index = _map_indexes(i, j)
        current_value = @current_map[array_index]
        @current_map[array_index] = ! current_value
    end

    def _calc_next_value(i, j)
        counter = 0
        counter += 1 if cell(i + 1, j + 1)
        counter += 1 if cell(i + 1, j)
        counter += 1 if cell(i + 1, j - 1)
        counter += 1 if cell(i, j + 1)
        counter += 1 if cell(i, j - 1)
        counter += 1 if cell(i - 1, j + 1)
        counter += 1 if cell(i - 1, j)
        counter += 1 if cell(i - 1, j - 1)
        is_alive = cell(i, j)
        can_keep_alive = (counter == 2 or counter == 3)
        can_be_born = (counter == 3)
        if is_alive
            return can_keep_alive
        else
            return can_be_born
        end
    end

    def next_generation()
        @current_map.each_with_index do |cell, counter|
            coord = _map_indexes_denorm(counter)
            row = coord[0]
            col = coord[1]
            next_value = _calc_next_value(row, col)
            _set_next_cell(next_value, row, col)
        end
        _swap()
    end

    def get_diff()
        diff = []
        @current_map.each_with_index do |cell, counter|
            is_diff = (@current_map[counter] != @next_map[counter])
            if is_diff
                coord = _map_indexes_denorm(counter)
                diff << coord
            end
        end
        return diff
    end
end
