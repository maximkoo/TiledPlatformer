class WalkingDetector<Detector
	def initialize(master,x,y)
		super(master,x,y)		
	end;	

	def update
		super		
		### WALKING TO FALLING ###
		#puts "Control point 7 is #{@controlPoints[7]["type"]}"
		#puts "Control point 9 is #{@controlPoints[9]["type"]}"
		if !(@controlPoints[7]["type"].include?(OBSTACLE) || @controlPoints[9]["type"].include?(OBSTACLE) ||
			 @controlPoints[7]["type"].include?(LADDER) || @controlPoints[9]["type"].include?(LADDER)||
			 @controlPoints[7]["type"].include?(VIRTUAL) || @controlPoints[9]["type"].include?(VIRTUAL) ||
			 @controlPoints[7]["type"].include?(PLATFORM) || @controlPoints[9]["type"].include?(PLATFORM))
		 	@master.master.toState(@master,"fall");
		end;	
	end;
end;