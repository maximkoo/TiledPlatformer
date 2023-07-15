class DetectorListener
	def initialize(master, callback)
		@master,@callback=master,callback
	end;

	def alert

	end;	
end;

class IsNoFloorListener<DetectorListener
	def initialize(master, callback)
		super(master, callback)		
	end;	

	def alert(controlPoints)
		#puts "IsFloorListener alert!"
		if !(controlPoints[7]["type"].include?(OBSTACLE) || controlPoints[9]["type"].include?(OBSTACLE) || controlPoints[0]["type"].include?(OBSTACLE) ||
			 controlPoints[7]["type"].include?(LADDER)   || controlPoints[9]["type"].include?(LADDER)   || controlPoints[0]["type"].include?(LADDER)   ||
			 controlPoints[7]["type"].include?(VIRTUAL)  || controlPoints[9]["type"].include?(VIRTUAL)  || controlPoints[0]["type"].include?(VIRTUAL)  ||
			 controlPoints[7]["type"].include?(PLATFORM) || controlPoints[9]["type"].include?(PLATFORM) || controlPoints[0]["type"].include?(PLATFORM))

#<<<<<<< HEAD
#      		puts "IsFloorListener doesn't detect ground!"
#=======
      		#puts "IsFloorListener doesn't detect ground!"
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
      		#@master.master.toState(@master,"fall");
      		@master.send(@callback);
		end;	
	end;	
end;	

class IsNoLadderListener<DetectorListener
	def initialize(master, callback)
		super(master, callback)		
	end;	

	def alert(controlPoints)
		if !(controlPoints[5]["type"].include?(LADDER) || controlPoints[8]["type"].include?(LADDER))
        	@master.send(@callback);
    	end;
	end;
end;	

class IsLadderListener<DetectorListener
	def initialize(master, callback)
		super(master, callback)		
	end;	

	def alert(controlPoints)
		if controlPoints[5]["type"].include?(LADDER)
			@master.properties[:hasLadder]=true;
        	@master.send(@callback);
    	end;
	end;
end;	

class IsLadderDownListener<DetectorListener
	def initialize(master, callback)
		super(master, callback)		
	end;	

	def alert(controlPoints)
		if controlPoints[8]["type"].include?(LADDER)
        	@master.properties[:hasLadderDown]=true;
        	@master.send(@callback);
    	end;
	end;
end;	


class IsWallLeftListener<DetectorListener
	def initialize(master, callback)
		super(master, callback)		
	end;	

	def alert(controlPoints)
		if controlPoints[4]["type"].include?(OBSTACLE) 
			@master.properties[:hasWallLeft]=true;
        	@master.send(@callback);
    	end;
	end;
end;	

class IsWallRightListener<DetectorListener
	def initialize(master, callback)
		super(master, callback)		
	end;	

	def alert(controlPoints)
		if controlPoints[6]["type"].include?(OBSTACLE) 
        	@master.properties[:hasWallRight]=true;
        	@master.send(@callback);
    	end;
	end;
end;


