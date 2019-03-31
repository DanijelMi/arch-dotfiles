--[[

     Blackburn Awesome WM theme 3.0
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/custom"
theme.wallpaper                                 = theme.dir .. "/wall.png"
theme.font                                      = "droid 10.5"
theme.taglist_font                              = "dejavu 11"
theme.fg_normal                                 = "#D7D7D7"
theme.fg_focus                                  = "#F6784F"
theme.bg_normal                                 = "#060606"
theme.bg_focus                                  = "#060606"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#2A1F1E"
theme.border_width                              = 2
theme.border_normal                             = "#0E0E0E"
theme.border_focus                              = "#FFFFFF"
theme.taglist_fg_focus                          = "#F6784F"
theme.taglist_bg_focus                          = "#060606"
theme.tasklist_fg_focus                         = "#F6784F"
theme.tasklist_bg_focus                         = "#060606"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_uptime                             = theme.dir .. "/icons/ac.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_weather                            = theme.dir .. "/icons/dish.png"
theme.widget_fs                                 = theme.dir .. "/icons/fs.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_note                               = theme.dir .. "/icons/note.png"
theme.widget_note_on                            = theme.dir .. "/icons/note_on.png"
theme.widget_netdown                            = theme.dir .. "/icons/net_down.png"
theme.widget_netup                              = theme.dir .. "/icons/net_up.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_batt                               = theme.dir .. "/icons/bat.png"
theme.widget_clock                              = theme.dir .. "/icons/clock.png"
theme.widget_vol                                = theme.dir .. "/icons/spkr.png"

theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.useless_gap                               = 4

awful.util.tagnames   = { " A", " B", " C", " D", " E", " F", " G" }

local markup     = lain.util.markup
local separators = lain.util.separators
local gray       = "#9E9C9A"

-- Textclock
local textclock = wibox.widget.textclock("%H:%M")
textclock.font = theme.font

-- MPD
theme.mpd = lain.widget.mpd({
    settings = function()
        mpd_notification_preset.fg = white
        artist = mpd_now.artist .. " "
        title  = mpd_now.title  .. " "

        if mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        elseif mpd_now.state == "stop" then
            artist = ""
            title  = ""
        end

        widget:set_markup(markup.font(theme.font, markup(gray, artist) .. title .. " "))
    end
})

-- Coretemp
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#f1af5f", coretemp_now .. "°C"))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_batt)
local bat = lain.widget.bat({
    settings = function()
        bat_p      = bat_now.perc .. "%"
        widget:set_markup(markup.font(theme.font, bat_p))
    end
})

-- ALSA volume
local volicon = wibox.widget.imagebox(theme.widget_vol)
theme.volume = lain.widget.alsa({
    --togglechannel = "IEC958,3",
    settings = function()
        vlevel  = volume_now.level
        if volume_now.status == "off" then
            vlevel = vlevel .. "M"
        else
            vlevel = vlevel .. "   "
        end
        widget:set_markup(markup.font(theme.font, vlevel))
    end
})

-- Weather
theme.weather = lain.widget.weather({
    city_id = 785756, -- openweathermap.org city id (785756 - Smederevo)
    settings = function()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.font(theme.font, units .. " "))
    end
})

-- Memory Usage
local memicon = wibox.widget.imagebox(theme.widget_mem)
local memory = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e0da37", mem_now.perc))
    end
})

-- CPU Usage
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#e33a6e", cpu_now.usage .. "%"))
    end
})

-- Network download rate
local netdownicon = wibox.widget.imagebox(theme.widget_netdown)
local netdown = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#19EC00", string.format("%.2f", net_now.received) ))
    end
})

-- Network upload rate
local netupicon = wibox.widget.imagebox(theme.widget_netup)
local netup = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#22A7F9", string.format("%.2f", net_now.sent)))
    end
})

-- Separators
local arrl_pre  = separators.arrow_right("alpha", "#1A1A1A")
local arrl_post = separators.arrow_right("#1A1A1A", "alpha")

local barheight = 18
local barcolor  = gears.color({
    type  = "linear",
    from  = { barheight, 0 },
    to    = { barheight, barheight },
    stops = { {0, theme.bg_focus }, {0.8, theme.border_normal}, {1, "#1A1A1A"} }
})
theme.titlebar_bg = barcolor

theme.titlebar_bg_focus = gears.color({
    type  = "linear",
    from  = { barheight, 0 },
    to    = { barheight, barheight },
    stops = { {0, theme.bg_normal}, {0.5, theme.border_normal}, {1, "#492417"} }
})

function theme.at_screen_connect(s)
    -- Quake application
    s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 18, bg = barcolor })

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, { bg_normal = barcolor, bg_focus = barcolor })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            arrl_pre,
            s.mylayoutbox,
            arrl_post,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            netdownicon,
            netdown.widget,
            netupicon,
            netup.widget,
            cpuicon,
            cpu.widget,
            memicon,
            memory.widget,
            tempicon,
            temp.widget,
            theme.weather.icon,
            theme.weather.widget,
            --theme.fs.widget,
            baticon,
            bat,
            volicon,
            theme.volume.widget,
            textclock,
        },
    }
end

return theme
