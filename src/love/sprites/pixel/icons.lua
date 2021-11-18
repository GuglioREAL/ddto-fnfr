--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten by HTV04
------------------------------------------------------------------------------]]

return graphics.newSprite(
	images["icons"],
	{
		{x = 0, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 1: Boyfriend
		{x = 30, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 2: Senpai
		{x = 60, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 3: Spirit
		{x = 90, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 4: Monika
		{x = 120, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 5: Monika Losing
		{x = 150, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 6: Duet
		{x = 180, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 7: Duet Losing
		{x = 210, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0}, -- 8: Demise
		{x = 240, y = 0, width = 30, height = 30, offsetX = 0, offsetY = 0, offsetWidth = 0, offsetHeight = 0} -- 9: Demise Losing
	},
	{
		["boyfriend"] = {start = 1, stop = 1, speed = 0, offsetX = 0, offsetY = 0},
		["senpai"] = {start = 2, stop = 2, speed = 0, offsetX = 0, offsetY = 0},
		["spirit"] = {start = 3, stop = 3, speed = 0, offsetX = 0, offsetY = 0},
		["monika"] = {start = 4, stop = 4, speed = 0, offsetX = 0, offsetY = 0},
		["monika losing"] = {start = 5, stop = 5, speed = 0, offsetX = 0, offsetY = 0},
		["duet"] = {start = 6, stop = 6, speed = 0, offsetX = 0, offsetY = 0},
		["duet losing"] = {start = 7, stop = 7, speed = 0, offsetX = 0, offsetY = 0},
		["demise"] = {start = 8, stop = 8, speed = 0, offsetX = 0, offsetY = 0},
		["demise losing"] = {start = 9, stop = 9, speed = 0, offsetX = 0, offsetY = 0}
	},
	"boyfriend",
	false,
	{
		floored = true
	}
)
