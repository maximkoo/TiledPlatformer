#require './bin/components/collider/jumping_collider.rb'
require './bin/components/collider/common_collider.rb'
#require './bin/components/detector/jumping_detector.rb'
class PlayerJumping<PlayerState
  attr_reader :land
	def initialize(master, x,y)
		super(master,x,y)
		@player_anim=[]
		@player_anim[0]=Gosu::Image.load_tiles(PLAYER_BLUE_JUMP_FILE, 140/2,94); 
		@current_frame=0;
		@w,@h=img.width,img.height;
		@xS=0; @yS=-JUMPING_SPEED;
		#@collider=JumpingCollider.new(self,x,y)
		@collider=CommonCollider.new(self,x,y)
		#@detector=JumpingDetector.new(self,x,y);   
   		@listeners<<HitAWallListener.new(self, :onHitAWall); 
   		@listeners<<DockToAPlatform.new(self, nil); 
   		@listeners<<HitAFloorListener.new(self, :onHitAFloor); 
   		@listeners<<HitACeilingListener.new(self, :onHitACeiling); 
   		@listeners<<HitABonusListener.new(self, nil); 
	end;

	def enter(x,y)
		puts "--- Jumping!---"
		@x,@y=x,y
		@yS=-JUMPING_SPEED;
    @docked_to=nil;
    #@pop.play(2,1,false)
	end;

	#def draw
		#img.draw(@x,@y,10);
	#end;	

	def move
		#super
		@yS+=JUMPING_DECELERATION
	end;		

	def update
		super;
    move; #local method!    
		#@current_frame=(@current_frame+1) % @player_anim.first.size;		
		@face=="right"? @current_frame=0 : @current_frame=1
		@collider.update;
		#@detector.update;
		keyControl;
		@xS>0? @face="right" : @face="left";
	end;	

	def img
		@player_anim[0][@current_frame]
	end;

	def keyControl
  	end;		

  	def onHitAWall
  		puts "Hit A Wall!"
		@master.toState(self,"fall");
  	end;

  	def onHitAFloor()
		puts "Hit A floor!"
		@master.toState(self,"stop");
	end;	

	def onHitACeiling()
		puts "Hit A Ceiling!"
	end;	
end;