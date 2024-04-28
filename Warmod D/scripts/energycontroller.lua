-- Counterfeit EnergyController module
-- Version 1.0
-- Author : AnXZ
-- Rus Description:
-- Контролирует электроэнергию на карте Counterfeit при включенном триггере "ComplexEnergy"

EnergyController = EnergyController or class()
math.randomseed( os.time() );

-- Отключение энергии, включение взаимодействия
EnergyController.OFFTriggers =
{
	["A"] =
	{
		[1] = 100447,
		[2] = 100448,
		[3] = 100449
	},
	["B"] =
	{
		[1] = 101210,
		[2] = 101211,
		[3] = 101212
	},
	["T"] =
	{
		[1] = 100915,
		[2] = 100916,
		[3] = 100917
	}
};

EnergyController.InteractTriggers = 
{
	["A"] =
	{
		[1] = 100441,
		[2] = 100467,
		[3] = 100468
	},
	["B"] =
	{
		[1] = 101216,
		[2] = 101218,
		[3] = 101219
	},
	["T"] =
	{
		[1] = 100919,
		[2] = 100229,
		[3] = 100575
	}
};

function EnergyController:init()
	self.ActiveBoxes = 7;
	self.ActiveABoxes = { 1, 2, 3 };
	self.ActiveBBoxes = { 1, 2, 3 };
	self.BlockedABoxes = {};	
	self.BlockedBBoxes = {};
	self.TransformerIsActive = false;
	self.Started = false;
	self.PowerIsActive = true;
	
	
	for k,v in pairs( EnergyController.OFFTriggers ) do
		for i = 1, 3 do
			managers.mission:scripts()["default"]:elements()[ v[i] ]._values.enabled = true;
		end
	end
	
	for k, v in pairs( EnergyController.InteractTriggers ) do
		for i = 1, 3 do
			managers.mission:scripts()["default"]:elements()[ v[i] ]._values.enabled = true;
		end
	end
end

function EnergyController:DisableEnergy()
	if not self.Started then
		self.Started = true;
		for i = 1, 3 do
			self:OFFABox( );
			self:OFFBBox( );
		end
		self:OFFTBox();		
	end
end

function EnergyController:OFFABox( )
	if #self.ActiveABoxes > 0 then
		local Rand = math.random( 1, #self.ActiveABoxes );
		local Elem = self.ActiveABoxes[ Rand ];
		table.remove( self.ActiveABoxes, Rand );
		table.insert( self.BlockedABoxes, Elem );
		
		self.ActiveBoxes = self.ActiveBoxes - 1;
		if self.PowerIsActive then
			self.PowerIsActive = false;
			self:PowerOFF();
		end
		managers.mission:scripts()["default"]:elements()[ EnergyController.OFFTriggers["A"][Elem] ]:on_executed();	
	end 
end

function EnergyController:OFFBBox( )
	if #self.ActiveBBoxes > 0 then
		local Rand = math.random( 1, #self.ActiveBBoxes );
		local Elem = self.ActiveBBoxes[ Rand ];
		table.remove( self.ActiveBBoxes, Rand );
		table.insert( self.BlockedBBoxes, Elem );
		
		self.ActiveBoxes = self.ActiveBoxes - 1;
		if self.PowerIsActive then
			self.PowerIsActive = false;
			self:PowerOFF();
		end
		managers.mission:scripts()["default"]:elements()[ EnergyController.OFFTriggers["B"][Elem] ]:on_executed();		
	end 
end

function EnergyController:OFFTBox(  )
	if not self.TransformerIsActive then
		self.TransformerIsActive = math.random( 1, 3 );
		self.ActiveBoxes = self.ActiveBoxes - 1;
		if self.PowerIsActive then
			self.PowerIsActive = false;
			self:PowerOFF();
		end
			
		managers.mission:scripts()["default"]:elements()[ EnergyController.OFFTriggers["T"][self.TransformerIsActive] ]:on_executed();
	end
end

function EnergyController:ONABox( Number )
	if #self.BlockedABoxes > 0 then
		table.delete( self.BlockedABoxes, Number );
		table.insert( self.ActiveABoxes, Number );
		self.ActiveBoxes = self.ActiveBoxes + 1;
		if not self.PowerIsActive and self.ActiveBoxes == 7 then
			self.PowerIsActive = true;
			self:PowerON();
		end
		managers.mission:scripts()["default"]:elements()[ EnergyController.InteractTriggers["A"][Number] ]:on_executed(); 
	end
end

function EnergyController:ONBBox( Number )
	if #self.BlockedBBoxes > 0 then
		table.delete( self.BlockedBBoxes, Number );
		table.insert( self.ActiveBBoxes, Number );
		self.ActiveBoxes = self.ActiveBoxes + 1;
		if not self.PowerIsActive and self.ActiveBoxes == 7 then
			self.PowerIsActive = true;
			self:PowerON();
		end
		managers.mission:scripts()["default"]:elements()[ EnergyController.InteractTriggers["B"][Number] ]:on_executed(); 
	end
end

function EnergyController:ONTBox(  )
	if self.TransformerIsActive then
		local Transformer = self.TransformerIsActive;
		self.TransformerIsActive = false;
		self.ActiveBoxes = self.ActiveBoxes + 1;
		if not self.PowerIsActive and self.ActiveBoxes == 7 then
			self.PowerIsActive = true;
			self:PowerON();
		end		
		managers.mission:scripts()["default"]:elements()[ EnergyController.InteractTriggers["T"][Transformer] ]:on_executed();
	end
end



function EnergyController:PowerON()
	managers.mission:scripts()["default"]:elements()[101222]:on_executed();
	
	
	managers.mission:scripts()["default"]:elements()[102150]:on_executed();
	managers.mission:scripts()["default"]:elements()[102152]:on_executed();
end

function EnergyController:PowerOFF()
	managers.mission:scripts()["default"]:elements()[101108]:on_executed();
	
	managers.mission:scripts()["default"]:elements()[101523]:on_executed();
end
	