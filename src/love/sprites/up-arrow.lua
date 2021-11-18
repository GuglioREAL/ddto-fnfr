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
	images.notes,
	{
		{x = 507, y = 10, width = 157, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: arrowUP0000
		{x = 10, y = 254, width = 51, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: green hold end0000
		{x = 71, y = 254, width = 51, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: green hold piece0000
		{x = 132, y = 254, width = 157, height = 154, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: green0000
		{x = 553, y = 1064, width = 238, height = 233, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: up confirm0000
		{x = 801, y = 1064, width = 238, height = 233, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: up confirm0001
		{x = 1049, y = 1064, width = 215, height = 211, offsetX = -11, offsetY = -11, offsetWidth = 238, offsetHeight = 233}, -- 7: up confirm0002
		{x = 1049, y = 1064, width = 215, height = 211, offsetX = -11, offsetY = -11, offsetWidth = 238, offsetHeight = 233}, -- 8: up confirm0003
		{x = 1274, y = 1064, width = 144, height = 142, offsetX = -5, offsetY = -4, offsetWidth = 154, offsetHeight = 150}, -- 9: up press0000
		{x = 1274, y = 1064, width = 144, height = 142, offsetX = -5, offsetY = -4, offsetWidth = 154, offsetHeight = 150}, -- 10: up press0001
		{x = 1428, y = 1064, width = 154, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: up press0002
		{x = 1428, y = 1064, width = 154, height = 150, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 12: up press0003
	},
	{
		["off"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["on"] = {start = 4, stop = 4, speed = 0, offsetX = 0, offsetY = 0},
		["end"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["hold"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0},
		["confirm"] = {start = 5, stop = 8, speed = 24, offsetX = 0, offsetY = 0},
		["press"] = {start = 9, stop = 12, speed = 24, offsetX = 0, offsetY = 0}
	},
	"off",
	false
)
