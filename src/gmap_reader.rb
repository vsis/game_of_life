require_relative "gmap"

class GmapReader
    def initialize (map_file)
        @map_file = map_file
        @lines = []
        @bool_map = []
        _get_lines
        _fill_bool_map
    end

    def _get_lines
        File.open(@map_file, "r") do |f|
            f.each_line do |line|
                @lines << line
            end
        end
        raise EmptyMapError.new() if @lines.length == 0
    end

    def _fill_bool_map
        number_of_lines = @lines.length
        number_of_cols = @lines[0].length
        @lines.each do |line|
            raise BadNumberOfColsError.new("Rows have different number of columns") if line.length != number_of_cols
            row = []
            line.each_char do |cell|
                if cell == "0"
                    row << false
                elsif cell == "1"
                    row << true
                elsif cell == "\n"
                    
                else
                    raise UnexpectedCellError.new("Unexpected cell:#{cell}")
                end
            end
            @bool_map << row
        end
    end

    def get_map(rows=@bool_map.length, cols=@bool_map[0].length)
        map = Gmap.new(rows, cols)
        @bool_map.each_with_index do |row, i|
            row.each_with_index do |cell, j|
                map.set_cell(true, i, j) if cell
            end
        end
        return map
    end
end

class EmptyMapError < StandardError
end

class UnexpectedCellError < StandardError
end

class BadNumberOfColsError < StandardError
end
