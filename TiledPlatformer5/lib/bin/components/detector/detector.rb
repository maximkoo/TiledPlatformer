class Detector<Gosu_TiledMap::MovableGameObject
	attr_accessor :controlPoints
	def initialize(master,x,y)
		super(master,x,y)
		@controlPoints=[]

		@xS=master.xS;
		@yS=master.yS;
		@w,@h=master.w,master.h;
		reset(x,y)
	end;
	
	def reset(x,y)	
		@controlPoints=[]
		@controlPoints<<{:x=>x+@w/2,:y=>y+10} 	#0 test point below bottom
		@controlPoints<<{:x=>x,:y=>y-1};		#1 NW
		@controlPoints<<{:x=>x+@w/2,:y=>y-1};	#2 N
		@controlPoints<<{:x=>x+@w,:y=>y-1};		#3 NE
		@controlPoints<<{:x=>x,:y=>y+@h/2};		#4 W
		@controlPoints<<{:x=>x+@w/2,:y=>y+@h/2};#5 C
		@controlPoints<<{:x=>x+@w,:y=>y+@h/2};	#6 E
		@controlPoints<<{:x=>x,:y=>y+@h+1};		#7 SW
		@controlPoints<<{:x=>x+@w/2,:y=>y+@h+1};#8 S
		@controlPoints<<{:x=>x+@w,:y=>y+@h+1};	#9 SE
	end;

	def moveControlPoints
		@controlPoints.each do |cp|
			cp[:x]+=@xS; cp[:y]+=@yS;
		end;	
	end;	

	def update
		@x,@y=@master.x,@master.y
		@xS,@yS=master.xS,master.yS;
		moveControlPoints;

		@controlPoints.each do |cp|
			cp["type"]=@master.master.master.objectsByPoint(cp[:x],cp[:y]);
		end;	
	end;	
end;	