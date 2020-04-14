class FallingCollider<ColliderCore
	def initialize(master,x,y)
		#super(master,x,y)
		@master=master;
		@master.objects<<self;
	end;

	def update
    #puts @master
    #puts @master.master.master.objects
#		cons=contacts(@master, @master.master.master.objects);
#    TiledMap -> (ObjectLayer)Layer_X -> Player -> PlayerFalling -> FallingCollider
		cons=contacts(@master, @master.master.master.master.objects);
		#print "*** Contacts: "
		#puts cons.to_s
		if cons
			# Для памяти: контактов может быть несколько, и их координты могут совпадать или не совпадать
			# надо выбрать из них первый критический, приводящий к остановке и смене состояния
			factContacts=cons.select{|c| (c.stillType==OBSTACLE || c.stillType==PLATFORM || c.stillType==VIRTUAL || c.stillType==LADDER) && c.contactType=='lower horizontal'};
			
			factContact=factContacts.first;	                        	
			if factContact
				log "*** #{self.class} factContacts:"
				log "#Contact movingId={factContact.movingId} "+
            "movingClass=#{factContact.movingClass} "+
            "stillId=#{factContact.stillId} "+
            "stillClass=#{factContact.stillClass} "+
            "stillType=#{factContact.stillType} "+
            "stillName=#{factContact.stillName} "+
            "safeX=#{factContact.safeX} "+
            "safeY=#{factContact.safeY} "+
            "hitX=#{factContact.hitX} "+
            "hitY=#{factContact.hitY} "+
            "contactType=#{factContact.contactType} ";
				@master.x=factContact[:safeX];
	      @master.y=factContact[:safeY];
        if factContact.stillType==PLATFORM; 
          @master.docked_to=factContact.still_object
          puts "docked_to is set to #{factContact.stillName}, ys=#{factContact.still_object.yS}"
        end;
	  		@master.master.toState(@master,"stop");
  		end;
  		# надо также выбрать контакты с призами и всякого рода управляющими элементами
		end;	
		
	end;	
end;