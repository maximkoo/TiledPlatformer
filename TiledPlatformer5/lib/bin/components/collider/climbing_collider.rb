class ClimbingCollider<ColliderCore
	def initialize(master,x,y)
		@master=master;
		@master.objects<<self;
	end;

	def update
		#cons=contacts(@master, @master.master.master.objects);
    cons=contacts(@master, @master.master.master.master.objects);
		#print "*** Contacts: "
		#puts cons.to_s
		if cons
			# Для памяти: контактов может быть несколько, и их координты могут совпадать или не совпадать
			# надо выбрать из них первый критический, приводящий к остановке и смене состояния
			factContacts=cons.select{|c| #c.stillClass="MapObject"|| 
										(c.stillType==OBSTACLE || 
				                        c.stillType==VIRTUAL) && c.contactType=='lower horizontal'};
			log "*** #{self.class} factContacts:"
			log factContacts.to_s
			factContact=factContacts.first;	                        	
			if factContact
				log "*** #{self.class} factContacts:"
				log factContacts.to_s			
				@master.x=factContact[:safeX];
	            @master.y=factContact[:safeY];
	  			@master.master.toState(@master,"stop");
  			end;

  			factContacts=cons.select{|c| #c.stillClass="MapObject"|| 
										(c.stillType==OBSTACLE || 
				                        c.stillType==VIRTUAL) && c.contactType=='upper horizontal'};
			factContact=factContacts.first;	                       	
			if factContact			
				log "*** #{self.class} factContacts:"
				log factContacts.to_s
					
				@master.x=factContact[:safeX];
	            @master.y=factContact[:safeY];
	  			#@master.master.toState(@master,"stop");
	  			@master.yS=0;
  			end;
  			# надо также выбрать контакты с призами и всякого рода управляющими элементами
		end;	
		
	end;	
end;