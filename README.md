# Defold Colors
Defold Colors (dcolors) 1.1.0 provides customizable palettes and color utility features to a Defold game engine project.

An [example project](https://github.com/klaytonkowalski/defold-colors/tree/master/example) is available if you need additional help with configuration.

Please click the "Star" button on GitHub if you find this asset to be useful!

![alt text](https://github.com/klaytonkowalski/defold-colors/blob/master/assets/thumbnail.png?raw=true)

## Installation
To install dcolors into your project, add one of the following links to your `game.project` dependencies:
  - https://github.com/klaytonkowalski/defold-colors/archive/master.zip
  - URL of a [specific release](https://github.com/klaytonkowalski/defold-colors/releases)

## Configuration
Import the dcolors Lua module into your relevant scripts:
`local dcolors = require "dcolors.dcolors"`

The `dcolors.palette` property allows you to access the colors stored inside the loaded palette. A palette is structured as follows:

```
example = {
    white = vmath.vector4(1, 1, 1, 1),
    black = vmath.vector4(0, 0, 0, 1),
    yellow = vmath.vector4(1, 0, 1, 1),
    ...
}
```

In this case, `example` is the name of the palette. Each color inside has a key of `name` and a value of `vector4`.

To access a color, use `dcolors.palette.COLOR_NAME`. To add or remove colors from a palette, use the [color-related functions](#dcolorscheck_colorpalette-color).

To add or remove palettes, use the [palette-related functions](#dcolorscheck_palettepalette). To change the palette which `dcolors.palette` refers to, call `dcolors.choose_palette()`.

You may also use dcolors for its utility features, separate from its palette service. For example, `dcolors.set_alpha()` modifies the `vector4` passed in, then returns the new color. This is useful for consolidating code. For example, let us assume you want to get the color of a gui node, modify its alpha value to `100`, then set the color of that gui node to the modified color. Normally, you could perform this task like so:

```
local color = gui.get_color(gui.get_node("node"))
color.w = 100
gui.set_color(gui.get_node("node"), color)
```

However, with the inline convenience of dcolors, you could perform this task like so:

```
gui.set_color(gui.get_node("node"), dcolors.set_alpha(gui.get_color(gui.get_node("node")), 100))
```

RGB, HSL, and Hex conversions are also supported.

## API: Properties

### dcolors.vault

Table containing all registered palettes and colors. This may be traversed if you are saving or loading color data. You may also use `dcolors.vault.PALETTE_NAME.COLOR_NAME` to avoid switching palettes with `dcolors.choose_palette()`. The vault is structured as follows:

```
dcolors.vault =
{
	<palette_name> =
	{
		<color_name> = vmath.vector4( ... ),
        	...
	},
	...
}
```

### dcolors.palette

Currently loaded palette. To access a color, use `dcolors.palette.COLOR_NAME`. A palette is structured as follows:

```
<palette_name> =
{
    <color_name> = vmath.vector4( ... ),
    ...
}
```

## API: Functions

### dcolors.set_red(color, red)

Sets the red component of a color.

#### Parameters
1. `color`: `vector4` to modify.
2. `red`: Number denoting a new red value.

#### Returns

Returns a `vector4`.

---

### dcolors.set_green(color, green)

Sets the green component of a color.

#### Parameters
1. `color`: `vector4` to modify.
2. `green`: Number denoting a new green value.

#### Returns

Returns a `vector4`.

---

### dcolors.set_blue(color, blue)

Sets the blue component of a color.

#### Parameters
1. `color`: `vector4` to modify.
2. `blue`: Number denoting a new blue value.

#### Returns

Returns a `vector4`.

---

### dcolors.set_alpha(color, alpha)

Sets the alpha component of a color.

#### Parameters
1. `color`: `vector4` to modify.
2. `alpha`: Number denoting a new alpha value.

#### Returns

Returns a `vector4`.

---

### dcolors.check_palette(palette_name)

Checks if a palette exists.

#### Parameters
1. `palette_name`: Name of palette.

#### Returns

Returns `true` or `false`.

---

### dcolors.add_palette(palette_name)

Adds an empty palette to the vault. If no palette is currently loaded, then `dcolors.palette` becomes `palette_name`. Does nothing if the palette already exists.

#### Parameters
1. `palette_name`: Name of palette.

---

### dcolors.remove_palette(palette_name)

Removes a palette from the vault. If the currently loaded palette is removed, then `dcolors.palette` becomes `nil`. Does nothing if the palette does not exist.

#### Parameters
1. `palette_name`: Name of palette.

---

### dcolors.clear_palette(palette_name)

Clears all colors from a palette. Does nothing if the palette does not exist.

#### Parameters
1. `palette_name`: Name of palette.

---

### dcolors.choose_palette(palette_name)

Points the `dcolors.palette` property to a palette. Does nothing if the palette does not exist.

#### Parameters
1. `palette_name`: Name of palette.

---

### dcolors.check_color(palette_name, color)

Checks if a color exists within a palette.

#### Parameters
1. `palette_name`: Name of palette.
2. `color`: `vector4` **or** name of color.

#### Returns

Returns `true` or `false`.

---

### dcolors.add_color(palette_name, color_name, color)

Adds a color to a palette. Does nothing if the palette does not exist. If `color_name` already exists, its associated color value will be overwritten with `color`.

#### Parameters
1. `palette_name`: Name of palette.
2. `color_name`: Name of color.
3. `color`: `vector4` to add.

---

### dcolors.remove_color(palette_name, color)

Removes a color from a palette. Does nothing if the palette does not exist. Does nothing if the color does not exist.

#### Parameters
1. `palette`: Name of palette.
2. `color`: `vector4` **or** name of color.

---

### dcolors.premultiply_alpha(color)

Applies `color.w` to its other components.

#### Parameters
1. `color`: `vector4` to modify.

#### Returns

Returns a `vector4`.

---

### dcolors.to_scale_1(color)

Scales a color between \[0.0, 1.0\].

#### Parameters
1. `color`: `vector4` to modify.

#### Returns

Returns a `vector4`.

---

### dcolors.to_scale_100(color)

Scales a color between \[0, 100\].

#### Parameters
1. `color`: `vector4` to modify.

#### Returns

Returns a `vector4`.

---

### dcolors.to_scale_255(color)

Scales a color between \[0, 255\].

#### Parameters
1. `color`: `vector4` to modify.

#### Returns

Returns a `vector4`.

---

### dcolors.rgba_to_hsla(color)

Converts an RGBA color to HSLA.

#### Parameters
1. `color`: `vector4` to convert.

#### Returns

Returns a `vector4` where `.x = [0, 360], .y = [0, 100], .z = [0, 100]`.

---

### dcolors.hsla_to_rgba(color)

Converts an HSLA color to RGBA.

#### Parameters
1. `color`: `vector4` to convert. **Note:** Expected component scale: `.x = [0, 360], .y = [0, 100], .z = [0, 100]`.

#### Returns

Returns a `vector4`.

---

### dcolors.rgba_to_hex(color)

Converts an RGBA color to Hex.

#### Parameters
1. `color`: `vector4` to convert.

#### Returns

Returns a `string`.

---

### dcolors.hex_to_rgba(color)

Converts a Hex color to RGBA.

#### Parameters
1. `color`: `string` to convert. **Note:** Do not include a prefix such as `0x` or `#`.

#### Returns

Returns a `vector4`.
