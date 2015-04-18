local metadata = {
"## Interface:FS15 1.1.0.0 RC12",
"## Title: RealTime",
"## Notes: Uhrzeit in Game",
"## Author: Marhu",
"## Version: 1.2.13",
"## Date: 18.04.2015",
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

function RealTime:deleteMap(name)
	if self.Soundplay then
		stopSample(self.sample);
		self.Soundplay = nil;
	end;
end;

function RealTime:keyEvent(unicode, sym, modifier, isDown)
end;

function RealTime:mouseEvent(posX, posY, isDown, isUp, button)
end;

function RealTime:update(dt)
	getcurrentday();
	if WeekDay == 0 then
		if Sound and g_currentMission.environment.currentHour == 9 and g_currentMission.environment.currentMinute == 50 then
			if not self.SoundPlay then
				self.SoundPlay = true;
				playSample(self.sample, 0, 1, self.sampleOffset);
			end;
		end;
		if Sound and g_currentMission.environment.currentHour == 10 and g_currentMission.environment.currentMinute == 0 then
			if self.SoundPlay then
				self.Soundplay = nil;
				stopSample(self.sample);
			end;
		end;
	end;
end;

function RealTime:updateTick(dt)
end;

function RealTime:draw()
	if g_currentMission.renderTime then
		setTextColor(0,0,0,1);
		setTextAlignment(RenderText.ALIGN_RIGHT);
		getcurrentday();
		if WeekDay == 0 then
			setTextColor(1, 0, 0, 1);
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

function getcurrentday()
		local WhatDay = string.format("%f", g_currentMission.environment.currentDay);
		WeekDay = math.mod(WhatDay, 7);
		return WeekDay;
end;

addModEventListener(RealTime);