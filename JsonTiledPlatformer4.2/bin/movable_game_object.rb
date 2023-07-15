require './bin/Rectangle.rb'
class MovableGameObject<Rectangle
	attr_accessor :x,:y,:xS,:yS,:prevX,:prevY, :master,:objects, :type,:name, :xx,:yy, :visible
	def initialize(master,x,y)			
		@x,@y=x,y
		@prevX,@prevY=x,y
		@xS,@yS=0,0

		@xx=@x-$viewport_offset_x
		@yy=@y	

		master.objects<<self;
		@master=master;
		@objects=[]

		if block_given?
			yield self
		end;	
	end;

	def set_viewport
		if @x<=$viewport_width/2
			$viewport_offset_x=0;
		elsif ($map_width-@x)<=$viewport_width/2
			$viewport_offset_x=$map_width-$viewport_width
		else
			$viewport_offset_x=@x-$viewport_width/2
		end;
	end;	

	def move
		@prevX=@x;
    	@prevY=@y;
    	@x+=@xS;
    	@y+=@yS; 
    	if self.class.name=~/Player/
    		set_viewport;
    	end;
    	@xx=@x-$viewport_offset_x
		@yy=@y	
	end;

	def draw
		img.draw(@xx,@yy,10);
	end;

	def visible?
		true;
	end;	
end;