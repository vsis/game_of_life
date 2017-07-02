require "curses"


class CursesMap

    def initialize
        @cell_separator = " "
        @alive_cell = @cell_separator + "●"
        @dead_cell = @cell_separator + " "
        @cell_height = @alive_cell.length
    end

    def init_screen
        Curses.init_screen
        Curses.noecho
        Curses.start_color
        Curses.init_pair(1, Curses::COLOR_BLACK, Curses::COLOR_GREEN)
        Curses.init_pair(2, Curses::COLOR_CYAN, Curses::COLOR_BLACK)
        @screen_rows = Curses.lines
        @screen_cols = Curses.cols
    end

    def init_footer
        Curses.attron(Curses.color_pair(1))
        @screen_cols.times do |col|
            Curses.setpos(@screen_rows - 1, col)
            Curses.addstr(" ")
        end
        Curses.attron(Curses.color_pair(2))
    end

    def get_map_rows
        return @screen_rows - 1
    end

    def get_map_col(col)
        return (col / @cell_height)
    end
    
    def get_map_cols
        return get_map_col(@screen_cols)
    end

    def get_screen_col(col)
        return (col * @cell_height)
    end

    def print_cell(alive, i, j)
        map_row = i
        map_col = get_screen_col(j)
        Curses.setpos(map_row, map_col)
        if alive
            cell = @alive_cell
        else
            cell = @dead_cell
        end
        Curses.addstr(cell)
    end

    def update
        Curses.refresh
    end

    def print_footer(message)
        Curses.attron(Curses.color_pair(1))
        Curses.setpos(@screen_rows - 1, 0)
        Curses.addstr(message)
        Curses.attron(Curses.color_pair(2))
    end
end
