------------------------------------------------------------------------------
--	oUF_barebones
--	Bare minimum for getting an oUF layout up and running
------------------------------------------------------------------------------
--	credits:
--	Haste (oUF)
--		http://www.wowinterface.com/downloads/info9994-oUF.html
--	zork (oUF Tutorial)
--		http://www.wowinterface.com/forums/showthread.php?t=33566
------------------------------------------------------------------------------

--	configuration
local BAR_TEXTURE = "Interface\\AddOns\\oUF_barebones\\bartexture.tga"
local BAR_WIDTH = 192
local HP_HEIGHT = 16
local PP_HEIGHT = 4
local BORDER = 1

local TEXT_FACE = "NumberFont_Shadow_Small"

------------------------------------------------------------------------------

-- generate the frames
local function CreateUnitFrame(self, unit)

	-- size the overall unit frame
	self:SetSize(BAR_WIDTH + 2 * BORDER, HP_HEIGHT + PP_HEIGHT + 3 * BORDER)

	-- create background
	local unitBackground = self:CreateTexture(nil, "ARTWORK")
	unitBackground:SetAllPoints(self)
	unitBackground:SetTexture(0, 0, 0, 1)
	
	------------------------
	-- health bar
	------------------------
	local hpBar = CreateFrame("StatusBar", nil, self)
	hpBar:SetStatusBarTexture(BAR_TEXTURE)
	hpBar:SetSize(BAR_WIDTH, HP_HEIGHT)
	hpBar:SetPoint("TOP", self, "TOP", 0, -BORDER)
	
	-- > see "oUF/elements/health.lua" for health bar coloring options
	hpBar.frequentUpdates = true
	hpBar.colorDisconnected = true
	hpBar.colorTapping = true
	hpBar.colorHappiness = true
	hpBar.colorReaction = true
	hpBar.colorSmooth = true
	
	self.Health = hpBar
	
	------------------------
	-- power bar
	------------------------
	local ppBar = CreateFrame("StatusBar", nil, self)
	ppBar:SetStatusBarTexture(BAR_TEXTURE)
	ppBar:SetSize(BAR_WIDTH, PP_HEIGHT)
	ppBar:SetPoint("TOP", hpBar, "BOTTOM", 0, -BORDER)
	
	-- > see "oUF/elements/power.lua" for power bar coloring options
	ppBar.frequentUpdates = true
	ppBar.colorPower = true
	
	self.Power = ppBar
	
	------------------------
	-- unit name text
	------------------------
	local Name = hpBar:CreateFontString(nil, "Overlay")
	Name:SetFontObject(TEXT_FACE)
	Name:SetJustifyH("LEFT")
	Name:SetPoint("LEFT", hpBar, "LEFT", 4, 0)
	
	-- > see "oUF/elements/tags.lua" for provided tags
	self:Tag(Name, "[smartlevel] [name]")
	
	------------------------
	-- unit health text
	------------------------
	local hpText = hpBar:CreateFontString(nil, "Overlay")
	hpText:SetFontObject(TEXT_FACE)
	hpText:SetJustifyH("RIGHT")
	hpText:SetPoint("RIGHT", hpBar, "RIGHT", -4, 0)
	
	-- > "see oUF/elements/tags.lua" for provided tags
	self:Tag(hpText, "[status] [curhp]/[maxhp]")
	
	-- allow the name to be cut off with "..." if it's too long
	Name:SetPoint("RIGHT", hpText, "LEFT", 0, 0)
	
end

------------------------------------------------------------------------------

oUF:RegisterStyle("oUF_barebones", CreateUnitFrame)

oUF:SetActiveStyle("oUF_barebones")

-- spawn and then position the player frame
local player = oUF:Spawn("player", "oUF_player")
player:SetPoint("CENTER", UIParent, "CENTER", -192, -192)

-- spawn and then position the target frame
local target = oUF:Spawn("target", "oUF_target")
target:SetPoint("CENTER", UIParent, "CENTER", 192, -192)

