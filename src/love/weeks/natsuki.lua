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

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		farbg = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/clubroom/DDLCfarbg")))
		clubroom = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/clubroom/DDLCbg")))
		desks = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/clubroom/DesksFront")))

		doodles = love.filesystem.load("sprites/doki/clubroom/doodles.lua")()

		sayori = love.filesystem.load("sprites/doki/bgdoki/sayori.lua")()
		yuri = love.filesystem.load("sprites/doki/bgdoki/yuri.lua")()

		girlfriend = love.filesystem.load("sprites/characters/dokiGF.lua")()

		boyfriend = love.filesystem.load("sprites/characters/dokiBF.lua")()

		fakeBoyfriend = love.filesystem.load("sprites/boyfriend.lua")()

		enemy = love.filesystem.load("sprites/characters/natsuki.lua")()

		clubroom.sizeX, clubroom.sizeY = 1.4, 1.4
		farbg.sizeX, farbg.sizeY = 1.4, 1.4
		desks.sizeX, desks.sizeY = 1.2, 1.2

		sayori.x, sayori.y = 375, 160

		yuri.x, yuri.y = -375, 130

		yuri.sizeX, yuri.sizeY = 0.6, 0.6

		sayori.sizeX, sayori.sizeY = 0.6, 0.6

		girlfriend.x, girlfriend.y = 30, 150
		enemy.x, enemy.y = -380, 220
		boyfriend.x, boyfriend.y = 260, 320
		desks.y = 125
		doodles.sizeX, doodles.sizeY = 2.25, 2.25
		doodles.y = 325
		doodles.x = 560

		boyfriend.sizeX, boyfriend.sizeY, girlfriend.sizeX, girlfriend.sizeY, enemy.sizeX, enemy.sizeY = 0.9, 0.9, 0.9, 0.9, 0.9, 0.9

		enemyIcon:animate("natsuki", false)

		self:load()
	end,

	load = function(self)
		weeks:load()

		if song == 2 then
			inst = love.audio.newSource("music/natsuki/baka/Inst.ogg", "stream")
			voices = love.audio.newSource("music/natsuki/baka/Voices.ogg", "stream")

		else
			inst = love.audio.newSource("music/natsuki/my sweets/Inst.ogg", "stream")
			voices = love.audio.newSource("music/natsuki/my sweets/Voices.ogg", "stream")
		end

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 2 then
			weeks:generateNotes(love.filesystem.load("charts/natsuki/baka" .. difficulty .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/natsuki/my sweets" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
		yuri:update(dt)
		sayori:update(dt)
		doodles:update(dt)

		if health >= 80 then
			if enemyIcon:getAnimName() == "natsuki" then
				enemyIcon:animate("natsuki losing", false)
			end
		else
			if enemyIcon:getAnimName() == "natsuki losing" then
				enemyIcon:animate("natsuki", false)
			end
		end -- 18000
		if song == 2 then
			if musicTime >= 17500 then
				if musicTime <= 18200 then
					doodles:animate("rock", true)
					cam.sizeX, cam.sizeY = 1.4, 1.4
					camScale.x, camScale.y = 1.4, 1.4
				end
			end
			if musicTime >= 25750 then
				if musicTime <= 26200 then
					cam.sizeX, cam.sizeY = 0.9, 0.9
					camScale.x, camScale.y = 0.9, 0.9
				end
			end
			if musicTime >= 78400 then
				if musicTime <= 79000 then
					doodles:animate("normal", true)
				end
			end
			if musicTime >= 90750 then
				if musicTime <= 91250 then
					doodles:animate("rock", true)
				end
				
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
				sayori:draw()
				yuri:draw()

				girlfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				enemy:draw()
				boyfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)
				desks:draw()

				

			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()
		if song == 2 then
			if musicTime >= 8500 then
				if musicTime <= 63700 then
					doodles:draw()
				end
			end
			if musicTime >= 78400 then
				doodles:draw()
			end
		end
		weeks:drawUI()
	end,

	leave = function(self)
		farbg = nil
		clubroom = nil
		desks = nil
		staticshock = nil
		doodles = nil

		weeks:leave()
	end
}
