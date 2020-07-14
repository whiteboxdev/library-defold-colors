----------------------------------------------------------------------
-- LICENSE & CREDITS
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

----------------------------------------------------------------------
-- DEPENDENCIES
----------------------------------------------------------------------

local dc = {}

----------------------------------------------------------------------
-- LOCAL FUNCTIONS
----------------------------------------------------------------------

local function clamp_rgba(r, g, b, a)
	return math.floor(r) % 256 / 255, math.floor(g) % 256 / 255, math.floor(b) % 256 / 255, math.floor(a) % 256 / 255
end

local function clamp_hsla(h, s, l, a)
	return math.floor(h) % 360, smath.floor(s) % 101 * 0.01, math.floor(l) % 101 * 0.01, math.floor(a) % 256 / 255
end

----------------------------------------------------------------------
-- USER PROPERTIES
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
	orange = vmath.vector4(255 / 255, 127 / 255, 0 / 255, 255 / 255),
	indigo = vmath.vector4(75 / 255, 0 / 255, 130 / 255, 255 / 255),
	violet = vmath.vector4(150 / 255, 0 / 255, 255 / 255, 255 / 255)
	brown = vmath.vector4(120 / 255, 95 / 255, 75 / 255, 255 / 255)
}

----------------------------------------------------------------------
-- USER FUNCTIONS
----------------------------------------------------------------------

function dc.make_color(r, g, b, a)
	r, g, b, a = clamp_rgba(r, g, b, a)
	return vmath.vector4(r, g, b, a)
end

function dc.saturate(s, percent)
	local result = s + percent
	return result <= 100 and result or 100
end

function dc.desaturate(s, percent)
	local result = s - percent
	if result >= 0 then
		return result
	end
	return 0
end

function dc.lighten(l, percent)
	local result = l + percent
	return result <= 100 and result or 100
end

function dc.darken(l, percent)
	local result = l - percent
	if result >= 0 then
		return result
	end
	return 0
end

function dc.materialize(a, percent)
	local result = a + percent * 2.55
	return result <= 255 and result or 255
end

function dc.fade(a, percent)
	local result = a - percent * 2.55
	if result >= 0 then
		return result
	end
	return 0
end

function dc.rgba_to_hsla(r, g, b, a)
	r, g, b, a = clamp_rgba(r, g, b, a)
	cmax = math.max(r, g, b)
	cmin = math.min(r, g, b)
	cdif = cmax - cmin
	local result = { h = 0, s = 0, l = (cmax + cmin) * 0.5, a = a * 100}
	if cdif ~= 0 then
		if cmax == r then
			result.h = 60 * (g - b) / cdif % 6
		elseif cmax == g then
			result.h = 60 * ((b - r) / cdif + 2)
		elseif cmax == b then
			result.h = 60 * ((r - g) / cdif + 4)
		end
		result.s = cdif / (1 - math.abs(2 * result.l - 1)) * 100
	end
	result.l = result.l * 100
	return result
end

function dc.hsla_to_rgba(h, s, l, a)
	h, s, l, a = clamp_hsla(h, s, l, a)
	c = s * (1 - math.abs(2 * l - 1))
	x = c * (1 - math.abs(h / 60 % 2 - 1))
	m = l - c * 0.5
	if h < 60 then
		return vmath.vector4(c + m, x + m, 0 + m, a)
	end
	if h < 120 then
		return vmath.vector4(x + m, c + m, 0 + m, a)
	end
	if h < 180 then
		return vmath.vector4(0 + m, c + m, x + m, a)
	end
	if h < 240 then
		return vmath.vector4(0 + m, x + m, c + m, a)
	end
	if h < 300 then
		return vmath.vector4(x + m, 0 + m, c + m, a)
	end
	if h < 360 then
		return vmath.vector4(c + m, 0 + m, x + m, a)
	end
end

return dc