#require './bin/components/collider/walking_collider.rb'
#require './bin/components/detector/walking_detector.rb'
require './bin/components/detector/common_detector.rb'
require './bin/components/collider/common_collider.rb'
class PlayerWalking<PlayerState
	def initialize(master, x,y)
		super(master,x,y)
		@player_anim=[]
		@player_anim[0] =Gosu::Image.load_tiles(PLAYER_BLUE_WALK_RIGHT_FILE, 770/11,94); 
		@player_anim[1] =Gosu::Image.load_tiles(PLAYER_BLUE_WALK_LEFT_FILE, 770/11,94); 
		@current_frame=0;
		@w,@h=img.width,img.height;
		@xS=0; @yS=0;
		#@collider=WalkingCollider.new(self,x,y)
		@collider=CommonCollider.new(self,x,y)
		#@detector=WalkingDetector.new(self,x,y);
		@detector=CommonDetector.new(self,x,y);
    #@pop=Gosu::Sample.new('./assets/sound/pop.ogg')   

    	@listeners<<HitAWallListener.new(self, :onHitAWall); 
    	@listeners<<HitABonusListener.new(self, nil); 
    	@detectorListeners<<IsNoFloorListener.new(self, :onNoFloor);

	end;

	def enter(x,y)
		puts "--- Walking! ---"
    	puts "PlayerWalking reports: docked_to=#{@docked_to.name}" if @docked_to
		@x,@y=x,y
		@yS=0;
		@detector.reset(x,y)
	end;

	def update
		#move;
    super
		@current_frame=(@current_frame+1) % @player_anim[0].size;
    #@pop.play(2,1,false) if @current_frame%(@player_anim[0].size.fdiv(2))==0;
		@collider.update;
		@detector.update;
		keyControl;
		@xS>=0? @face="right" : @face="left";
	end;	

	def img
		case when @face=="right"
			@player_anim[0][@current_frame]
		else
			@player_anim[1][@current_frame]	
		end;		
	end;

	def keyControl
		if $g.button_down?(Gosu::KbLeft)
    		@xS=-WALKING_SPEED        
    	elsif $g.button_down?(Gosu::KbRight)
    		@xS=WALKING_SPEED 
    	else
    		@xS=0;
    		@master.toState(self,"stop");
    	end;
    	 if $g.button_down?(Gosu::KbSpace) || $g.button_down?(Gosu::KbUp)
    	  	@master.toState(self,"jump")	
    	 end;	
    end;

    def onHitAWall()
    	#puts "Hit A Wall";
    end;

    def onNoFloor
		puts "Walking detector doesn't detect ground!"
  		@master.toState(self,"fall");
    end;	
end;