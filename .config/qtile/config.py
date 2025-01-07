from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, KeyChord, MatchAny
from libqtile.lazy import lazy
import os
import subprocess

# Variables
mod = "mod4"
terminal = "alacritty"
# Colors
bar_size = 25
bg_bar = "#00000000"
layout_margin = 5
border_width = 3
bfocus_matrix = "#316BA6"
bnormal_matrix = "#2D4D84"
bfocus_spiral = "#C4B0B1"
bnormal_spiral = "#6A6078"
group_font_size = 17
widget_fg = "#DCD9D2"
bg_groups = "#223763"
bg_group2 = "#6684AF"
bg_group3 = "#4B547A"
bg_group4 = "#19243F"
bg_mpd = "#937782"
bg_clock = "#1A1D28"
icon_fs = 16
alert = "#e56b6f"
active_color = "#C4B0B1"
inactive_color = "#1A1D28"


# Functions
def border(bColor, fColor, position):
    if position == 0:
        icon = ""
    else:
        icon = ""
    return widget.TextBox(
        text=icon,
        fontsize=bar_size,
        foreground=fColor,
        background=bColor,
        padding=-1,
    )


def separator(bColor):
    return widget.Sep(
        background=bColor,
        foreground="#00000000",
        padding=3,
    )


def icon(i, bColor, fColor):
    return widget.TextBox(
        text=i, fontsize=icon_fs, foreground=fColor, background=bColor
    )


# Key bindings
keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod, "control"], "t", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod, "shift"],
        "space",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "n", lazy.screen.next_group(), desc="Move to the group on the right"),
    Key([mod], "p", lazy.screen.prev_group(), desc="Move to the group on the left"),
    # Keys for sound
    # Keys for bright
    # Applications
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="Launcher"),
    Key([], "Print", lazy.spawn("scrot"), desc="Screenshot"),
    Key(
        [mod],
        "Print",
        lazy.spawn("scrot -s"),
        desc="Screenshot a section of the screen",
    ),
    KeyChord(
        [mod],
        "o",
        [
            Key([], "o", lazy.spawn("obsidian"), desc="Launch Obsidian"),
            Key([], "k", lazy.spawn("keepassxc"), desc="Launch Keepass"),
            Key([], "v", lazy.spawn("vlc"), desc="Launch VLC"),
            Key([], "p", lazy.spawn("pomotroid"), desc="Launch Pomotroid"),
        ],
        mode=True,
        name="Applications",
    ),
    KeyChord(
        [mod],
        "i",
        [
            Key([], "f", lazy.spawn("firefox"), desc="Launch Firefox"),
            Key([], "b", lazy.spawn("brave"), desc="Launch Brave"),
            Key([], "q", lazy.spawn("qutebrowser"), desc="Launch Qutebrowser"),
            Key([], "t", lazy.spawn("thunderbird"), desc="Launch Thunderbird"),
        ],
        mode=True,
        name="Internet",
    ),
    KeyChord(
        [mod],
        "g",
        [
            Key([], "s", lazy.spawn("steam"), desc="Launch Steam"),
        ],
        mode=True,
        name="Games",
    ),
    Key([mod], "t", lazy.spawn("telegram-desktop"), desc="Launch Telegram"),
    Key([mod], "e", lazy.spawn("emacsclient -c -a 'nvim'"), desc="Launch Telegram"),
    # Audio control keys
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
        desc="Increase volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
        desc="Decrease volume",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        desc="Toggle mute",
    ),
    # Bright control keys
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("xbacklight -inc 5"),
        desc="Increase brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("xbacklight -dec 5"),
        desc="Increase brightness",
    ),
    # Language Control key (just in case)
    Key(
        [mod],
        "F1",
        lazy.widget["keyboardlayout"].next_keyboard(),
        desc="Next keyboard layout",
    ),
    Key([mod], "F2", lazy.spawn("setxkbmap latam"), desc="Set latam keyboard layout"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

groups = [
    Group(name=str(idx), **group)
    for idx, group in enumerate(
        [
            {
                "label": " ",
                "spawn": "alacritty",
                "matches": Match(wm_class="Alacritty"),
            },
            {
                "label": " ",
                "layout": "max",
                "matches": MatchAny(
                    Match(role="browser"), Match(wm_class="qutebrowser")
                ),
            },
            {
                "label": " ",
                "layout": "max",
                "matches": Match(wm_class="MuPDF"),
            },
            {
                "label": " ",
                "layout": "max",
                "matches": Match(wm_class="TelegramDesktop"),
            },
            {
                "label": " ",
                "layout": "matrix",
                "matches": Match(wm_class="steam"),
            },
            {
                "label": " ",
                "layout": "monadtall",
                "matches": MatchAny(Match(wm_class="Thunar"), Match(wm_class="Geeqie")),
            },
            {
                "label": "󰕼 ",
                "layout": "monadtall",
                "matches": Match(wm_class="vlc"),
            },
            {
                "label": " ",
                "layout": "max",
                "matches": Match(wm_class="obsidian"),
            },
            {
                "label": " ",
                "layout": "max",
                "matches": MatchAny(
                    Match(wm_class="Connman-gtk"),
                    Match(wm_class="KeePassXC"),
                    Match(role="gimp-image-window-1"),
                    Match(wm_class="thunderbird"),
                    Match(wm_class="qBittorrent"),
                ),
            },
        ],
        start=1,
    )
]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Spiral(
        border_width=border_width,
        margin=layout_margin,
        border_focus=bfocus_spiral,
        border_normal=bnormal_spiral,
        new_client_position="after_current",
    ),
    layout.Max(),
    layout.Zoomy(margin=layout_margin),
    layout.Matrix(
        border_focus=bfocus_matrix,
        border_normal=bnormal_matrix,
        border_width=border_width,
        margin=layout_margin,
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
]

# Default settings for extensions and widgets
widget_defaults = dict(
    font="Hack Nerd Font",
    fontsize=13,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper="~/Images/Wallpapers/504f8a4f-87ca-453a-89dd-a33c88f1d0d9.png",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(background=bg_groups, foreground=widget_fg),
                separator(bg_groups),
                widget.GroupBox(
                    fontsize=group_font_size,
                    background=bg_groups,
                    active=active_color,
                    inactive=inactive_color,
                    highlight_method="line",
                    disable_drag=True,
                    hide_unused=True,
                    highlight_color=["#2D4D84", "#6684AF"],
                    urgent_alert_border=alert,
                    urgent_text=alert,
                ),
                separator(bg_groups),
                border(bg_bar, bg_groups, 1),
                widget.Prompt(
                    background=bg_bar, cursor_color=active_color, foreground=widget_fg
                ),
                widget.Spacer(background=bg_bar, lenght=bar.STRETCH),
                widget.Chord(
                    background=bg_bar,
                    foreground=widget_fg,
                    chords_colors={
                        "Internet": (bg_bar, bg_group2),
                        "Games": (bg_bar, bg_mpd),
                        "Applications": (bg_bar, widget_fg),
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                border(bg_bar, bg_mpd, 0),
                separator(bg_mpd),
                widget.Mpd2(
                    background=bg_mpd,
                    foreground=widget_fg,
                    font="Hurmit Nerd Font",
                    idle_format="{play_status}{idle_message}[{repeat}{random}]",
                    idle_message="IDLE",
                    no_connection="Disconnected",
                    play_status={"pause": " ", "play": " ", "stop": " "},
                    status_format="{artist}: {title}",
                ),
                separator(bg_mpd),
                border(bg_mpd, bg_group2, 0),
                separator(bg_group2),
                widget.KeyboardLayout(
                    background=bg_group2,
                    configured_keyboards=["latam", "us"],
                    foreground=widget_fg,
                ),
                icon("󰁹", bg_group2, widget_fg),
                widget.Battery(
                    background=bg_group2,
                    foreground=widget_fg,
                    format="{percent:2.0%}",
                    low_foreground=alert,
                ),
                icon("󰃠 ", bg_group2, widget_fg),
                widget.Backlight(
                    background=bg_group2,
                    foreground=widget_fg,
                    backlight_name="intel_backlight",
                    step=5,
                ),
                separator(bg_group2),
                border(bg_group2, bg_group3, 0),
                icon("󰕾 ", bg_group3, widget_fg),
                widget.PulseVolume(
                    background=bg_group3,
                    foreground=widget_fg,
                    step=5,
                    unmute_format="{volume}%",
                ),
                icon(" ", bg_group3, widget_fg),
                widget.Memory(
                    background=bg_group3, foreground=widget_fg, format="{MemPercent}%"
                ),
                widget.Clock(
                    background=bg_group3,
                    foreground=widget_fg,
                    format="%d-%m-%y %a %I:%M %p",
                ),
                separator(bg_group3),
                border(bg_group3, bg_group4, 0),
                widget.Systray(background=bg_group4),
                # widget.QuickExit(),
            ],
            bar_size,
            background=bg_bar,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# A function which generates group binding hotkeys. It takes a single
# argument, the DGroups object, and can use that to set up dynamic key
# bindings
dgroups_key_binder = None
# A list of Rule objects which can send windows to various
# groups based on matching criteria.
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = "floating_only"
floats_kept_above = True
cursor_warp = False
# Default floating layout to use. Here you can set custom floating rules
# among other things.
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


# Autostart
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.Popen([home])
