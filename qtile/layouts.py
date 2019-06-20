from libqtile import layout
import solarized

layouts = [
    # layout.Max(),
    # layout.MonadTall(border_focus=solarized.base02),
    # layout.Floating(),
    layout.Bsp(fair=False),
    # layout.Columns(),
    # layout.Matrix(),
    layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Slice(),
    # layout.Stack(),
    # layout.Tile(),
    # layout.TreeTab(),
    layout.VerticalTile(),
    #layout.Wmii(),
    layout.Zoomy(margin=5)
]

floating_layout = layout.Floating(
    float_rules=[
        {'wmclass': 'confirm'},
        {'wmclass': 'dialog'},
        {'wmclass': 'download'},
        {'wmclass': 'error'},
        {'wmclass': 'file_progress'},
        {'wmclass': 'notification'},
        {'wmclass': 'splash'},
        {'wmclass': 'toolbar'},
        {'wmclass': 'guake'},
        {'wmclass': 'confirmreset'},  # gitk
        {'wmclass': 'makebranch'},  # gitk
        {'wmclass': 'maketag'},  # gitk
        {'wname': 'branchdialog'},  # gitk
        {'wname': 'pinentry'},  # GPG key password entry
        {'wmclass': 'ssh-askpass'},  # ssh-askpass
    ],
    border_focus=solarized.base02)
