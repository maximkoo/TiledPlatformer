Contact=Struct.new( :movingId,
					:movingClass,
					:stillId,
					:stillClass,
					:safeX,
					:safeY,
					:hitX,
					:hitY,
					:contactType);

class ColliderCore
	def sgn(n)
  		n <=> 0
	end

	def intersectCoords?(x1,y1,x2,y2,x3,y3,x4,y4)
			(x1.round.between?(x3,x4) && y1.round.between?(y3,y4)) ||
			(x1.round.between?(x3,x4) && y2.round.between?(y3,y4)) ||
			(x2.round.between?(x3,x4) && y1.round.between?(y3,y4)) ||
			(x2.round.between?(x3,x4) && y2.round.between?(y3,y4))
	end;

	def intersect?(moving, still)
		intersectCoords?(moving.x1,moving.y1,moving.x2,moving.y2,still.x1,still.y1,still.x2,still.y2)
	end;

	def contact(moving, objs)
		return nil if objs.select{|still| intersect?(moving,still)}.size==0
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
			puts 
			puts "Collider reports: current x,y=#{x}, #{y}"
			exit if x<0||y>980||y<0||x>1000
		
			objs.each do |still|		
				if intersectCoords?(x, y, x+moving.w-1, y+moving.h-1, still.x1, still.y1, still.x2, still.y2)
					puts "intersection detected on an #{still.class.name} with x,y=#{still.x},#{still.y}"
					#print "Moving is: "
					#puts moving.inspect
					print "Still is"
					puts still.inspect
					side=case
						when (x.round+moving.w-1)==still.x1 then "left vertical"
						when x.round==still.x2 then "right vertical"
						when (y.round+moving.h-1)==still.y1 then "upper horizontal"
						when y.round==still.y2 then "lower horizontal"
					end;
					if contacts.select{|c| c.stillId==still.object_id}.size==0
						contacts<<Contact.new(	moving.object_id,
											 	moving.class.name,
											 	still.object_id,
											  	still.class.name,
											  	safeX.round,
					 						  	safeY.round,
					 				  		  	x.round,
					 						  	y.round,
					 						  	side);
					end;
					puts contacts;
				end;	
			end;
		end;	
		
		contacts
	end;	
end;




