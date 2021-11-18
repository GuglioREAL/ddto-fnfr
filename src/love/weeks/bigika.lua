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

local sky, room

local amongus

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		amongus = "notsus"

		sky = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/bigmonika/Sky")))
		black = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/black")))
		room = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/bigmonika/BG")))
		desk = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/bigmonika/FG")))

		girlfriend = love.filesystem.load("sprites/characters/dokiGF.lua")()

		boyfriend = love.filesystem.load("sprites/characters/dokiBF.lua")()

		fakeBoyfriend = love.filesystem.load("sprites/characters/monikaBDeath.lua")()

		enemy = love.filesystem.load("sprites/characters/monikaB.lua")()

		girlfriend.x, girlfriend.y = 30, 150
		enemy.x, enemy.y = 0, 110
		boyfriend.x, boyfriend.y = 260, 320
		black.sizeX, black.sizeY = 2, 2
		desk.y = 125

		enemyIcon:animate("bmonika", false) 

		self:load()
	end,

	load = function(self)
		weeks:load()

		inst = love.audio.newSource("music/extra/epiphany/Inst.ogg", "stream")
		voices = love.audio.newSource("music/extra/epiphany/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/extra/epiphany.lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)


		if health >= 80 then
			if enemyIcon:getAnimName() == "bmonika" then
				enemyIcon:animate("bmonika losing", false)
			end
		else
			if enemyIcon:getAnimName() == "bmonika losing" then
				enemyIcon:animate("bmonika", false)
			end
		end



		if musicTime >= 177000 then
			if musicTime <= 300000 then
				if enemy:getAnimName() == "right" then
					enemy:animate("last", false)
				end
			end
		end 


		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) then
			if storyMode and song < 1 then
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

				sky:draw()
				room:draw()
				desk:draw()

			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				enemy:draw()

				if musicTime >= 180300 then
					black:draw()
				end
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)
				
			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()
		weeks:drawUI()
	end,

	leave = function(self)
		sky = nil
		room = nil
		desk = nil

		weeks:leave()
	end
}
