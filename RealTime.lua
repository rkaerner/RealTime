local metadata = {
"## Interface:FS15 1.1.0.0 RC12",
"## Title: RealTime",
"## Notes: Uhrzeit in Game",
"## Author: Marhu",
"## Version: 1.2.12",
"## Date: 17.04.2015",
"## Web: http://marhu.net",
"## Notes: Improvement by Bauer Hannsen"
}

RealTime = {};
RealTime.dir = g_currentModDirectory;
Sound = true;

function RealTime:loadMap(name)
	self.h = 0.015
	self.sample = createSample("ChurchBells");
	loadSample(self.sample, Utils.getFilename(self.dir .. "sound/church.wav", self.baseDirectory), false);
end;

function RealTime:deleteMap()
end;

function RealTime:keyEvent(unicode, sym, modifier, isDown)
end;

function RealTime:mouseEvent(posX, posY, isDown, isUp, button)
end;

function RealTime:update(dt)
end;

function RealTime:draw()
	if g_currentMission.renderTime then
		setTextColor(0,0,0,1);
		setTextAlignment(RenderText.ALIGN_RIGHT);
		local WhatDay = string.format("%f", g_currentMission.environment.currentDay);
		local WeekDay = math.mod(WhatDay, 7);
		if WeekDay == 0 then
			setTextColor(1, 0, 0, 1);
			if Sound and g_currentMission.environment.currentHour == 9 and g_currentMission.environment.currentMinute == 50 then
				if not self.SoundPlay then
					self.SoundPlay = true;
					playSample(self.sample, 1, 1, 0);
				end;
			else
				self.SoundPlay = nil;
			end;
		end;
		local weatherWidth = g_currentMission.weatherTimeBackgroundWidth;
		if not g_currentMission.showWeatherForecast then
			weatherWidth = g_currentMission.timeBackgroundWidth;
		end;
		renderText(g_currentMission.weatherTimeBackgroundOverlay.x + weatherWidth - g_currentMission.timeOffsetRight, g_currentMission.weatherTimeBackgroundOverlay.y + (self.h*3), self.h, g_i18n:getText("HUD_day") .. ": " .. g_currentMission.environment.currentDay .. " (" .. g_i18n:getText(tostring(WeekDay)) .. ")");
		setTextColor(0, 0, 0, 1);
		setTextAlignment(RenderText.ALIGN_RIGHT);
		renderText(g_currentMission.weatherTimeBackgroundOverlay.x + weatherWidth - g_currentMission.timeOffsetRight, g_currentMission.weatherTimeBackgroundOverlay.y + (self.h/4), self.h, tostring(getDate("%H:%M:%S")).." ");
		setTextColor(1,1,1,1);
		setTextAlignment(RenderText.ALIGN_LEFT);
	end;
end;

addModEventListener(RealTime);