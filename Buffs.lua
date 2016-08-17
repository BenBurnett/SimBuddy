Buffs = {};
Buffs.__index = Buffs;

function Buffs:new()
	local self = {};
	setmetatable(self, Buffs);
	return self;
end

function Buffs:up(v)
	if ( self[v] )
		return self[v].remains() > 0
	end
end

function Buffs:down(v)
	if ( self[v] )
		return self[v].remains() == 0
	end
end

function Buffs:remains(v)
	if ( self[v] )
		return self[v].remains()
	end
end

function Buffs:refresh()
	for _,v in self(t) do
		v.refresh()
	end
end