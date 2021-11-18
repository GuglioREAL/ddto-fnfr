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

		if song ~= 3 then
			sky = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/sky")))
			school = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/school")))
			street = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/street")))
			treesBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/trees-back")))

			trees = love.filesystem.load("sprites/week6/trees.lua")()
			petals = love.filesystem.load("sprites/week6/petals.lua")()
			freaks = love.filesystem.load("sprites/week6/freaks.lua")()

			sky.y = 1
			school.y = 1
		end

		boyfriend.x, boyfriend.y = 50, 30
		fakeBoyfriend.x, fakeBoyfriend.y = 50, 30

		enemyIcon:animate("monika", false)

		self:load()
	end,

	load = function(self)
		if song == 3 then
			sky = graphics.newImage(love.graphics.newImage(graphics.imagePath("monika/FinaleBG_1")))
			school = graphics.newImage(love.graphics.newImage(graphics.imagePath("monika/FinaleBG_2")))
			street = graphics.newImage(love.graphics.newImage(graphics.imagePath("monika/FinaleFG")))
			enemy = love.filesystem.load("sprites/characters/Monika_Finale.lua")()
			boyfriend = love.filesystem.load("sprites/characters/boyfriendMad.lua")()


			enemy.x = 50
			enemy.y = -160

			boyfriend.y = 45
			boyfriend.x = 50

			enemy.sizeX, enemy.sizeY = 1.2, 1.2


			school.sizeX, school.sizeY = 0.4, 0.4
			sky.sizeX, sky.sizeY = 0.3, 0.3
			street.sizeX, street.sizeY = 0.3, 0.3

			

			enemyIcon:animate("demise", false)
		elseif song == 2 then
			enemy = love.filesystem.load("sprites/characters/duet_assets.lua")()

			freaks:animate("dissuaded", true)
			enemyIcon:animate("duet", false)
		else
			enemy = love.filesystem.load("sprites/characters/monikapixel.lua")()
		end

		weeksPixel:load()

		if song == 3 then
			inst = love.audio.newSource("music/monika/your demise/Inst.ogg", "stream")
			voices = love.audio.newSource("music/monika/your demise/Voices.ogg", "stream")
		elseif song == 2 then
			inst = love.audio.newSource("music/monika/bara no yume/Inst.ogg", "stream")
			voices = love.audio.newSource("music/monika/bara no yume/Voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/monika/high school conflict/Inst.ogg", "stream")
			voices = love.audio.newSource("music/monika/high school conflict/Voices.ogg", "stream")
		end
		enemy.x, enemy.y = -50, 0

		self:initUI()
		if song ~= 3 then
			weeksPixel:setupCountdown()
		else
			weeksPixel:setupCountdownDemise()
		end
	end,

	initUI = function(self)
		weeksPixel:initUI()

		if song == 3 then
			weeksPixel:generateNotes(love.filesystem.load("charts/monika/your demise" .. difficulty .. ".lua")())
		elseif song == 2 then
			weeksPixel:generateNotes(love.filesystem.load("charts/monika/bara no yume" .. difficulty .. ".lua")())
		else
			weeksPixel:generateNotes(love.filesystem.load("charts/monika/high school conflict" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		graphics.screenBase(256, 144)

		weeksPixel:update(dt)
		if song == 1 then
			if health >= 80 then
				if enemyIcon:getAnimName() == "monika pixel" then
					enemyIcon:animate("monika pixel losing", false)
				end
			else
				if enemyIcon:getAnimName() == "monika pixel losing" then
					enemyIcon:animate("monika pixel", false)
				end
			end
		elseif song == 2 then
			if health >= 80 then
				if enemyIcon:getAnimName() == "duet" then
					enemyIcon:animate("duet losing", false)
				end
			else
				if enemyIcon:getAnimName() == "duet losing" then
					enemyIcon:animate("duet", false)
				end
			end
		end
		-- Since demise uses the same icon, I don't add one


		if song ~= 3 then
			trees:update(dt)
			petals:update(dt)
		end
		if song == 2 then
			freaks:update(dt)
		end

		if song == 2 then 
			if musicTime >= 74000 then
				if musicTime <= 75500 then
					if enemy:getAnimName() == "up" then
						enemy:animate("up alt", false)
					elseif enemy:getAnimName() == "down" then
						enemy:animate("down alt", false)
					elseif enemy:getAnimName() == "right" then
						enemy:animate("right alt", false)
					elseif enemy:getAnimName() == "left" then
						enemy:animate("left alt", false)
					end
				elseif musicTime <= 79000 then
					if enemy:getAnimName() == "up" then
						enemy:animate("up alt", false)
					elseif enemy:getAnimName() == "down" then
						enemy:animate("down alt", false)
					elseif enemy:getAnimName() == "right" then
						enemy:animate("right alt", false)
					elseif enemy:getAnimName() == "left" then
						enemy:animate("left alt", false)
					end
				end
			end -- 39000
		elseif song == 3 then
			if musicTime >= 39000 then
				if musicTime <= 41000 then
					if enemy:getAnimName() == "up" then
						enemy:animate("up glitch", false)
					elseif enemy:getAnimName() == "down" then
						enemy:animate("down glitch", false)
					elseif enemy:getAnimName() == "right" then
						enemy:animate("right glitch", false)
					elseif enemy:getAnimName() == "left" then
						enemy:animate("left glitch", false)
					end
				elseif musicTime <= 53000 then
					if enemy:getAnimName() == "up" then
						enemy:animate("up glitch", false)
					elseif enemy:getAnimName() == "down" then
						enemy:animate("down glitch", false)
					elseif enemy:getAnimName() == "right" then
						enemy:animate("right glitch", false)
					elseif enemy:getAnimName() == "left" then
						enemy:animate("left glitch", false)
					end
				end
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
					if song ~= 3 then
						treesBack:draw()
						trees:draw()
						petals:draw()
					end
					if song == 2 then
						freaks:draw()
					end
					if song ~= 3 then
						girlfriend:draw()
					end
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
