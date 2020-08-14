class DetectorListener
	def initialize(master, callback)
		@master,@callback=master,callback
	end;

	def alert

	end;	
end;

class IsFloorListener<DetectorListener
	def initialize(master, callback)
		super(master, callback)		
	end;	

	def alert(controlPoints)
		#puts "IsFloorListener alert!"
		if !(controlPoints[7]["type"].include?(OBSTACLE) || controlPoints[9]["type"].include?(OBSTACLE) || controlPoints[0]["type"].include?(OBSTACLE) ||
			 controlPoints[7]["type"].include?(LADDER)   || controlPoints[9]["type"].include?(LADDER)   || controlPoints[0]["type"].include?(LADDER)   ||
			 controlPoints[7]["type"].include?(VIRTUAL)  || controlPoints[9]["type"].include?(VIRTUAL)  || controlPoints[0]["type"].include?(VIRTUAL)  ||
			 controlPoints[7]["type"].include?(PLATFORM) || controlPoints[9]["type"].include?(PLATFORM) || controlPoints[0]["type"].include?(PLATFORM))

      		#puts "IsFloorListener doesn't detect ground!"
      		#@master.master.toState(@master,"fall");
      		@master.send(@callback);
		end;	
	end;	
end;	

class IsLadderListener<DetectorListener
	def initialize(master, callback)
		super(master, callback)		
	end;	

	def alert(controlPoints)
		if !(controlPoints[5]["type"].include?(LADDER) || controlPoints[8]["type"].include?(LADDER))
		# 	@master.master.toState(@master,"stop");
		
		#puts "IsLadderListener doesn't detect ladder!"
        @master.send(@callback);
    end;
	end;
end;		


