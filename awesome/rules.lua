-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Remove titlebars
    { rule_any = { type = { "dialog", "normal" } }, 
      properties = { titlebars_enabled = false } },

    -- Set Firefox to always map on the first tag on screen 1.
    -- Also force non-maximized and non-floating for tiling compatability
    { rule = { class = "Firefox" },
        properties = { maximized = false, floating = false } },
--        properties = { maximized = false, floating = false, screen = 1, tag = awful.util.tagnames[1] } },

    { rule = { class = "Gimp", role = "gimp-image-window" },
          properties = { maximized = true } },
}
-- }}}
