require './bin/components/collider/climbing_collider.rb'
require './bin/components/detector/climbing_detector.rb'
class PlayerClimbing<PlayerState
	def initialize(master,x,y)
		super(master,x,y)
		@player_anim=[]
		@player_anim[0] =Gosu::Image.load_tiles(PLAYER_BLUE_CLIMB_FILE, 140/2,94);
		@xS=0; @yS=-CLIMBING_SPEED;
		@w,@h=img.width,img.height;
		@collider=ClimbingCollider.new(self,x,y)
		@detector=ClimbingDetector.new(self,x,y);
		@mileage=0;
	end;

	def enter(x,y)
		puts "--- Climbing! ---"
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

	#def draw
	#	img.draw(@x,@y,10);
	#end;	
	
	def update
		@mileage+=1 if @yS!=0;
		@mileage=@mileage%10
		keyControl;
		#move;
    super;
		@collider.update;
		@detector.update;
		if @mileage==0
			@face=="left" ? @face="right": @face="left" 
			@mileage+=1;
		end;	
	end;	

	def img
		@face=="right" ? @player_anim[0].first : @player_anim[0].last
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
