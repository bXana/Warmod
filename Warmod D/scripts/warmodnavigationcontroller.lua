-- NavigationManager module
-- Version 2.0
-- Author : AnXZ
-- Rus Description:
-- Этот модуль сохраняет местоположение живых игроков( не ботов )
-- Используется для вызова подходящих спавнов.
-- 

WarmodNavigationManager = WarmodNavigationManager or class()

math.randomseed( os.time() );

-- 2.0 version
	function WarmodNavigationManager:init()
		self.LastNavigation = { nil, nil, nil, nil };
		self.PeerNavigationBlock = {};
		self.PeerNavigationBlockAmount = 0;
		self.Iterator = 1;
	end
	
	function WarmodNavigationManager:GetPeerNavigation( PeerId )
		return self.LastNavigation[ PeerId ];
	end
	
	function WarmodNavigationManager:GetPeerId()
		if self.PeerNavigationBlockAmount == 0 then
			return nil;
		end
		
		local F = math.mod( self.Iterator, self.PeerNavigationBlockAmount );
		local Ret = F;
			
		if F == 0 then
			Ret = 1;
			self.Iterator = 0;
		else
			Ret = Ret + 1;
		end
		
		self.Iterator = self.Iterator + 1;
		return Ret;
	end
	
	function WarmodNavigationManager:GetNavigation()
		if self.PeerNavigationBlockAmount == 0 then
			return nil;
		end
		
		return self.LastNavigation[ self.PeerNavigationBlock[ math.random( 1, self.PeerNavigationBlockAmount ) ] ];
	end
	
	function WarmodNavigationManager:ResetNavigationData( PeerId )
		if self.LastNavigation[ PeerId ] then
			table.delete( self.PeerNavigationBlock, PeerId );
			self.PeerNavigationBlockAmount = self.PeerNavigationBlockAmount - 1;
			self.LastNavigation[ PeerId ] = nil;
		end
	end
	
	function WarmodNavigationManager:AddNewNavigation( PeerId, NewNavigation )
		self.LastNavigation[ PeerId ] = NewNavigation;
		table.insert( self.PeerNavigationBlock, PeerId );
		self.PeerNavigationBlockAmount = self.PeerNavigationBlockAmount + 1;
	end
	
	function WarmodNavigationManager:RebootNavigation( PeerId, NewNavigation )
		self.LastNavigation[ PeerId ] = NewNavigation;
	end	

	function WarmodNavigationManager:HaveNavigation( PeerId )
		return ( self.LastNavigation[ PeerId ] ~= nil );
	end	