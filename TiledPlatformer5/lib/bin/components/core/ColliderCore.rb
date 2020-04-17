Contact=Struct.new( :movingId,
					:movingClass,
          :still_object,
					:stillId,
					:stillClass,
					:stillType,
					:stillName,
					:safeX,
					:safeY,
					:hitX,
					:hitY,
					:contactType);

class ColliderCore
		ALL='All'
		NONE='None'
		LOG_LEVEL=NONE

	def sgn(n)
  		n <=> 0
	end
  
  def log_contact(cntct)
    log "Contact movingId=#{cntct.movingId} "+
        "movingClass=#{cntct.movingClass} "+
        "stillId=#{cntct.stillId} "+
        "stillClass=#{cntct.stillClass} "+
        "stillType=#{cntct.stillType} "+
        "stillName=#{cntct.stillName} "+
        "safeX=#{cntct.safeX} "+
        "safeY=#{cntct.safeY} "+
        "hitX=#{cntct.hitX} "+
        "hitY=#{cntct.hitY} "+
        "contactType=#{cntct.contactType} ";    
  end
  
	def intersectCoords?(x1,y1,x2,y2,x3,y3,x4,y4)
			(x1.round.between?(x3,x4) && y1.round.between?(y3,y4)) ||
			(x1.round.between?(x3,x4) && y2.round.between?(y3,y4)) ||
			(x2.round.between?(x3,x4) && y1.round.between?(y3,y4)) ||
			(x2.round.between?(x3,x4) && y2.round.between?(y3,y4)) ||
    
      # The opposite situation - when an obstacle is inside a moving object!
			(x3.round.between?(x1,x2) && y3.round.between?(y1,y2)) ||
			(x3.round.between?(x1,x2) && y4.round.between?(y1,y2)) ||
			(x4.round.between?(x1,x2) && y3.round.between?(y1,y2)) ||
			(x4.round.between?(x1,x2) && y4.round.between?(y1,y2))
    
      
	end;

	def intersect?(moving, still)
		intersectCoords?(moving.x1,moving.y1,moving.x2,moving.y2,still.x1,still.y1,still.x2,still.y2)
	end;

	def contacts(moving, objs)
		return nil if objs.reject{|c| c.class.name==moving.class.name || c.class.name==PLAYER_CLASS}.select{|still| intersect?(moving,still)}.size==0
		getContacts(moving,objs);		
	end;

	def getContacts(moving,objs)
		contacts=[]

		dx=moving.x-moving.prevX;
		dy=moving.y-moving.prevY;

		hdg=dy.fdiv dx if dx!=0;	
		hdg=hdg.abs if !hdg.nil?

		x=moving.prevX;
		y=moving.prevY;

		while !(x.round==moving.x && y.round==moving.y)
		#while !intersectCoords?(x, y, x+moving.w, y+moving.h, still.x1, still.y1, still.x2, still.y2)
			safeX=x; safeY=y;
			if dx==0
				y=y+sgn(dy);
			elsif hdg.abs<=1
				x=x+sgn(dx);
				y=y+hdg*sgn(dy);				
			else	
				y=y+sgn(dy);
				x=x+1.fdiv(hdg)*sgn(dx);				
			end;	
			log() 
			log "Collider reports: current x,y=#{x}, #{y}"
			exit if x<0||y>1000||y<0||x>2000
		
			objs.reject{|c| c.class.name==moving.class.name || c.class.name==PLAYER_CLASS}.each do |still|		
				if intersectCoords?(x, y, x+moving.w-1, y+moving.h-1, still.x1, still.y1, still.x2, still.y2)
					log "intersection detected on an #{still.class.name} #{still.type} #{still.name} #{still.object_id} with x1,y1=#{still.x1},#{still.y1} x2,y2=#{still.x2},#{still.y2}"
					#print "Moving is: "
					#puts moving.inspect
					#print "Still is"
					#puts still.inspect
					side=case
						when (x.round+moving.w-1)==still.x1 then "right vertical"
						when x.round==still.x2 then "left vertical"
						when (y.round+moving.h-1)==still.y1.round then "lower horizontal"
						when y.round==still.y2 then "upper horizontal"
					end;
					if contacts.select{|c| c.stillId==still.object_id}.size==0
						contacts<<Contact.new(	moving.object_id,
											 	moving.class.name,
                        still,
											 	still.object_id,
											  	still.class.name,
											  	still.type,
											  	still.name,
											  	safeX.round,
					 						  	safeY.round,
					 				  		  x.round,
					 						  	y.round,
					 						  	side);
					end;
					#puts contacts;
				end;	
			end;
		end;	
		
		contacts
	end;	

	def log(*messages)
		if LOG_LEVEL==ALL
			messages.each do |x|
				puts x
			end;	
		end;		
	end;		
end;




