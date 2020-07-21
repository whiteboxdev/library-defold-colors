----------------------------------------------------------------------
-- LICENSE
----------------------------------------------------------------------

-- Defold Colors 1.0.0 is the best way to work with colors in a Defold game engine project.
-- Copyright (C) 2020  Klayton Kowalski

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as published
-- by the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.

-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

----------------------------------------------------------------------
-- DEPENDENCIES
----------------------------------------------------------------------

local dc = {}

----------------------------------------------------------------------
-- PROPERTIES
----------------------------------------------------------------------

dc.palette = {
	white = vmath.vector4(255 / 255, 255 / 255, 255 / 255, 255 / 255),
	black = vmath.vector4(0 / 255, 0 / 255, 0 / 255, 255 / 255),
	red = vmath.vector4(255 / 255, 0 / 255, 0 / 255, 255 / 255),
	green = vmath.vector4(0 / 255, 255 / 255, 0 / 255, 255 / 255),
	blue = vmath.vector4(0 / 255, 0 / 255, 255 / 255, 255 / 255),
	yellow = vmath.vector4(255 / 255, 255 / 255, 0 / 255, 255 / 255),
	magenta = vmath.vector4(255 / 255, 0 / 255, 255 / 255, 255 / 255),
	cyan = vmath.vector4(0 / 255, 255 / 255, 255 / 255, 255 / 255),
}

dc.debug = false

----------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------

function dc.set_debug(debug)
	dc.debug = debug
end

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

function dc.check_color(key)
	for palette_key, _ in pairs(dc.palette) do
		if palette_key == key then
			return true
		end
	end
	return false
end

function dc.add_color(key, color)
	if not dc.check_color(key) then
		dc.palette[key] = color
		if dc.debug then
			print("DC: Color added to palette. [" .. key .. "]")
		end
	elseif dc.debug then
		print("DC: Failed to add color to palette. It already exists. [" .. key .. "]")
	end
end

function dc.remove_color(key)
	if dc.check_color(key) then
		dc.palette[key] = nil
		if dc.debug then
			print("DC: Color removed from palette. [" .. key .. "]")
		end
	elseif dc.debug then
		print("DC: Failed to remove color from palette. It does not exist. [" .. key .. "]")
	end
end

return dc