require_relative "gmap"
require_relative "gmap_reader"
require_relative "curses_map"

def main(map_file)
    screen = CursesMap.new
    screen.init_screen
    map_cols = screen.get_map_cols
    map_rows = screen.get_map_rows
    generation = 0
    map_loader = GmapReader.new(map_file)
    map = map_loader.get_map(map_rows, map_cols)
    screen.init_footer
    nodelay = false
    while true
        print_generation(map, screen, generation)
        map.next_generation
        generation += 1
        nodelay = catch_keyboard(nodelay)
    end
end

def print_generation(map, screen, generation)
    if generation != 0
        print_diff(map, screen)
    else
        print_all_map(map, screen)
    end
    message = get_footer(generation, map.get_alive_cells, map.rows, map.cols)
    screen.print_footer(message)
    screen.update
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
    message = "Generation: #{generation} | "
    message += "Cells: #{alive_cells} | "
    message += "Map Size: #{rows}X#{cols} |       "
    return message
end

def catch_keyboard(nodelay)
    input_key = Curses.stdscr.getch
    result = nodelay
    if input_key == " "
        result = !result
        Curses.stdscr.nodelay = result
    elsif input_key == "n"
        return result
    elsif input_key == "q"
        exit 0
    elsif !nodelay
        return catch_keyboard(nodelay)
    end
    return result
end

if __FILE__ == $0
    file_path = ARGV[0]
    main(file_path)
end
