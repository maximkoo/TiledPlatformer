require './movable.rb'
 class Rectangle
 	include Movable
 	#attr_accessor :x,:y,:w,:h, :prevX, :prevY, :xS, :yS
 	def initialize(x,y,w,h)
 		@x,@y,@w,@h=x,y,w,h	
 	end;

	#def draw()
		#Gosu.draw_rect(@x, @y, @w, @h, Gosu::Color::RED, 10);
	#end;

	# def move();
	# 	@prevX=@x;
 #    	@prevY=@y;
 #    	@x+=@xS;
 #    	@y+=@yS;
	# end;	

	# def x1
	# 	x;
	# end;
	
	# def x2
	# 	x+w;
	# end;
	
	# def y1
	# 	y
	# end;
	
	# def y2
	# 	y+h
	# end; 

end;	