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
	love.graphics.newImage(graphics.imagePath("menu/storymenu/difficulties")),
    	-- Automatically generated from difficulties.xml
	{
		{x = 10, y = 10, width = 434, height = 103, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Easy0000
		{x = 10, y = 123, width = 434, height = 103, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Hard0000
		{x = 10, y = 236, width = 434, height = 103, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 3: Normal0000
	},
    {
        ["easy"] = {start = 1, stop = 1, speed = 24, offsetX = 0, offsetY = 0},
        ["normal"] = {start = 3, stop = 3, speed = 24, offsetX = 0, offsetY = 0},
        ["hard"] = {start = 2, stop = 2, speed = 24, offsetX = 0, offsetY = 0}
    },
    "normal",
    true
)