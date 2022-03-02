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

local canvas

local pixelTime = false

return {
	enter = function(self, from, songNum, songAppend)
		weeks:enter()

		song = songNum
		difficulty = songAppend

		farbg = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/festival/FarBack")))
		clubroom = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/festival/MainBG")))
		desks = graphics.newImage(love.graphics.newImage(graphics.imagePath("doki/festival/DesksFestival")))

		natsuki = love.filesystem.load("sprites/doki/bgdoki/natsuki.lua")()
		yuri = love.filesystem.load("sprites/doki/bgdoki/yuri.lua")()
		sayori = love.filesystem.load("sprites/doki/bgdoki/sayori.lua")()
		monika = love.filesystem.load("sprites/doki/bgdoki/monika.lua")()

		girlfriend = love.filesystem.load("sprites/characters/dokiGF.lua")()

		boyfriend = love.filesystem.load("sprites/characters/dokiBF.lua")()

		fakeBoyfriend = love.filesystem.load("sprites/boyfriend.lua")()

		enemy = love.filesystem.load("sprites/characters/yuri.lua")()

		clubroom.sizeX, clubroom.sizeY = 1.4, 1.4
		farbg.sizeX, farbg.sizeY = 1.4, 1.4
		desks.sizeX, desks.sizeY = 1.2, 1.2

		natsuki.x, natsuki.y = 550, 160

		yuri.x, yuri.y = 375, 130
		sayori.x, sayori.y = -450, 145
		monika.x, monika.y = -250, 145

		yuri.sizeX, yuri.sizeY = 0.6, 0.6
		sayori.sizeX, sayori.sizeY = 0.6, 0.6
		natsuki.sizeX, natsuki.sizeY = 0.6, 0.6
		monika.sizeX, monika.sizeY = 0.6, 0.6


		girlfriend.x, girlfriend.y = 30, 150
		enemy.x, enemy.y = -380, 220
		boyfriend.x, boyfriend.y = 260, 320
		desks.y = 125

		boyfriend.sizeX, boyfriend.sizeY, girlfriend.sizeX, girlfriend.sizeY, enemy.sizeX, enemy.sizeY = 0.9, 0.9, 0.9, 0.9, 0.75, 0.75

		enemyIcon:animate("yuri", false)

		self:load()
	end,

	load = function(self)
		weeks:load()
		if song == 1 then
			inst = love.audio.newSource("music/extra/crucify/Inst.ogg", "stream")
			voices = love.audio.newSource("music/extra/crucify/Voices.ogg", "stream")
		elseif song == 2 then
			inst = love.audio.newSource("music/extra/beethoven/Inst.ogg", "stream")
			voices = love.audio.newSource("music/extra/beethoven/Voices.ogg", "stream")

			enemy = love.filesystem.load("sprites/characters/natsuki.lua")()
			enemyIcon:animate("natsuki", false)

			enemy.x, enemy.y = -320, 290
			boyfriend.sizeX, boyfriend.sizeY, girlfriend.sizeX, girlfriend.sizeY, enemy.sizeX, enemy.sizeY = 0.9, 0.9, 0.9, 0.9, 0.75, 0.75
		elseif song == 3 then
			inst = love.audio.newSource("music/extra/it's complicated/Inst.ogg", "stream")
			voices = love.audio.newSource("music/extra/it's complicated/Voices.ogg", "stream")

			enemy = love.filesystem.load("sprites/characters/sayori.lua")()
			enemyIcon:animate("sayori", false)

			enemy.x, enemy.y = -380, 220
			boyfriend.sizeX, boyfriend.sizeY, girlfriend.sizeX, girlfriend.sizeY, enemy.sizeX, enemy.sizeY = 0.9, 0.9, 0.9, 0.9, 0.75, 0.75
		else
			inst = love.audio.newSource("music/extra/glitcher/Inst.ogg", "stream")
			voices = love.audio.newSource("music/extra/glitcher/Voices.ogg", "stream")

			love.graphics.setDefaultFilter("nearest")

			monikapixel = love.filesystem.load("sprites/characters/monikapixel.lua")()

			gf2 = love.filesystem.load("sprites/pixel/girlfriend.lua")()

			bf2 = love.filesystem.load("sprites/pixel/boyfriend.lua")()

			enemy = love.filesystem.load("sprites/characters/monika.lua")()
			enemyIcon:animate("monika", false)

			enemy.x, enemy.y = -380, 220
			boyfriend.sizeX, boyfriend.sizeY, girlfriend.sizeX, girlfriend.sizeY, enemy.sizeX, enemy.sizeY = 0.9, 0.9, 0.9, 0.9, 0.75, 0.75

			sky = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/sky")))
			school = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/school")))
			street = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/street")))
			treesBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("week6/trees-back")))

			

			gf2:animate("idle", true)

			monikapixel.x = -68
			monikapixel.y = 16

			bf2.y = 40
			bf2.x = 50

			trees = love.filesystem.load("sprites/week6/trees.lua")()
			petals = love.filesystem.load("sprites/week6/petals.lua")()
			freaks = love.filesystem.load("sprites/week6/freaks.lua")()

			sky.y = 1
			school.y = 1

			function getFake()
				cam.sizeX, cam.sizeY = 5.9, 5.9
				cam.x, cam.y = 70, 30
				enemy.x = -200
				enemy.y = 38

				if enemyIcon:getAnimName() == "monika losing" then
					enemyIcon:animate("monikap", false)
				end
				if enemyIcon:getAnimName() == "monika" then
					enemyIcon:animate("monikap losing", false)
				end
				boyfriendIcon:animate("boyfriend pixel", false)

				boyfriend.y = 45
				boyfriend.x = 50
				obsession = 2
				pixelTime = true

				love.graphics.setDefaultFilter("nearest")
			end

			function getReal()
				cam.sizeX, cam.sizeY = 0.9, 0.9
				camScale.x, camScale.y = 0.9, 0.9

				if enemyIcon:getAnimName() == "monikap" then
					enemyIcon:animate("monika", false)
				end
				if enemyIcon:getAnimName() == "monikap losing" then
					enemyIcon:animate("monika losing", false)
				end

				if health <= 20 then
					boyfriendIcon:animate("boyfriend losing", false)
				elseif health > 20 then
					boyfriendIcon:animate("boyfriend", false)
				end

				enemy.x, enemy.y = -380, 180
				boyfriend.x, boyfriend.y = 260, 320
				obsession = 1
				pixelTime = false

				love.graphics.setDefaultFilter("linear")
			end
		end

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()
		if song == 1 then
			weeks:generateNotes(love.filesystem.load("charts/extra/crucify" .. difficulty .. ".lua")())
		elseif song == 2 then
			weeks:generateNotes(love.filesystem.load("charts/extra/beathoven" .. difficulty .. ".lua")())
		elseif song == 3 then
			weeks:generateNotes(love.filesystem.load("charts/extra/it's complicated" .. difficulty .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/extra/glitcher" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		weeks:update(dt)
		if song ~= 1 then
			yuri:update(dt)
		end
		if song ~= 2 then
			natsuki:update(dt)
		end
		if song ~= 3 then
			sayori:update(dt)
		end
		if song ~= 4 then
			monika:update(dt)
		end
		if song == 1 then
			if health >= 80 then
				if enemyIcon:getAnimName() == "yuri" then
					enemyIcon:animate("yuri losing", false)
				end
			else
				if enemyIcon:getAnimName() == "yuri losing" then
					enemyIcon:animate("yuri", false)
				end
			end
		elseif song == 2 then
			if health >= 80 then
				if enemyIcon:getAnimName() == "natsuki" then
					enemyIcon:animate("natsuki losing", false)
				end
			else
				if enemyIcon:getAnimName() == "natsuki losing" then
					enemyIcon:animate("natsuki", false)
				end
			end
		elseif song == 3 then
			if health >= 80 then
				if enemyIcon:getAnimName() == "sayori" then
					enemyIcon:animate("sayori losing", false)
				end
			else
				if enemyIcon:getAnimName() == "sayori losing" then
					enemyIcon:animate("sayori", false)
				end
			end
		else
			if health >= 80 then
				if enemyIcon:getAnimName() == "monika" then
					enemyIcon:animate("monika losing", false)
				end
			else
				if enemyIcon:getAnimName() == "monika losing" then
					enemyIcon:animate("monika", false)
				end
			end
			if health >= 80 then
				if enemyIcon:getAnimName() == "monikap" then
					enemyIcon:animate("monikap losing", false)
				end
			else
				if enemyIcon:getAnimName() == "monikap losing" then
					enemyIcon:animate("monikap", false)
				end
			end
			monikapixel:update(dt)
			gf2:update(dt)
			bf2:update(dt)
		end
		if pixelTime then
			if enemy:getAnimName() == "left alt" then
				monikapixel:animate("left", false)
				enemy:animate("left", false)
			elseif enemy:getAnimName() == "right alt" then
				monikapixel:animate("right", false)
				enemy:animate("left", false)
			elseif enemy:getAnimName() == "up alt" then
				monikapixel:animate("up", false)
				enemy:animate("left", false)
			elseif enemy:getAnimName() == "down alt" then
				monikapixel:animate("down", false)
				enemy:animate("left", false)
			elseif enemy:getAnimName() == "idle" then
				monikapixel:animate("idle", false)
				enemy:animate("left", false)
			end

			if boyfriend:getAnimName() == "left" then
				bf2:animate("left", false)
				boyfriend:animate("kk", false)
			elseif boyfriend:getAnimName() == "right" then
				bf2:animate("right", false)
				boyfriend:animate("kk", false)
			elseif boyfriend:getAnimName() == "up" then
				bf2:animate("up", false)
				boyfriend:animate("kk", false)
			elseif boyfriend:getAnimName() == "down" then
				bf2:animate("down", false)
				boyfriend:animate("kk", false)
			elseif boyfriend:getAnimName() == "idle" then
				bf2:animate("idle", false)
				boyfriend:animate("kk", false)
			end
		end

		if song == 4 then
			if musicTime >= 49370 then
				if musicTime <= 49400 then
					getFake()
				end
			end
			if musicTime >= 71312 then
				if musicTime <= 71400 then
					getReal()
				end 
			end 
			if musicTime >= 93256 then
				if musicTime <= 93300 then
					getFake()
				end
			end
			if musicTime >= 115200 then
				if musicTime <= 115250 then
					getReal()
				end
			end

		end

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) then
			if storyMode and song < 4 then
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
		if not pixelTime then
			love.graphics.push()
				love.graphics.setDefaultFilter("linear")
				love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
				love.graphics.scale(cam.sizeX, cam.sizeY)

				love.graphics.push()
					love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

					farbg:draw()
					clubroom:draw()
					desks:draw()
					if song ~= 2 then
						natsuki:draw()
					end
					if song ~= 1 then
						yuri:draw()
					end
					if song ~= 3 then
						sayori:draw()
					end
					if song ~= 4 then
						monika:draw()
					end

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
				if not pixelTime then
					weeks:drawRating(0.9)
				end
			love.graphics.pop()
		elseif pixelTime then
			local canvasScale

			love.graphics.setFont(font)
			graphics.screenBase(256, 144)
			love.graphics.setCanvas(canvas)
				love.graphics.clear()

				love.graphics.push()
					love.graphics.setDefaultFilter("nearest")
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
						
						gf2:draw()
						
						monikapixel:draw()
						bf2:draw()
					love.graphics.pop()

				love.graphics.pop()

				--weeksPixel:drawUI()
		end
		weeks:drawUI()
	end,

	leave = function(self)
		farbg = nil
		clubroom = nil
		desks = nil
		yuri = nil
		natsuki = nil
		monika = nil
		sayori = nil

		canvas = nil

		weeks:leave()
	end
}
