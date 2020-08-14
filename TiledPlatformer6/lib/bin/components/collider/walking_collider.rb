class WalkingCollider<ColliderCore
	def initialize(master,x,y)
		#super(master,x,y)
		@master=master;
		@master.objects<<self;
	end;

	def update
		cons=contacts(@master, @master.master.master.master.objects);
		@master.criticalContact=false;
		
		return if cons.nil?		
		#puts "WalkingCollider reports"
		#puts cons.first.stillType;
		cons.each do |c|
			@master.listeners.each do |l|
				l.alert(c);				
			end;	
			break if @master.criticalContact
		end;	
	end;		
end;