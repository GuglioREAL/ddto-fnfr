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
		{x = 342, y = 10, width = 155, height = 157, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: arrowRIGHT0000
		{x = 1333, y = 828, width = 154, height = 157, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: red0000
		{x = 1211, y = 828, width = 51, height = 64, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: red hold end0000
		{x = 1272, y = 828, width = 51, height = 44, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: red hold piece0000
		{x = 1497, y = 828, width = 225, height = 226, offsetX = -1, offsetY = -2, offsetWidth = 227, offsetHeight = 229}, -- 5: right confirm0000
		{x = 1732, y = 828, width = 225, height = 226, offsetX = -1, offsetY = -2, offsetWidth = 227, offsetHeight = 229}, -- 6: right confirm0001
		{x = 10, y = 1064, width = 227, height = 229, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: right confirm0002
		{x = 10, y = 1064, width = 227, height = 229, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: right confirm0003
		{x = 247, y = 1064, width = 138, height = 141, offsetX = -3, offsetY = -7, offsetWidth = 148, offsetHeight = 151}, -- 9: right press0000
		{x = 247, y = 1064, width = 138, height = 141, offsetX = -3, offsetY = -7, offsetWidth = 148, offsetHeight = 151}, -- 10: right press0001
		{x = 395, y = 1064, width = 148, height = 151, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 11: right press0002
		{x = 395, y = 1064, width = 148, height = 151, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 12: right press0003
	},
	{
		["off"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["on"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["end"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0},
		["hold"] = {start = 4, stop = 4, speed = 0, offsetX = 0, offsetY = 0},
		["confirm"] = {start = 5, stop = 8, speed = 24, offsetX = 0, offsetY = 0},
		["press"] = {start = 9, stop = 12, speed = 24, offsetX = 0, offsetY = 0}
	},
	"off",
	false
)
