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

		boyfriend.x, boyfriend.y = 50, 30
		fakeBoyfriend.x, fakeBoyfriend.y = 50, 30

		enemyIcon:animate("dual demise", false)

		self:load()
	end,

	load = function(self)
		
		sky = graphics.newImage(love.graphics.newImage(graphics.imagePath("monika/FinaleBG_1")))
		school = graphics.newImage(love.graphics.newImage(graphics.imagePath("monika/FinaleBG_2")))
		street = graphics.newImage(love.graphics.newImage(graphics.imagePath("monika/FinaleFG")))
		enemy = love.filesystem.load("sprites/characters/Monika_Finale.lua")()
		boyfriend = love.filesystem.load("sprites/characters/boyfriendMad.lua")()

		spirit = love.filesystem.load("sprites/week6/spirit.lua")()
		monika = love.filesystem.load("sprites/characters/Monika_Finale.lua")()

		enemy.x = 50
		enemy.y = -160

		boyfriend.y = 45
		boyfriend.x = 50

		enemy.sizeX, enemy.sizeY = 1.2, 1.2

		school.sizeX, school.sizeY = 0.4, 0.4
		sky.sizeX, sky.sizeY = 0.3, 0.3
		street.sizeX, street.sizeY = 0.3, 0.3

		weeksPixel:load()

		inst = love.audio.newSource("music/extra/dual demise/Inst.ogg", "stream")
		voices = love.audio.newSource("music/extra/dual demise/Voices.ogg", "stream")
		monika.x, monika.y = -35, 5
		spirit.x, spirit.y = -80, 30
		enemy.x, enemy.y = -50, 0

		self:initUI()

		weeksPixel:setupCountdownDemise()
		
	end,

	initUI = function(self)
		weeksPixel:initUI()

		weeksPixel:generateNotes(love.filesystem.load("charts/extra/dual demise" .. difficulty .. ".lua")())
		
	end,

	update = function(self, dt)
		graphics.screenBase(256, 144)

		weeksPixel:update(dt)
		spirit:update(dt)
		monika:update(dt)

		if enemy:getAnimName() == "idle" then
			enemy:animate("yo mama", false)
			spirit:animate("idle", false)
			monika:animate("idle", false)
		end

		if enemy:getAnimName() == "up alt" then
			spirit:animate("up", false)
			enemy:animate("yo mama", false)
		elseif enemy:getAnimName() == "down alt" then
			spirit:animate("down", false)
			enemy:animate("yo mama", false)
		elseif enemy:getAnimName() == "right alt" then
			spirit:animate("right", false)
			enemy:animate("yo mama", false)
		elseif enemy:getAnimName() == "left alt" then
			spirit:animate("left", false)
			enemy:animate("yo mama", false)
		end
		if enemy:getAnimName() == "up" then
			monika:animate("up", false)
			enemy:animate("yo mama", false)
		elseif enemy:getAnimName() == "down" then
			monika:animate("down", false)
			enemy:animate("yo mama", false)
		elseif enemy:getAnimName() == "right" then
			monika:animate("right", false)
			enemy:animate("yo mama", false)
		elseif enemy:getAnimName() == "left" then
			monika:animate("left", false)
			enemy:animate("yo mama", false)
		end

		if musicTime >= 12632 then
			if musicTime <= 12700 then
				monika:animate("idle", true)
			end
		end
		if musicTime >= 22736 then
			if musicTime <= 22800 then
				monika:animate("idle", true)
			end
		end
		if musicTime >= 42947 then
			if musicTime <= 43000 then
				monika:animate("idle", true)
			end
		end
		if musicTime >= 53052 then
			if musicTime <= 53100 then
				monika:animate("idle", true)
			end
		end
		if musicTime >= 73421 then
			if musicTime <= 73400 then
				monika:animate("idle", true)
			end
		end
		if musicTime >= 83368 then
			if musicTime <= 83400 then
				monika:animate("idle", true)
			end
		end

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
					monika:draw()
					spirit:draw()

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