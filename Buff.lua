Buff = {};
Buff.__index = Buff;

function Buff:new(spell_id)
	local self = {};
	setmetatable(self, Buff);

	self.id = spell_id;
	self.refresh();

	return self;
end

function Buff:remains()
	return self.duration
end

function Buff:refresh()
	-- Do some magic here, and recalculate the duration based on id
end