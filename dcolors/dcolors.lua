----------------------------------------------------------------------
-- LICENSE
----------------------------------------------------------------------

-- MIT License

-- Copyright (c) 2020 Klayton Kowalski

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- https://github.com/klaytonkowalski/defold-colors

----------------------------------------------------------------------
-- PROPERTIES
----------------------------------------------------------------------

local dcolors = {}

dcolors.vault =
{
	main =
	{
		white = vmath.vector4(1, 1, 1, 1),
		grey = vmath.vector4(0.5, 0.5, 0.5, 1),
		black = vmath.vector4(0, 0, 0, 1),
		red = vmath.vector4(1, 0, 0, 1),
		green = vmath.vector4(0, 1, 0, 1),
		blue = vmath.vector4(0, 0, 1, 1),
		yellow = vmath.vector4(1, 1, 0, 1),
		magenta = vmath.vector4(1, 0, 1, 1),
		cyan = vmath.vector4(0, 1, 1, 1),
		light_grey = vmath.vector4(0.75, 0.75, 0.75, 1),
		light_red = vmath.vector4(1, 0.5, 0.5, 1),
		light_green = vmath.vector4(0.5, 1, 0.5, 1),
		light_blue = vmath.vector4(0.5, 0.5, 1, 1),
		light_yellow = vmath.vector4(1, 1, 0.5, 1),
		light_magenta = vmath.vector4(1, 0.5, 1, 1),
		light_cyan = vmath.vector4(0.5, 1, 1, 1),
		dark_grey = vmath.vector4(0.25, 0.25, 0.25, 1),
		dark_red = vmath.vector4(0.5, 0, 0, 1),
		dark_green = vmath.vector4(0, 0.5, 0, 1),
		dark_blue = vmath.vector4(0, 0, 0.5, 1),
		dark_yellow = vmath.vector4(0.5, 0.5, 0, 1),
		dark_magenta = vmath.vector4(0.5, 0, 0.5, 1),
		dark_cyan = vmath.vector4(0, 0.5, 0.5, 1),
		transparent_white = vmath.vector4(1, 1, 1, 0),
		transparent_black = vmath.vector4(0, 0, 0, 0),
		transparent_red = vmath.vector4(1, 0, 0, 0),
		transparent_green = vmath.vector4(0, 1, 0, 0),
		transparent_blue = vmath.vector4(0, 0, 1, 0),
		transparent_yellow = vmath.vector4(1, 1, 0, 0),
		transparent_magenta = vmath.vector4(1, 0, 1, 0),
		transparent_cyan = vmath.vector4(0, 1, 1, 0)
	}
}

dcolors.palette = dcolors.vault.main

----------------------------------------------------------------------
-- MODULE FUNCTIONS
----------------------------------------------------------------------

function dcolors.set_red(color, red)
	return vmath.vector4(red, 100, color.y, color.z, color.w)
end

function dcolors.set_green(color, green)
	return vmath.vector4(color.x, green, color.z, color.w)
end

function dcolors.set_blue(color, blue)
	return vmath.vector4(color.x, color.y, blue, color.w)
end

function dcolors.set_alpha(color, alpha)
	return vmath.vector4(color.x, color.y, color.z, alpha)
end

function dcolors.set_component(color, red, green, blue, alpha)
	return vmath.vector4(red or color.x, green or color.y, blue or color.z, alpha or color.w)
end

function dcolors.check_palette(palette_name)
	for key, _ in pairs(dcolors.vault) do
		if key == palette_name then
			return true
		end
	end
	return false
end

function dcolors.add_palette(palette_name)
	if not dcolors.check_palette(palette_name) then
		dcolors.vault[palette_name] = {}
	end
end

function dcolors.remove_palette(palette_name)
	if dcolors.check_palette(palette_name) then
		if dcolors.palette == dcolors.vault[palette_name] then
			dcolors.palette = nil
		end
		dcolors.vault[palette_name] = nil
	end
end

function dcolors.clear_palette(palette_name)
	if dcolors.check_palette(palette_name) then
		for key, _ in pairs(dcolors.vault[palette_name]) do
			dcolors.vault[palette_name][key] = nil
		end
	end
end

function dcolors.choose_palette(palette_name)
	if dcolors.check_palette(palette_name) then
		dcolors.palette = dcolors.vault[palette_name]
	end
end

function dcolors.check_color(palette_name, color)
	if dcolors.check_palette(palette_name) then
		for key, value in pairs(dcolors.vault[palette_name]) do
			if type(color) == "string" and key == color then
				return true
			elseif type(color) == "userdata" and value == color then
				return true
			end
		end
	end
	return false
end

function dcolors.add_color(palette_name, color_name, color)
	if dcolors.check_palette(palette_name) and not dcolors.check_color(palette_name, color_name) then
		dcolors.vault[palette_name][color_name] = color
	end
end

function dcolors.remove_color(palette_name, color)
	if dcolors.check_color(palette_name, color_name) then
		for key, value in pairs(dcolors.vault[palette_name]) do
			if type(color_name) == "string" and key == color_name then
				dcolors.vault[palette_name][key] = nil
				return
			elseif type(color_name) == "userdata" and value == color_name then
				dcolors.vault[palette_name][key] = nil
				return
			end
		end
	end
end

function dcolors.to_rgba_1(red, green, blue, alpha)
	return vmath.vector4(red / 255, green / 255, blue / 255, alpha / 255)
end

function dcolors.to_rgba_255(red, green, blue, alpha)
	return vmath.vector4(math.floor(red * 255), math.floor(green * 255), math.floor(blue * 255), math.floor(alpha * 255))
end

function dcolors.premultiply_alpha(component, alpha)
	return bit.rshift(component * alpha, 8)
end

function dcolors.debug()
	print("dcolors: START DEBUG STATE")
	print("dcolors: ---- Is dcolors.palette valid? [" .. tostring(dcolors.palette and true or false) .. "]")
	for key, value in pairs(dcolors.vault) do
		print("dcolors: ---- Palette [" .. key .. "]")
		for key_2, value_2 in pairs(value) do
			print("dcolors: -------- Color [" .. key_2 .. "] [" .. tostring(value_2) .. "]")
		end
	end
	print("dcolors: END DEBUG STATE")
end

return dcolors