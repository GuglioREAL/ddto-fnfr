--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]

return graphics.newSprite(
	love.graphics.newImage(graphics.imagePath("menu/titleEnter")),
    	-- Automatically generated from titleEnter.xml
	{
		{x = 10, y = 10, width = 1477, height = 96, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: ENTER PRESSED0000
		{x = 10, y = 116, width = 1477, height = 96, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: ENTER PRESSED0001
		{x = 10, y = 222, width = 1477, height = 96, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 3: Press Enter to Begin0000
	},
    {
        ["anim"] = {start = 3, stop = 3, speed = 24, offsetX = 0, offsetY = 0},
        ["pressed"] = {start = 1, stop = 2, speed = 24, offsetX = 0, offsetY = 0}
    },
    "anim",
    false
)