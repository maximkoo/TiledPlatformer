require './bin/components/detector/standing_detector.rb'
class PlayerStanding<PlayerState
	def initialize(master, x,y)
		super(master,x,y)
		@player_anim=[]
		@player_anim[0]=Gosu::Image.load_tiles(PLAYER_BLUE_STAND_FILE, 210/3,94); 
		@current_frame=0;
		@w,@h=img.width,img.height;
		@xS=0; @yS=0;
		#@collider=...Collider.new(self,x,y)
		@detector=StandingDetector.new(self,x,y);
		#@collider=StandingCollider.new(self,x,y)
    	
    	@detectorListeners<<IsFloorListener.new(self, :onNoFloor);
	end;

	def enter(x,y)
		puts "--- Standing! ---"
    puts "PlayerStanding reports: docked_to=#{@docked_to.name}" if @docked_to
		@x,@y=x,y
		@xS=0;
		@yS=0;
		@detector.reset(x,y)    
	end;

	#def draw
	#	img.draw(@x,@y,10);
	#end;	

	def update
		#move;
    super;
		@current_frame=(@current_frame+1) % @player_anim.first.size;		
		#@collider.update;
		@detector.update;
		keyControl;
		#@xS>=0? @face="right" : @face="left";
	end;	

	def img
		@player_anim.first.first
	end;

	def keyControl
		if $g.button_down?(Gosu::KbLeft) 
    		@xS=@xS
    		@ys=@yS
    		@master.toState(self,"walk");
    	elsif $g.button_down?(Gosu::KbRight)
    		@xS=@xS
    		@yS=@yS    	
    		@master.toState(self,"walk");
    	elsif $g.button_down?(Gosu::KbUp) && @detector.controlPoints[5]["type"].include?(LADDER)
    		@master.toState(self,"climb")
    	elsif $g.button_down?(Gosu::KbDown) && @detector.controlPoints[8]["type"].include?(LADDER)
    		#puts @detector.controlPoints[7]
    		@master.toState(self,"climb")	
    	#end;
    	#else
  #   		@xS=@xS
  #   		@yS=@yS 
  #   		@master.toState(self,"...");
  #   	end;
      	elsif $g.button_down?(Gosu::KbSpace) || $g.button_down?(Gosu::KbUp)
		# 	@xS=@xS
  #   		@yS=@yS 
     	  	@master.toState(self,"jump")	
     	end;	
    end;

    def onHitAnEnemy

    end;		

    def onNoFloor
		puts "Standing detector doesn't detect ground!"
  		@master.toState(self,"fall");
    end;
end;