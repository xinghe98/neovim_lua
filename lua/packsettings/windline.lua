local default = {
    filetypes={'default'},
    active={
      --- components...
    },
    inactive={
      --- components...
    }
}

local explorer = {
    filetypes = {'fern', 'NvimTree','netrw','coc-explorer'},
    active = {
        {'  ', {'white', 'black'} },
    },
    --- show active components when the window is inactive
    always_active = true,
    --- It will display a last window statusline even that window should inactive
    show_last_status = true
}
local windline = require('wlsample.evil_line')
windline.setup({
  statuslines = {
 --- you need to define your status lines here
 default,
 --explorer,
  }
})


