#require './bin/components/collider/falling_collider.rb'
require './bin/components/collider/common_collider.rb'
require './bin/components/detector/falling_detector.rb'
class PlayerFalling<PlayerState
	def initialize(master, x,y)
		super(master,x,y)
		@player_anim=[]
		@player_anim[0]=Gosu::Image.load_tiles(PLAYER_BLUE_FALL_FILE, 140/2,94); 
		@current_frame=0;
		@w,@h=img.width,img.height;
		@xS=0; @yS=10;
		#@collider=FallingCollider.new(self,x,y)
		@collider=CommonCollider.new(self,x,y)
		#@detector=FallingDetector.new(self,x,y); # to be void?    

		@listeners<<HitAFloorListener.new(self, :onHitAFloor); 
		@listeners<<DockToAPlatform.new(self, nil); 
	end;

	def enter(x,y)
		puts "--- Falling! ---"
		@x,@y=x,y
		@xS=0;
		@yS=10;
    	@docked_to=nil;
    	centerOnTileX(@x,@y)
		#@detector.reset(x,y)
	end;

	#def draw
	#	img.draw(@x,@y,10);
	#end;	

	def update
		#move;
    	super;
		#@current_frame=(@current_frame+1) % @player_anim.first.size;		
		@face=="right"? @current_frame=0 : @current_frame=1
		@collider.update;
		#@detector.update;
		#keyControl;
		#@xS>=0? @face="right" : @face="left";
	end;	

	def img
		@player_anim[0][@current_frame]
	end;

	def keyControl
		
	end;	

	def onHitAFloor()
		puts "Hit A floor!"
		@master.toState(self,"stop");
	end;	
end;