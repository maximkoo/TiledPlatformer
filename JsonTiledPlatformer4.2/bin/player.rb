require './bin/player_state.rb'
require './bin/components/core/ColliderCore.rb'
require './bin/components/detector/detector.rb'
require './bin/player_walking.rb'
require './bin/player_falling.rb'
require './bin/player_jumping.rb'
require './bin/player_climbing.rb'
require './bin/player_standing.rb'

class Player<MovableGameObject
	def initialize(master,x,y)
		super(master,x,y)	
		@type=@name=PLAYER
		set_viewport;	
		# @walking=PlayerWalking.new(self,x,y);
		# @falling=PlayerFalling.new(self,x,y);
		# @standing=PlayerStanding.new(self,x,y);
		# @jumping=PlayerJumping.new(self,x,y);
		# @climbing=PlayerClimbing.new(self,x,y);

		@states=Hash.new;
		@states["walk"]=PlayerWalking.new(self,x,y);
		@states["fall"]=PlayerFalling.new(self,x,y);
		@states["stop"]=PlayerStanding.new(self,x,y);
		@states["jump"]=PlayerJumping.new(self,x,y);
		@states["climb"]=PlayerClimbing.new(self,x,y);
		#@states["ride"]=PlayerRiding.new(self,x,y);


		#@state=@falling;
		@state=@states["fall"]
		@w,@h=@state.img.width,@state.img.height;
		@state.face="right";
	end;

	def draw
		@state.draw;
	end;

	def toState(old_state,new_state)
		#>>> old_state - PlayerState
		#>>> new_state - String
		# case new_state			
		# 	when "walk" then ns=@walking
		# 	when "fall" then ns=@falling
		# 	when "stop" then ns=@standing
		# 	when "jump" then ns=@jumping
		# 	when "climb" then ns=@climbing	
		# end;
		ns=@states[new_state];

		ns.xS=old_state.xS;
		ns.yS=old_state.yS;
		ns.xx=old_state.xx;
		ns.yy=old_state.yy;
		ns.enter(old_state.x,old_state.y);	
		ns.face=old_state.face;	
		
		#puts old_state.xS,old_state.yS;
		#puts 
		@state=ns;
	end;

	def update		
		@state.update;
	end;	
end;	