require './moving.rb'
require './rectangle.rb'
require './player_state.rb'
require './control_point.rb'
class Player
	#attr_accessor :x,:y,:w,:h,:c, :prevX, :prevY, :xS, :yS

	def initialize(x,y)
		@x,@y=x,y		
		#@xS=35;
		#@yS=35;
		###
		@walker=PlayerWalker.new(self,x,y);
		@faller=PlayerFaller.new(self,x,y);
		@state=@faller;
		@w,@h=@state.img.width,@state.img.height;
	end;


	def draw
		@state.draw;
	end;

	def toState(old_state,new_state)
		case new_state			
			when "walk" then ns=@walker
			when "fall" then ns=@faller
		end;
		#ns.x=old_state.x;
		#ns.y=old_state.y;
		ns.enter(old_state.x,old_state.y);		
		@state=ns;
	end;

	def update
		@state.update;
	end;	
end;	

class PlayerWalker<PlayerState#<Rectangle	
	def initialize(origin, x,y)
		super(origin,x,y)
		@player_anim=Gosu::Image.load_tiles('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_walk\/Player2.png', 770/11,94); 
		@current_frame=0;
		#@img=@player_anim[@current_frame];	
		#@x,@y=x,y
		#@origin=origin;
		#@w,@h=@img.width,@img.height;
		@w,@h=@player_anim[@current_frame].width,@player_anim[@current_frame].height;
		@xS=5; @yS=0;
		@controlPoints=[]
		@controlPoints<<ControlPoint.new(self, 0,0)
		@controlPoints<<ControlPoint.new(self, 0,0)
		resetControlPoints(x,y)
	end;

	def enter(x,y)
		@x,@y=x,y
		resetControlPoints(x,y)
	end;

	def resetControlPoints(x,y)
		@controlPoints[0].x,@controlPoints[0].y=x-1,y+@h+1
		@controlPoints[1].x,@controlPoints[1].y=x+@w+1,y+@h+1
	end;	

	def draw
		#@img.draw(@x,@y,10);
		@player_anim[@current_frame].draw(@x,@y,10);
	end;	

	def update
		move;
		#@controlPoints.each {|c| c.move};
		@components.each {|c| c.update}
		@current_frame=(@current_frame+1) % @player_anim.size
		if @controlPoints.select{|c| $collider.pointInObstacle?(c.x,c.y)==true}.size==0		
			puts "No ground"
			@origin.toState(self,"fall");
		end;	
	end;	

	def img
		#@img
		@player_anim[@current_frame]		
	end;
end;	

class PlayerFaller<PlayerState#<Rectangle
	#include Moving
	def initialize(origin,x,y)
		super(origin,x,y)
		@img=Gosu::Image.new('..\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_hurt.png')
		#@x,@y=x,y
		#@origin=origin;
		@xS=0; @yS=5;
		@w,@h=@img.width,@img.height;
	end;

	def enter(x,y)
		@x,@y=x,y
	end;

	def draw
		@img.draw(@x,@y,10);
	end;	
	
	def update
		move;
		 if $collider.collide?(self)
		 	puts "Collide!"
            contact=$collider.contact(self);
            @x=contact[:contactX];
            @y=contact[:contactY];
  			@origin.toState(self,"walk");
  		end;
	end;	

	def img
		@img
	end;
end;
