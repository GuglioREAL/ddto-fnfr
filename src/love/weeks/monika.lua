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

		natsuki = love.filesystem.load("sprites/doki/bgdoki/natsuki.lua")()
		yuri = love.filesystem.load("sprites/doki/bgdoki/yuri.lua")()
		sayori = love.filesystem.load("sprites/doki/bgdoki/sayori.lua")()

		girlfriend = love.filesystem.load("sprites/characters/dokiGF.lua")()

		boyfriend = love.filesystem.load("sprites/characters/dokiBF.lua")()

		fakeBoyfriend = love.filesystem.load("sprites/boyfriend.lua")()

		enemy = love.filesystem.load("sprites/characters/monika.lua")()

		clubroom.sizeX, clubroom.sizeY = 1.4, 1.4
		farbg.sizeX, farbg.sizeY = 1.4, 1.4
		desks.sizeX, desks.sizeY = 1.2, 1.2

		natsuki.x, natsuki.y = 375, 160

		yuri.x, yuri.y = -375, 130
		sayori.x, sayori.y = -250, 145

		yuri.sizeX, yuri.sizeY = 0.6, 0.6
		sayori.sizeX, sayori.sizeY = 0.6, 0.6
		natsuki.sizeX, natsuki.sizeY = 0.6, 0.6


		girlfriend.x, girlfriend.y = 30, 150
		enemy.x, enemy.y = -380, 180
		boyfriend.x, boyfriend.y = 260, 320
		desks.y = 125

		boyfriend.sizeX, boyfriend.sizeY, girlfriend.sizeX, girlfriend.sizeY, enemy.sizeX, enemy.sizeY = 0.9, 0.9, 0.9, 0.9, 0.75, 0.75

		enemyIcon:animate("monika", false)

		self:load()
	end,

	load = function(self)
		weeks:load()

		inst = love.audio.newSource("music/monika/reconciliation/Inst.ogg", "stream")
		voices = love.audio.newSource("music/monika/reconciliation/Voices.ogg", "stream")

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		weeks:generateNotes(love.filesystem.load("charts/monika/reconciliation" .. difficulty .. ".lua")())
	end,

	update = function(self, dt)
		weeks:update(dt)
		yuri:update(dt)
		natsuki:update(dt)
		sayori:update(dt)

		if health >= 80 then
			if enemyIcon:getAnimName() == "monika" then
				enemyIcon:animate("monika losing", false)
			end
		else
			if enemyIcon:getAnimName() == "monika losing" then
				enemyIcon:animate("monika", false)
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

				farbg:draw()
				clubroom:draw()
				desks:draw()
				natsuki:draw()
				yuri:draw()
				sayori:draw()

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
		weeks:drawUI()
	end,

	leave = function(self)
		farbg = nil
		clubroom = nil
		desks = nil

		weeks:leave()
	end
}
