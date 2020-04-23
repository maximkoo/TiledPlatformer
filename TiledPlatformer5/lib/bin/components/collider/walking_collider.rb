class WalkingCollider<ColliderCore
	def initialize(master,x,y)
		#super(master,x,y)
		@master=master;
		@master.objects<<self;
	end;

	def update
		#cons=contacts(@master, @master.master.master.objects);
		cons=contacts(@master, @master.master.master.master.objects);
		if cons
			# Для памяти: контактов может быть несколько, и их координты могут совпадать или не совпадать
			# надо выбрать из них первый критический, приводящий к остановке и смене состояния
			factContacts=cons.select do |c| 
				# puts c.stillId
				#puts @master.master.master.objects.select{|p| p.object_id==c.stillId}.size
				 puts c.stillName
				#puts @master.master.master.objects.select{|p| p.object_id==c.stillId}.first.visible?
				#puts @master.master.master.objects.select{|p| p.object_id==c.stillId}.last.visible?
				#(c.stillType==OBSTACLE || c.stillType==PLATFORM || (c.stillType==VIRTUAL && @master.master.master.master.objects.select{|p| p.object_id==c.stillId}.first.visible?)) && c.contactType=~/vertical/;
        (c.stillType==OBSTACLE || c.stillType==PLATFORM || (c.stillType==VIRTUAL && c.still_object.visible?)) && c.contactType=~/vertical/;
			end;
			factContact=factContacts.first;	                        	
			if factContact
				log "*** #{self.class} factContacts:"
				log_contact(factContact)
				@master.x=factContact[:safeX];
	      #@master.y=factContact[:safeY]; # if we process "vertical" collisions, there is no need to set y
	  		#@master.master.toState(@master,"stop");
        if factContact.stillName=~/^Switch/
					puts "Switch"
          suffix=factContact.stillName.split(/(?=[A-Z])/).last
          factContact.still_object.onCollide();
					#factContact.still_object.visible=false;					
				end;
  		end;

  		factContacts=cons.select do |c| 
        #puts cons.first.inspect
				c.stillType==BONUS && @master.master.master.master.objects.select{|p| p.object_id==c.stillId}.first.visible?;
			end;
			factContact=factContacts.first;	                        	
			if factContact
				log "*** #{self.class} factContacts:"
				log_contact(factContact);
				if factContact.stillName=~/^Key/
					suffix=factContact.stillName.split(/(?=[A-Z])/).last
					puts "Suffix is #{suffix}"
					@master.master.master.master.objects.select{|p| p.name=~/#{suffix}?/}.each {|e| e.visible=false; puts "#{e.type} #{e.name} #{e.visible?}"};
				end;	        
  			end;
  			# надо также выбрать контакты с призами и всякого рода управляющими элементами
		end;	
		
	end;	
end;