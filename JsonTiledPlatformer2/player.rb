require './player_state.rb'
require './mini_collider.rb'
require './detector.rb'
class Player<MovableGameObject
	def initialize(master,x,y)
		super(master,x,y)		
		@walking=PlayerWalking.new(self,x,y);
		@falling=PlayerFalling.new(self,x,y);
		@standing=PlayerStanding.new(self,x,y);
		@jumping=PlayerJumping.new(self,x,y);
		@climbing=PlayerClimbing.new(self,x,y);
		@state=@falling;
		@w,@h=@state.img.width,@state.img.height;
		@state.face="right";
	end;

	def draw
		@state.draw;
	end;

	def toState(old_state,new_state)
		#old_state - PlayerState
		#new_state - String
		case new_state			
			when "walk" then ns=@walking
			when "fall" then ns=@falling
			when "stop" then ns=@standing
			when "jump" then ns=@jumping
			when "climb" then ns=@climbing	
		end;
		ns.xS=old_state.xS;
		ns.yS=old_state.yS;
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

class PlayerStanding<PlayerState
	def initialize(master, x,y)
		super(master,x,y)
		@img=Gosu::Image.new('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_front.png')
		@xS=0; @yS=0;
		@w,@h=@img.width,@img.height;
		@detector=StandingDetector.new(self,x,y);
	end;

	def enter(x,y)
		puts "Standing!"
		@x,@y=x,y
		@xS=0; @yS=0;
		@detector.reset(x,y)
	end;

	def draw
		@img.draw(@x,@y,10);
	end;

	def update
		@detector.update;
		keyControl;
	end; 	

	def img
		@img;
	end;

	def keyControl
		if $g.button_down?(Gosu::KbLeft)
    		#@ph.strafe_tilt_left;
    		@xS=-5
    		@master.toState(self,"walk")
    	elsif $g.button_down?(Gosu::KbRight)
    		#@ph.strafe_tilt_right;
    		@xS=5
    		@master.toState(self,"walk")
    	elsif $g.button_down?(Gosu::KbSpace) # || $g.button_down?(Gosu::KbUp)
	   		#@yS=-20
    		@master.toState(self,"jump")
    	elsif $g.button_down?(Gosu::KbUp) && @detector.controlPoints[4]["type"].include?(LADDER)
    		@master.toState(self,"climb")
    	elsif $g.button_down?(Gosu::KbDown) && @detector.controlPoints[7]["type"].include?(LADDER)
    		puts @detector.controlPoints[7]
    		@master.toState(self,"climb")	

    	elsif $g.button_down?(Gosu::KbUp)
    		@master.toState(self,"jump")
    	else
    		#@ph.look_up;	
    		#@xS=0;
    		#@master.toState(@master,"stop");
    	end;
    end;
end;		

class PlayerWalking<PlayerState
	def initialize(master, x,y)
		super(master,x,y)
		@player_anim=[]
		@player_anim[0] =Gosu::Image.load_tiles('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_walk\/Player2.png', 770/11,94); 
		@player_anim[1] =Gosu::Image.load_tiles('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_walk\/Player2_left.png', 770/11,94); 
		@current_frame=0;
		#@w,@h=@player_anim[@current_frame].width,@player_anim[@current_frame].height;
		@w,@h=img.width,img.height;
		@xS=0; @yS=0;
		@collider=WalkingCollider.new(self,x,y)
		@detector=WalkingDetector.new(self,x,y);
	end;

	def enter(x,y)
		puts "Walking!"
		puts @collider.collide?(self)
		@x,@y=x,y
		@yS=0;
		@detector.reset(x,y)
	end;

	def draw
		#@img.draw(@x,@y,10);
		#@player_anim[@current_frame].draw(@x,@y,10);
		img.draw(@x,@y,10);
	end;	

	def update
		move;
		@current_frame=(@current_frame+1) % @player_anim[0].size;		
		@collider.update;
		@detector.update;
		keyControl;
		@xS>=0? @face="right" : @face="left";
	end;	

	def img
		#@img
		#case when @xS>=0 
		case when @face=="right"
			@player_anim[0][@current_frame]
		else
			@player_anim[1][@current_frame]	
		end;		
	end;

	def reverse
		@xS=-@xS
	end;

	def keyControl
		if $g.button_down?(Gosu::KbLeft)
    		#@ph.strafe_tilt_left;
    		@xS=-5
    	elsif $g.button_down?(Gosu::KbRight)
    		#@ph.strafe_tilt_right;
    		@xS=5    	
    	else
    		#@ph.look_up;	
    		@xS=0;
    		@master.toState(self,"stop");
    	end;
    	 if $g.button_down?(Gosu::KbSpace) || $g.button_down?(Gosu::KbUp)
	   	  	#@yS=-20
    	  	@master.toState(self,"jump")	
    	 end;	
    end;		
end;	

class PlayerFalling<PlayerState
	def initialize(master,x,y)
		super(master,x,y)
		@img=[]
		@img[0]=Gosu::Image.new('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_hurt.png')
		@img[1]=Gosu::Image.new('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_hurt_left.png')
		@xS=0; @yS=10;
		@w,@h=img.width,img.height;
		@collider=FallingCollider.new(self,x,y)
	end;

	def enter(x,y)
		puts "Falling!"
		@xS=0; @yS=10;
		@x,@y=x,y
	end;

	def draw
		img.draw(@x,@y,10);
	end;	
	
	def update
		move;
		@collider.update;
	end;	

	def img
		#@img
		#case when @xS>=0
		case when @face=="right" 
			@img[0]
		else
			@img[1]	
		end;		
	end;
end;	

class PlayerJumping<PlayerState
	def initialize(master,x,y)
		super(master,x,y)
		@img=  []
		@img[0]=Gosu::Image.new('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_jump.png')
		@img[1]=Gosu::Image.new('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_jump_left.png')
		@xS=0; @yS=-JUMPING_SPEED;
		@w,@h=img.width,img.height;
		@collider=JumpingCollider.new(self,x,y)
		@detector=JumpingDetector.new(self,x,y);
	end;

	def enter(x,y)
		puts "Jumping!"
		@x,@y=x,y
		@yS=-JUMPING_SPEED;
	end;

	def draw
		img.draw(@x,@y,10);
	end;	
	
	def move
		super
		@yS+=JUMPING_DECELERATION
	end;	

	def update
		move;
		@collider.update;
	end;	

	def img
		#@img
		#case when @xS>=0
		case when @face=="right" 
			@img[0]
		else
			@img[1]	
		end;		
	end;
end;


class PlayerClimbing<PlayerState
	def initialize(master,x,y)
		super(master,x,y)
		@img=  []
		@img[0]=Gosu::Image.new('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/alienBlue_Climb1_.png')
		@img[1]=Gosu::Image.new('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/alienBlue_Climb2_.png')
		@xS=0; @yS=-CLIMBING_SPEED;
		@w,@h=img.width,img.height;
		@collider=ClimbingCollider.new(self,x,y)
		@detector=ClimbingDetector.new(self,x,y);
		@mileage=0;
	end;

	def enter(x,y)
		puts "Climbing!"
		@x,@y=x,y
		@yS=-CLIMBING_SPEED;
		centerOnTileX(@x,@y)
		@detector.reset(@x,@y);
	end;

	def centerOnTileX(x,y)	
		#puts "x=#{@x}"
		#puts "@x+@w/2=#{@x+@w/2}"
		#puts "(@x+@w/2)/TILE_SIZE=#{(@x+@w)/TILE_SIZE}"  
		@x=(@x+@w/2)/TILE_SIZE * TILE_SIZE
	end;
		
	def centerOnTileY(x,y)	
		
	end;

	def centerOnTileXY(x,y)	
		centerOnTileX(x,y)
		centerOnTileY(x,y)
	end

	def draw
		img.draw(@x,@y,10);
	end;	
	
	def update
		@mileage+=1 if @yS!=0;
		@mileage=@mileage%10
		keyControl;
		move;
		@collider.update;
		@detector.update;
		@face=="left" ? @face="right": @face="left" if @mileage==0
	end;	

	def img
		#@img
		#case when @xS>=0
		case when @face=="right" 
			@img[0]
		else
			@img[1]	
		end;		
	end;

	def keyControl
		if $g.button_down?(Gosu::KbUp)
    		#@ph.strafe_tilt_left;
    		@yS=-CLIMBING_SPEED
    	elsif $g.button_down?(Gosu::KbDown)
    		#@ph.strafe_tilt_left;
    		@yS=CLIMBING_SPEED
    	else
    		@yS=0
    	end;	
	end;	
end;
