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

local song, difficulty

local farbg, clubroom

local obsession = 1

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		farbg = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/clubroom/DDLCfarbg")))
		clubroom = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/clubroom/DDLCbg")))
		desks = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/clubroom/DesksFront")))

		natsuki = love.filesystem.load("sprites/doki/bgdoki/natsuki.lua")()
		sayori = love.filesystem.load("sprites/doki/bgdoki/sayori.lua")()

		girlfriend = love.filesystem.load("sprites/characters/dokiGF.lua")()

		boyfriend = love.filesystem.load("sprites/characters/dokiBF.lua")()

		fakeBoyfriend = love.filesystem.load("sprites/boyfriend.lua")()

		enemy = love.filesystem.load("sprites/characters/yuri.lua")()

		

		clubroom.sizeX, clubroom.sizeY = 1.4, 1.4
		farbg.sizeX, farbg.sizeY = 1.4, 1.4
		desks.sizeX, desks.sizeY = 1.2, 1.2

		natsuki.x, natsuki.y = 375, 160

		sayori.x, sayori.y = -375, 130

		sayori.sizeX, sayori.sizeY = 0.6, 0.6

		natsuki.sizeX, natsuki.sizeY = 0.6, 0.6


		girlfriend.x, girlfriend.y = 30, 150
		enemy.x, enemy.y = -380, 180
		boyfriend.x, boyfriend.y = 260, 320
		desks.y = 125

		boyfriend.sizeX, boyfriend.sizeY, girlfriend.sizeX, girlfriend.sizeY, enemy.sizeX, enemy.sizeY = 0.9, 0.9, 0.9, 0.9, 0.9, 0.9

		enemyIcon:animate("yuri", false)

		self:load()
	end,

	load = function(self)
		weeks:load()

		if song == 2 then
			inst = love.audio.newSource("music/yuri/obsession/Inst.ogg", "stream")
			voices = love.audio.newSource("music/yuri/obsession/Voices.ogg", "stream")

			crazyYuri = love.filesystem.load("sprites/characters/crazyyuri.lua")()

			vig = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/vignette")))

			black = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/black")))

			vig.sizeX, vig.sizeY = 2.1, 2.1
			
			black.sizeX, black.sizeY = 2.2, 2.2



			crazyYuri.x, crazyYuri.y = enemy.x, enemy.y 
		else
			inst = love.audio.newSource("music/yuri/deep breaths/Inst.ogg", "stream")
			voices = love.audio.newSource("music/yuri/deep breaths/Voices.ogg", "stream")
		end

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 2 then
			weeks:generateNotes(love.filesystem.load("charts/yuri/obsession" .. difficulty .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/yuri/deep breaths" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
		sayori:update(dt)
		natsuki:update(dt)

		if song == 2 then
			crazyYuri:update(dt)
			if musicTime >= 70480 then
				if enemy:getAnimName() == "left" then
					crazyYuri:animate("left", true)
					enemy:animate("breath", true)
				elseif enemy:getAnimName() == "right" then
					crazyYuri:animate("right", true)
					enemy:animate("breath", true)
				elseif enemy:getAnimName() == "up" then
					crazyYuri:animate("up", true)
					enemy:animate("breath", true)
				elseif enemy:getAnimName() == "down" then
					crazyYuri:animate("down", true)
					enemy:animate("breath", true)
				elseif enemy:getAnimName() == "idle" then
					crazyYuri:animate("idle", true)
					enemy:animate("breath", true)
				end
			end
		end

		if health >= 80 then
			if enemyIcon:getAnimName() == "yuri" then
				enemyIcon:animate("yuri losing", false)
			end
		else
			if enemyIcon:getAnimName() == "yuri losing" then
				enemyIcon:animate("yuri", false)
			end
		end
		if health >= 80 then
			if enemyIcon:getAnimName() == "yuri-c" then
				enemyIcon:animate("yuri-c losing", false)
			end
		else
			if enemyIcon:getAnimName() == "yuri-c losing" then
				enemyIcon:animate("yuri-c", false)
			end
		end

		if song == 1 then
			if musicTime >= 18900 then
				if musicTime <= 19200 then
					audio.playSound(sounds.breath)
					enemy:animate("breath", false)
				end
			end
		end

		if song == 2 then
			if musicTime >= 70480 then
				obsession = 2
				if girlfriend:getAnimName() == "idle" then
					girlfriend:animate("snap", true)
					if enemyIcon:getAnimName() == "yuri" then
						enemyIcon:animate("yuri-c", false)
					elseif enemyIcon:getAnimName() == "yuri losing" then
						enemyIcon:animate("yuri-c losing", false)
					end
				end
				cam.sizeX, cam.sizeY = 1.6, 1.6
				camScale.x, camScale.y = crazyYuri.x, crazyYuri.y - 10
				boyfriend.x = -65
			end
		end

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) then
			if storyMode and song < 2 then
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

		weeks:updateUI(dt)
	end,

	draw = function(self)
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)


				farbg:draw()
				clubroom:draw()
				desks:draw()
				if song == 1 then
					natsuki:draw()
					sayori:draw()
				end
				if song == 2 then
					if musicTime <= 70480 then
						natsuki:draw()
						sayori:draw()
					end
				end

				girlfriend:draw()
				if song == 2 then
					if musicTime >= 77950 then
						if musicTime <= 300000 then
							graphics.setColor(1, 1, 1, 0.6)
							black:draw()
							graphics.setColor(1, 1, 1, 1)
						end
					end
				end

			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)
				if song == 1 then
					enemy:draw()
				elseif song == 2 then
					if musicTime <= 70480 then
						enemy:draw()
					end
					if musicTime >= 70480 then
						if musicTime <= 300000 then
							crazyYuri:draw()
						end
					end
				end
					

				boyfriend:draw()
				
				
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)
				desks:draw()
				
			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()
		if song == 2 then
			if musicTime >= 70480 then
				if musicTime <= 300000 then
					vig:draw()
				end
			end
		end
        weeks:drawUI()
		if song == 2 then
			if musicTime >= 70480 then
				if musicTime <= 77950 then
					black:draw()
				end
			end
		end
	end,

	leave = function(self)
		farbg = nil
		clubroom = nil
		desks = nil
		crazyyuri = nil
		vig = nil
		black = nil
		obsession = 1

		weeks:leave()
	end
}
