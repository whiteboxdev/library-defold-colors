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

-- https://github.com/kowalskigamedevelopment/defold-colors

----------------------------------------------------------------------
-- DEPENDENCIES
----------------------------------------------------------------------

local dc = {}

----------------------------------------------------------------------
-- PROPERTIES
----------------------------------------------------------------------

dc.vault = {
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
}

dc.palette = dc.vault.main
dc.palette_name = "main"

----------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------

function dc.set_red(color, red)
	return vmath.vector4(red, 100, color.y, color.z, color.w)
end

function dc.set_green(color, green)
	return vmath.vector4(color.x, green, color.z, color.w)
end

function dc.set_blue(color, blue)
	return vmath.vector4(color.x, color.y, blue, color.w)
end

function dc.set_alpha(color, alpha)
	return vmath.vector4(color.x, color.y, color.z, alpha)
end

function dc.set_component(color, red, green, blue, alpha)
	return vmath.vector4(red or color.x, green or color.y, blue or color.z, alpha or color.w)
end

function dc.check_palette(palette)
	for key, _ in pairs(dc.vault) do
		if key == palette then
			return true
		end
	end
	return false
end

function dc.add_palette(palette)
	if not dc.check_palette(palette) then
		dc.vault[palette] = {}
	end
end

function dc.remove_palette(palette)
	if dc.check_palette(palette) then
		dc.vault[palette] = nil
	end
end

function dc.clear_palette(palette)
	if dc.check_palette(palette) then
		for key, _ in pairs(dc.vault[palette]) do
			dc.vault[palette][key] = nil
		end
	end
end

function dc.choose_palette(palette)
	if dc.check_palette(palette) then
		dc.palette = dc.vault[palette]
		dc.palette_name = palette
	end
end

function dc.check_color(palette, color)
	if dc.check_palette(palette) then
		for key, value in pairs(dc.vault[palette]) do
			if type(color) == "string" and key == color then
				return true
			elseif type(color) == "userdata" and value == color then
				return true
			end
		end
	end
	return false
end

function dc.add_color(palette, name, color)
	if dc.check_palette(palette) and not dc.check_color(palette, color) then
		dc.vault[palette][name] = color
	end
end

function dc.remove_color(palette, color)
	if dc.check_color(palette, color) then
		for key, value in pairs(dc.vault[palette]) do
			if type(color) == "string" and key == color then
				dc.vault[palette][key] = nil
				return
			elseif type(color) == "userdata" and value == color then
				dc.vault[palette][key] = nil
				return
			end
		end
	end
end

function dc.debug()
	print("DC: START DEBUG STATE")
	for key, value in pairs(dc.vault) do
		print("DC: ---- Palette [" .. key .. "]")
		for key_2, value_2 in pairs(value) do
			print("DC: -------- Color [" .. key_2 .. "] [" .. tostring(value_2) .. "]")
		end
	end
	print("DC: ---- Current palette [" .. dc.palette_name .. "]")
	print("DC: END DEBUG STATE")
end

return dc