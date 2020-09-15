# Defold Colors
Defold Colors (DC) 1.0.0 provides customizable palettes and color utility features to a Defold game engine project.

An [example project](https://github.com/gymratgames/defold-colors/tree/master/example) is available if you need additional help with configuration.

Please click the "Star" button on GitHub if you find this asset to be useful!  
If you wish to support me and the work I do, please consider becoming one of my [patrons](https://www.patreon.com/klaytonkowalski).

![alt text](https://github.com/gymratgames/defold-colors/blob/master/assets/thumbnail.png?raw=true)

## Installation
To install DC into your project, add one of the following links to your `game.project` dependencies:
  - https://github.com/gymratgames/defold-colors/archive/master.zip
  - URL of a [specific release](https://github.com/gymratgames/defold-colors/releases)

## Configuration
Import the DC Lua module into your relevant scripts:
`local dc = require "dc.dc"`

The `dc.palette` property allows you to access the colors stored inside the loaded palette. A palette is structured as follows:

```
main = {
    white = vmath.vector4(255 / 255, 255 / 255, 255 / 255, 255 / 255),
    black = vmath.vector4(0 / 255, 0 / 255, 0 / 255, 255 / 255),
    red = vmath.vector4(255 / 255, 0 / 255, 0 / 255, 255 / 255),
    green = vmath.vector4(0 / 255, 255 / 255, 0 / 255, 255 / 255),
    blue = vmath.vector4(0 / 255, 0 / 255, 255 / 255, 255 / 255),
    yellow = vmath.vector4(255 / 255, 255 / 255, 0 / 255, 255 / 255),
    magenta = vmath.vector4(255 / 255, 0 / 255, 255 / 255, 255 / 255),
    cyan = vmath.vector4(0 / 255, 255 / 255, 255 / 255, 255 / 255)
}
```

In this case, `main` is the name of the palette. Each color inside has a key of `name` and a value of `vector4`. This palette comes packaged with the DC library and is loaded by default.

To access a color, use `dc.palette.COLOR_NAME`. You can also reference the `dc.palette_name` property to get a string representation of the loaded palette's name. For example, typing `dc.palette_name` will return `"main"`.

To add or remove colors from a palette, use the [color-related functions](#dccheck_colorpalette-color).

To add or remove palettes, use the [palette-related functions](#dccheck_palettepalette). To switch between palettes, call `dc.choose_palette()`.

You may also use DC for its simple utility features, separate from its palette service. For example, `dc.set_alpha()` modifies the `vector4` passed in, then returns the new color. This is useful for consolidating code. For example, let us assume you want to get the color of a gui node, modify its alpha value to `100`, then set the color of that gui node to the modified color. Normally, you could perform this task like so:

```
local color = gui.get_color(gui.get_node("node"))
color.w = 100
gui.set_color(gui.get_node("node"), color)
```

However, with the inline convenience of DC, you could perform this task like so:

```
gui.set_color(gui.get_node("node"), dc.set_alpha(gui.get_color(gui.get_node("node")), 100))
```

## API: Properties

### dc.vault

Table containing all registered palettes and colors. This may be accessed if you are looking to save and load color data. **Note**: It is recommended that you use the [API](#api-functions) to access or modify color data.

The vault is structured as follows:

```
dc.vault = {
	<palette_name> = {
		<color_name> = vmath.vector4( ... ),
        ...
	}
}
```

### dc.palette

Allows access to the colors stored inside the loaded palette. A palette is structured as follows:

```
<palette_name> = {
    <color_name> = vmath.vector4( ... ),
    ...
}
```

### dc.palette_name

String representation of the loaded palette. This is useful for referencing the current palette when calling certain functions.

## API: Functions

### dc.set_red(color, red)

Sets the red component of a color.

#### Parameters
1. `color`: `vector4` to modify.
2. `red`: Number denoting a new red value.

#### Returns

Returns a `vector4`.

---

### dc.set_green(color, green)

Sets the green component of a color.

#### Parameters
1. `color`: `vector4` to modify.
2. `green`: Number denoting a new green value.

#### Returns

Returns a `vector4`.

---

### dc.set_blue(color, blue)

Sets the blue component of a color.

#### Parameters
1. `color`: `vector4` to modify.
2. `blue`: Number denoting a new blue value.

#### Returns

Returns a `vector4`.

---

### dc.set_alpha(color, alpha)

Sets the alpha component of a color.

#### Parameters
1. `color`: `vector4` to modify.
2. `alpha`: Number denoting a new alpha value.

#### Returns

Returns a `vector4`.

---

### dc.set_component(color, red, green, blue, alpha)

Sets one or many components of a color. Fill arguments as `nil` if they should remain unchanged.

#### Parameters
1. `color`: `vector4` to modify.
2. `red`: Number denoting a new red value.
3. `green`: Number denoting a new green value.
4. `blue`: Number denoting a new blue value.
5. `alpha`: Number denoting a new alpha value.

#### Returns

Returns a `vector4`.

---

### dc.check_palette(palette)

Checks if a palette exists.

#### Parameters
1. `palette`: String representation of the palette's name.

#### Returns

Returns `true` or `false`.

---

### dc.add_palette(palette)

Adds an empty palette to the system. Does nothing if the palette already exists.

#### Parameters
1. `palette`: String representation of the palette's name.

---

### dc.remove_palette(palette)

Removes a palette to the system. Does nothing if the palette does not exist.

#### Parameters
1. `palette`: String representation of the palette's name.

---

### dc.clear_palette(palette)

Clears all colors from a palette. Does nothing if the palette does not exist.

#### Parameters
1. `palette`: String representation of the palette's name.

---

### dc.choose_palette(palette)

Points the `dc.palette` property to a palette. Does nothing if the palette does not exist.

#### Parameters
1. `palette`: String representation of the palette's name.

---

### dc.check_color(palette, color)

Checks if a color exists within a palette.

#### Parameters
1. `palette`: String representation of the palette's name.
2. `color`: `vector4` **or** string representation of the color's name.

#### Returns

Returns `true` or `false`.

---

### dc.add_color(palette, name, color)

Adds a color to a palette. Does nothing if the palette does not exist. If `name` already exists, its associated color value will be overwritten with `color`.

#### Parameters
1. `palette`: String representation of the palette's name.
2. `name`: String representation of the color's name.
3. `color`: `vector4` to add.

---

### dc.remove_color(palette, color)

Removes a color from a palette. Does nothing if the palette does not exist. Does nothing if the color does not exist.

#### Parameters
1. `palette`: String representation of the palette's name.
2. `color`: `vector4` **or** string representation of the color's name.

---

### dc.debug()

Prints debug information to the terminal.
