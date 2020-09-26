#include "text_print.h"
#include "type_defs.h"
#include "text_color_codes.h"
#include "IDT.h"

extern const char Testing[];

void _start()
{
    clear_screen(BACKGROUND_COLOR_BLUE | COLOR_WHITE);
    set_cursor_position(0);
    init_IDT();

    print_string(Testing, DEFAULT_STYLE);

}