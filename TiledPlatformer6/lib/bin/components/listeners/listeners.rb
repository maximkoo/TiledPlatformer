class AbstractListener
	attr_accessor :callback
	def initialize(master, callback)
		@master, @callback=master,callback;
	end;	

	def alert(contact)
		 @contact=contact;
	end;
end;		

class HitAFloorListener<AbstractListener
	def alert(contact)
		super(contact);
		#puts "HitAFloorListener alert!"
		if 	(contact.stillType==OBSTACLE || 
		   	contact.stillType==PLATFORM || 
		   	(contact.stillType==VIRTUAL && contact.stillObject.visible?) || 
		   	contact.stillType==LADDER) 	&& contact.contactType=='lower horizontal'
				# log "*** #{self.class} factContacts:"
				# log_contact(factContact)
				@master.x=contact[:safeX];
	      		@master.y=contact[:safeY];
	      		@master.criticalContact=true;
	      		@master.send(@callback);
		end;		
	end;
end;

class HitAWallListener<AbstractListener
	def alert(contact)
		super(contact);
		#puts "HitAWallListener alert!"
		if (contact.stillType==OBSTACLE || contact.stillType==PLATFORM || (contact.stillType==VIRTUAL && contact.stillObject.visible?)) && contact.contactType=~/vertical/;
			#log "*** #{self.class} factContacts:"
			#log_contact(factContact)
			contact.stillObject.onCollide;
			@master.x=contact[:safeX];
			@master.criticalContact=true;
	  		@master.send(@callback);
       	end;
	end;
end;

class HitACeilingListener<AbstractListener
	def alert(contact)
		super(contact);
		#puts "HitACeilingListener alert!"
		if (contact.stillType==OBSTACLE || 
			contact.stillClass==LADDER || 
			(contact.stillClass==VIRTUAL&& contact.still_object.visible?) && contact.contactType=='upper horizontal')
			#	log "*** #{self.class} factContacts:"
			#	log_contact(factContact);	
			@master.x=contact[:safeX];
	        @master.y=contact[:safeY];	  		
	  		@master.yS=0;
	  		@master.criticalContact=true;
	  		@master.send(@callback);
  		end;
	end;
end;

class HitABonusListener<AbstractListener
	def alert(contact)
    
    #puts("onCollide=#{stillObject.onCollide}");	
		if contact.stillType==BONUS && contact.stillObject.visible;
			#log "*** #{self.class} factContacts:"
			#log_contact(factContact);
      puts "Listener alert, #{contact.stillType}, #{contact.stillObject.visible}"
			#puts("onCollide=#{stillObject.onCollide}");	
      puts contact.stillObject.class;
      contact.stillObject.onCollide;
  	end;
	end;
end;

class HitAVirtualListener<AbstractListener
	def alert(contact)

	end;
end;

class HitASwitchListener<AbstractListener
	def alert(contact)
		if contact.stillType==SWITCH && contact.stillObject.visible;
			#log "*** #{self.class} factContacts:"
			#log_contact(factContact);
			stillObject.onCollide;	        
  		end;
	end;
end;

# class HitAFloorWhenClimbingListener<AbstractListener
# 	def alert(master, contact, callback)

# 	end;
# end;

# class HitACeilingWhenClimbingListener<AbstractListener
# 	def alert(master, contact, callback)

# 	end;
# end;

class HitAnEnemyListener<AbstractListener
	def alert(contact)

	end;
end;

class DockToAPlatform<AbstractListener
	def alert(contact)
		super(contact);
		if 	contact.stillType==PLATFORM && contact.contactType=='lower horizontal'
			puts "Docking alert!"
	 		@master.docked_to=contact.stillObject
	 		puts @master.docked_to.class
		end;
	end;
end;	

class HitAFloorWhenClimbingListener<AbstractListener
	def alert(contact)
		super(contact);
		#puts "HitAFloorListener alert!"
		if 	(contact.stillType==OBSTACLE || 
		   	contact.stillType==PLATFORM || 
		   	(contact.stillType==VIRTUAL && contact.stillObject.visible?) #|| 
		   	#contact.stillType==LADDER
		   	) 	&& contact.contactType=='lower horizontal'
				# log "*** #{self.class} factContacts:"
				# log_contact(factContact)
				@master.x=contact[:safeX];
	      		@master.y=contact[:safeY];
	      		@master.criticalContact=true;
	      		@master.send(@callback);
		end;		
	end;
end;

class HitACeilingWhenClimbingListener<AbstractListener
	def alert(contact)
		super(contact);
		#puts "HitACeilingListener alert!"
		if (contact.stillType==OBSTACLE || 
			#contact.stillClass==LADDER || 
			(contact.stillClass==VIRTUAL&& contact.still_object.visible?) && contact.contactType=='upper horizontal')
			#	log "*** #{self.class} factContacts:"
			#	log_contact(factContact);	
			@master.x=contact[:safeX];
	        @master.y=contact[:safeY];	  		
	  		@master.yS=0;
	  		@master.criticalContact=true;
	  		@master.send(@callback);
  		end;
	end;
end;