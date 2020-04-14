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
				(c.stillType==OBSTACLE || c.stillType==PLATFORM || (c.stillType==VIRTUAL && @master.master.master.master.objects.select{|p| p.object_id==c.stillId}.first.visible?)) && c.contactType=~/vertical/;
			end;
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
	  		@master.master.toState(@master,"stop");
  		end;

  		factContacts=cons.select do |c| 
        #puts cons.first.inspect
				c.stillType==BONUS && @master.master.master.master.objects.select{|p| p.object_id==c.stillId}.first.visible?;
			end;
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
				if factContact.stillName=~/^Key/
					suffix=factContact.stillName.split(/(?=[A-Z])/).last
					puts "Suffix is #{suffix}"
					# @master.master.master.objects.select{|p| p.name=~/#{suffix}?/}
					#@master.master.master.master.objects.select{|p| p.name=~/#{suffix}?/}.each {|e| e.disappear; puts "#{e.type} #{e.name} #{e.visible?}"};
					@master.master.master.master.objects.select{|p| p.name=~/#{suffix}?/}.each {|e| e.visible=false; puts "#{e.type} #{e.name} #{e.visible?}"};
				end;	
  			end;
  			# надо также выбрать контакты с призами и всякого рода управляющими элементами
		end;	
		
	end;	
end;