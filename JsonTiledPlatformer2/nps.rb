class Nps<MovableGameObject
	attr_accessor :tileId, :tileids, :animation, :durations, :frame_delay
	def initialize(master,x,y)
		super(master,x,y)
		#@tileids=[]
		#@animation=[]
		#@durations=[]
		#@nps_animation<<$m.tilesets.get(172);
		#@nps_animation<<$m.tilesets.get(174);
		@current_frame=0
		@frame_delay=100	
	end;

	def update
	  now=Gosu.milliseconds
	  return if (now-@last_update||=now) < @frame_delay 
	  @current_frame+=1; @current_frame=@current_frame % @animation.size	  
	  @last_update=now;
	end;

	def draw
		@animation[@current_frame].draw(@x,@y,10);
	end;

	def img
		@animation[@current_frame]
	end;
end;	