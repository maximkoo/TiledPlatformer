require './bin/components/collider/walking_collider.rb'
require './bin/components/detector/walking_detector.rb'
class PlayerWalking<PlayerState
	def initialize(master, x,y)
		super(master,x,y)
		@player_anim=[]
		@player_anim[0] =Gosu::Image.load_tiles(PLAYER_BLUE_WALK_RIGHT_FILE, 770/11,94); 
		@player_anim[1] =Gosu::Image.load_tiles(PLAYER_BLUE_WALK_LEFT_FILE, 770/11,94); 
		@current_frame=0;
		@w,@h=img.width,img.height;
		@xS=0; @yS=0;
		@collider=WalkingCollider.new(self,x,y)
		@detector=WalkingDetector.new(self,x,y);
	end;

	def enter(x,y)
		puts "--- Walking! ---"
		#puts @collider.collide?(self)
    puts "PlayerWalking reports: docked_to=#{@docked_to.name}" if @docked_to
		@x,@y=x,y
		@yS=0;
		@detector.reset(x,y)
	end;

	#def draw
	#	img.draw(@x,@y,10);
	#end;	

	def update
		#move;
    super
		@current_frame=(@current_frame+1) % @player_anim[0].size;		
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

	# def reverse
	# 	@xS=-@xS
	# end;

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
end;