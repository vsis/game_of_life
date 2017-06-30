require_relative "gmap"
require_relative "gmap_reader"
require_relative "curses_map"

def main(map_file)
    screen = CursesMap.new
    screen.init_screen
    map_cols = screen.get_map_cols
    map_rows = screen.get_map_rows
    map_loader = GmapReader.new(map_file)
    map = map_loader.get_map(map_rows, map_cols)
    print_all_map(map, screen)
    screen.update
    while true
        map.next_generation
        print_diff(map, screen)
        screen.update
    end
end

def print_all_map(map, screen)
    rows = map.rows
    cols = map.cols
    rows.times do |i|
        cols.times do |j|
            cell = map.cell(i, j)
            screen.print_cell(cell, i, j)
        end
    end
end

def print_diff(map, screen)
    diff = map.get_diff
    diff.each do |point|
        row = point[0]
        col = point[1]
        cell = map.cell(row, col)
        screen.print_cell(cell, row, col)
    end
end

def get_footer(generation, alive_cells, rows, cols)
    message = "Generation: #{generation} "
    message += "Cells: #{alive_cells} "
    message += "Map Size: #{rows}X#{cols}"
    return message
end

if __FILE__ == $0
    file_path = ARGV[0]
    main(file_path)
end
