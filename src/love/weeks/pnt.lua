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

local canvas, font 

local song, difficulty

local sky, school, street, treesBack

local petals, trees, freaks

return {
	enter = function(self, from, songNum, songAppend)
		love.graphics.setDefaultFilter("nearest")

		status.setNoResize(true)

		canvas = love.graphics.newCanvas(256, 144)
		font = love.graphics.newFont("fonts/pixel_small.fnt")

		weeksPixel:enter()

		song = songNum
		difficulty = songAppend

		cam.sizeX, cam.sizeY = 1, 1
		camScale.x, camScale.y = 1, 1

		
		sky = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/sky")))
		school = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/school")))
		street = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/street")))
		treesBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/trees-back")))

		trees = love.filesystem.load("sprites/week6/trees.lua")()
		petals = love.filesystem.load("sprites/week6/petals.lua")()
		freaks = love.filesystem.load("sprites/week6/freaks.lua")()

        boyfriend = love.filesystem.load("sprites/pixel/boyfriend.lua")()

        girlfriend = love.filesystem.load("sprites/pixel/girlfriend.lua")()

        enemy = love.filesystem.load("sprites/characters/duet_assets.lua")()


		sky.y = 1
		school.y = 1
		

		boyfriend.x, boyfriend.y = 50, 30
		fakeBoyfriend.x, fakeBoyfriend.y = 50, 30


		self:load()
	end,

	load = function(self)



		freaks:animate("dissuaded", true)
		enemyIcon:animate("duet", false)
		
		

		weeksPixel:load()


		
		inst = love.audio.newSource("music/extra/poems n thorns/Inst.ogg", "stream")
		voices = love.audio.newSource("music/extra/poems n thorns/Voices.ogg", "stream")
	
		enemy.x, enemy.y = -50, 0

		self:initUI()
		
		weeksPixel:setupCountdown()

	end,

	initUI = function(self)
		weeksPixel:initUI()
		
		weeksPixel:generateNotes(love.filesystem.load("charts/extra/poems n thorns" .. difficulty .. ".lua")())

	end,

	update = function(self, dt)
		graphics.screenBase(256, 144)

		weeksPixel:update(dt)

		if health >= 80 then
			if enemyIcon:getAnimName() == "duet" then
				enemyIcon:animate("duet losing", false)
			end
		else
			if enemyIcon:getAnimName() == "duet losing" then
				enemyIcon:animate("duet", false)
			end
		end

		trees:update(dt)
		petals:update(dt)
		freaks:update(dt)

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) then
			if storyMode and song < 3 then
				song = song + 1

				self:load()
			else
				status.setLoading(true)

				graphics.fadeOut(
					0.5,
					function()
						Gamestate.switch(menu)

						status.setLoading(false)
					end
				)
			end
		end

		weeksPixel:updateUI(dt, canvas)
	end,

	draw = function(self)
		local canvasScale

		love.graphics.setFont(font)
		graphics.screenBase(256, 144)
		love.graphics.setCanvas(canvas)
			love.graphics.clear()

			love.graphics.push()
				love.graphics.translate(128, 72)
				love.graphics.scale(cam.sizeX, cam.sizeY)

				love.graphics.push()
					love.graphics.translate(math.floor(cam.x * 0.9), math.floor(cam.y * 0.9))

					
					sky:draw()
					

					school:draw()
				love.graphics.pop()
				love.graphics.push()
					love.graphics.translate(math.floor(cam.x), math.floor(cam.y))

					street:draw()
					treesBack:draw()
					trees:draw()
					petals:draw()

					
					freaks:draw()
					
					girlfriend:draw()
					enemy:draw()
					boyfriend:draw()
				love.graphics.pop()
				weeksPixel:drawRating()
			love.graphics.pop()

			weeksPixel:drawUI()
		love.graphics.setCanvas()
		graphics.screenBase(love.graphics.getWidth(), love.graphics.getHeight())

		canvasScale = math.min(math.floor(graphics.getWidth() / 256), math.floor(graphics.getHeight() / 144))
		if canvasScale < 1 then canvasScale = math.min(graphics.getWidth() / 256, graphics.getHeight() / 144) end

		love.graphics.draw(canvas, graphics.getWidth() / 2, graphics.getHeight() / 2, nil, canvasScale, canvasScale, 128, 72)
	end,

	leave = function(self)
		canvas = nil
		font = nil

		sky = nil
		school = nil
		street = nil

		weeksPixel:leave()

		status.setNoResize(false)

		love.graphics.setDefaultFilter("linear")
	end
}
--[[

Bro who even believes in gravity anymore??


Just walk on walls

]]--
