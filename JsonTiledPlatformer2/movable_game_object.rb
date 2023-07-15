require './rectangle.rb'
class MovableGameObject<Rectangle
	attr_accessor :master, :objects,:x,:y,:xS,:yS, :prevX, :prevY
	def initialize(master, x,y)		
		#puts master
		#puts master.objects.class
		master.objects<<self;
		@master=master;
		@objects=[]
		@x,@y=x,y
		@prevX,@prevY=x,y
		@xS,@yS=0,0
	end;

	def move
		@prevX=@x;
    	@prevY=@y;
    	@x+=@xS;
    	@y+=@yS;
	end;
end;		