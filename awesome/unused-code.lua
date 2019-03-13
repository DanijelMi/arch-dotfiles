
-- Add a titlebar if titlebars_enabled is set to true in the rules.
--client.connect_signal("request::titlebars", function(c)
    -- Custom
--    if beautiful.titlebar_fun then
--        beautiful.titlebar_fun(c)
--        return
--    end

    -- Default
    -- buttons for the titlebar
--    buttons = my_table.join(
--        awful.button({ }, 1, function()
--            c:emit_signal("request::activate", "titlebar", {raise = true})
--            awful.mouse.client.move(c)
--        end),
--        awful.button({ }, 2, function() c:kill() end),
--        awful.button({ }, 3, function()
--            c:emit_signal("request::activate", "titlebar", {raise = true})
--            awful.mouse.client.resize(c)
--        end)
--    )

--    awful.titlebar(c, {size = 16}) : setup {
--        { -- Left
--            awful.titlebar.widget.iconwidget(c),
--            buttons = buttons,
--            layout  = wibox.layout.fixed.horizontal
--        },
--        { -- Middle
--            { -- Title
--                align  = "center",
--                widget = awful.titlebar.widget.titlewidget(c)
--            },
--            buttons = buttons,
--            layout  = wibox.layout.flex.horizontal
--        },
--        { -- Right
--            awful.titlebar.widget.floatingbutton (c),
--            awful.titlebar.widget.maximizedbutton(c),
--            awful.titlebar.widget.stickybutton   (c),
--            awful.titlebar.widget.ontopbutton    (c),
--            awful.titlebar.widget.closebutton    (c),
--            layout = wibox.layout.fixed.horizontal()
--        },
--        layout = wibox.layout.align.horizontal
--    }
--end)





-- {{{ Menu
--myawesomemenu = {
--    { "hotkeys", function() return false, hotkeys_popup.show_help end },
--    { "manual", terminal .. " -e man awesome" },
--    { "edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
--    { "restart", awesome.restart },
--    { "quit", function() awesome.quit() end }
--}
--awful.util.mymainmenu = freedesktop.menu.build({
--    icon_size = beautiful.menu_height or 16,
--    before = {
--        { "Awesome", myawesomemenu, beautiful.awesome_icon },
--        -- other triads can be put here
--    },
--    after = {
--        { "Open terminal", terminal },
--        -- other triads can be put here
--    }
--})
--]]

-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}


-- This function implements the XDG autostart specification
--[[
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)
--]]


-- layouts
    --awful.layout.suit.floating,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    --lain.layout.cascade,
    --lain.layout.cascade.tile,
    --lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
