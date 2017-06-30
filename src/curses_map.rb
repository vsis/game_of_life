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
        @screen_rows = Curses.lines
        @screen_cols = Curses.cols
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
        Curses.setpos(@screen_rows, 0)
        Curses.clrtoeol
        Curses.addstr(message)
    end
end
