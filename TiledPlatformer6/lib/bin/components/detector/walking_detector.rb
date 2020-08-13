class WalkingDetector<Detector
	def initialize(master,x,y)
		super(master,x,y)		
	end;	

	def update
		super	
        @master.detectorListeners.each do |l|
        	l.alert(@controlPoints)
        end;	
	end;
end;