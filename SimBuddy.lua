local debugOutput = true
local SimBuddy_VERSION = "1.0"
local SimBuddyFrame = nil

-- Test function to return a spell id
SimBuddy_getSpellId = function()
	return 0 --49998
end

-- Function to calculate how long you have been in combat
local combatTime = 0
function SimBuddy_getCombatTime()
	if combatTime > 0 then
		return GetTime() - combatTime
	end
	return 0
end

-- Function to handle any events that are registered with the main frame
local function SimBuddy_eventHandler(self, event, ...)
	if event == "PLAYER_REGEN_ENABLED" then
		-- Clear out the combat time
		combatTime = 0
		SimBuddyFrame:Hide()
	elseif event == "PLAYER_REGEN_DISABLED" then
		-- Save off the time that we entered combat
		combatTime = GetTime()
		SimBuddyFrame:Show()
	end
end

-- Function to handle OnUpdate calls
local updateInterval = 0.1
local timeSinceLastUpdate = 0
local function SimBuddy_updateHandler(self, elapsed)
	timeSinceLastUpdate = timeSinceLastUpdate + elapsed
	if ( timeSinceLastUpdate >= updateInterval ) then
		SimBuddyFrame.Icon:SetTexture(GetSpellTexture(SimBuddy_getSpellId()))
		timeSinceLastUpdate = 0
	end
end

-- Function to set up all of the initial data
local function SimBuddy_initialize()
	if debugOutput then print("SimBuddy:Starting version "..SimBuddy_VERSION) end
		
	-- Create the ability icon frame
	SimBuddyFrame = CreateFrame("Button", "SimBuddy", UIParent)
	SimBuddyFrame:SetFrameStrata("BACKGROUND")
	SimBuddyFrame:SetWidth(64)
	SimBuddyFrame:SetHeight(64)
	SimBuddyFrame:SetAlpha(1)
	SimBuddyFrame:SetPoint("CENTER",0,-100)

	-- Create the icon
	SimBuddyFrame.Icon = SimBuddyFrame:CreateTexture(nil, "BACKGROUND")
	SimBuddyFrame.Icon:SetAllPoints()
	SimBuddyFrame.Icon:SetVertexColor(1, 1, 1, 1)

	-- Register events with the frame
	SimBuddyFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
	SimBuddyFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
	
	-- Set scripts on the frame
	SimBuddyFrame:SetScript("OnEvent", SimBuddy_eventHandler);
	SimBuddyFrame:SetScript("OnUpdate", SimBuddy_updateHandler);

	-- Hide the frame initially
	SimBuddyFrame:Hide()
end

SimBuddy_initialize()