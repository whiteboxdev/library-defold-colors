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

dcolors.vault = {}
dcolors.palette = nil

----------------------------------------------------------------------
-- LOCAL FUNCTIONS
----------------------------------------------------------------------

local function parse_hue(p, q, t)
	if t < 0 then
		t = t + 1
	elseif t > 1 then
		t = t - 1
	end
	if t < 1 / 6 then
		return p + (q - p) * 6 * t
	end
	if t < 0.5 then
		return q
	end
	if t < 2 / 3 then
		return p + (q - p) * (2 / 3 - t) * 6
	end
	return p
end

----------------------------------------------------------------------
-- MODULE FUNCTIONS
----------------------------------------------------------------------

function dcolors.set_red(color, red)
	return vmath.vector4(red, color.y, color.z, color.w)
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
		if not dcolors.palette then
			dcolors.choose_palette(palette_name)
		end
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

function dcolors.premultiply_alpha(color)
	return vmath.vector4(bit.rshift(color.x * color.w, 8), bit.rshift(color.y * color.w, 8), bit.rshift(color.z * color.w, 8), color.w)
end

function dcolors.to_scale_1(color)
	return vmath.vector4(color.x / 255, color.y / 255, color.z / 255, color.w / 255)
end

function dcolors.to_scale_100(color)
	return vmath.vector4(math.floor(color.x * 100), math.floor(color.y * 100), math.floor(color.z * 100), math.floor(color.w * 100))
end

function dcolors.to_scale_255(color)
	return vmath.vector4(math.floor(color.x * 255), math.floor(color.y * 255), math.floor(color.z * 255), math.floor(color.w * 255))
end

function dcolors.rgba_to_hsla(color)
	local max = math.max(color.x, color.y, color.z)
	local min = math.min(color.x, color.y, color.z)
	local average = (max + min) * 0.5
	local result = vmath.vector4(average, average, average, color.w)
	if max == min then
		result.x = 0
		result.y = 0
	else
		local difference = max - min
		result.y = result.z > 0.5 and difference / (2 - max - min) or difference / (max + min)
		if max == color.x then
			result.x = (color.y - color.z) / difference + (color.y < color.z and 6 or 0)
		elseif max == color.y then
			result.x = (color.z - color.x) / difference + 2
		elseif max == color.z then
			result.x = (color.x - color.y) / difference + 4
		end
		result.x = result.x / 6
	end
	return result
end

function dcolors.hsla_to_rgba(color)
	local result = vmath.vector4(0, 0, 0, color.w)
	if color.y == 0 then
		result.x = color.z
		result.y = color.z
		result.z = color.z
	else
		local q = color.z < 0.5 and color.z * (1 + color.y) or color.z + color.y - color.z * color.y
		local p = 2 * color.z - q
		result.x = parse_hue(p, q, color.x + 1 / 3)
		result.y = parse_hue(p, q, color.x)
		result.z = parse_hue(p, q, color.x - 1 / 3)
	end
	return result
end

function dcolors.rgba_to_hex(color)
	local to_scale_255 = dcolors.to_scale_255(color)
	local r = string.format("%x", to_scale_255.x)
	local g = string.format("%x", to_scale_255.y)
	local b = string.format("%x", to_scale_255.z)
	local a = string.format("%x", to_scale_255.w)
	return (#r == 1 and "0" or "") .. r .. (#g == 1 and "0" or "") .. g .. (#b == 1 and "0" or "") .. b .. (#a == 1 and "0" or "") .. a
end

function dcolors.hex_to_rgba(color)
	local r = tonumber("0x" .. string.sub(color, 1, 2))
	local g = tonumber("0x" .. string.sub(color, 3, 4))
	local b = tonumber("0x" .. string.sub(color, 5, 6))
	local a = tonumber("0x" .. string.sub(color, 7, 8))
	return dcolors.to_scale_1(vmath.vector4(r, g, b, a))
end

return dcolors