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
		#@controlPoints=[]
		@controlPoints[0]={:x=>x+@w/2,:y=>y+@h+10} 	#0 test point below bottom
		@controlPoints[1]={:x=>x,:y=>y-1};		#1 NW
		@controlPoints[2]={:x=>x+@w/2,:y=>y-1};	#2 N
		@controlPoints[3]={:x=>x+@w-1,:y=>y-1};		#3 NE
		@controlPoints[4]={:x=>x,:y=>y+@h/2};		#4 W
		@controlPoints[5]={:x=>x+@w/2,:y=>y+@h/2};#5 C
		@controlPoints[6]={:x=>x+@w-1,:y=>y+@h/2};	#6 E
		@controlPoints[7]={:x=>x,:y=>y+@h+1};		#7 SW
		@controlPoints[8]={:x=>x+@w/2,:y=>y+@h+1};#8 S
		@controlPoints[9]={:x=>x+@w-1,:y=>y+@h+1};	#9 SE
    #10px below the lower border, for moving platforms
		@controlPoints[10]={:x=>x,:y=>y+@h+10};		#7 SW
		@controlPoints[11]={:x=>x+@w/2,:y=>y+@h+10};#8 S
		@controlPoints[12]={:x=>x+@w-1,:y=>y+@h+10};	#9 SE
	end;

	# def moveControlPoints
	# 	@controlPoints.each do |cp|
	# 		cp[:x]+=@xS; cp[:y]+=@yS;
	# 	end;	
	# end;	

	def update
		@x,@y=@master.x,@master.y
		@xS,@yS=master.xS,master.yS;
		#moveControlPoints;
    	reset(@x,@y)
		@controlPoints.each do |cp|
			cp["type"]=@master.master.master.master.objectsByPoint(cp[:x],cp[:y]);
		end;	
	end;	
end;	