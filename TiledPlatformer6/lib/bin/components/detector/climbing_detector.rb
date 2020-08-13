class ClimbingDetector<Detector
	def initialize(master,x,y)
		super(master,x,y)		
	end;	

	def update
		super		
		#puts @controlPoints[4]
		#puts @controlPoints[7]
		if !@controlPoints[5]["type"].include?(LADDER) && !@controlPoints[8]["type"].include?(LADDER)
		 	@master.master.toState(@master,"stop");
		end;	

		#if @controlPoints[6]["type"].include?(OBSTACLE) && @controlPoints[8]["type"].include?(OBSTACLE)&& !@controlPoints[7]["type"].include?(LADDER)
		# 	@master.master.toState(@master,"stop");
		# end;
	
	end;
end;