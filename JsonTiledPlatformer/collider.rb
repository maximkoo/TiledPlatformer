class Collider
	def initialize(json)
		#h=JSON.parse(File.read(MAP_FILE));
		@obstacles=getObstacles(json)
		puts @Obstacles
		@still=nil
	end;	

	def getObstacles(json)
		obstacles=[]
		json['layers'].select{|x| x["name"]=="ObjectLayer1"}.each do |x|
			#puts x['objects']
			x['objects'].select{|xx| xx["type"]=="Obstacle"}.each do |xx|
				obstacles<<Rectangle.new(xx["x"],xx["y"],xx["width"],xx["height"])
			end;
		end;
		obstacles	 
	end;	

	def sgn(n)
  		n <=> 0
	end

	def collide?(moving)		
		@obstacles.each do |still|
			if intersect?(moving, still)
				@still=still
				return true;
			end;	
		end;	
		return false
	end;
		
	def intersect?(moving, still)
			(moving.x1.between?(still.x1,still.x2) && moving.y1.between?(still.y1,still.y2)) ||
			(moving.x1.between?(still.x1,still.x2) && moving.y2.between?(still.y1,still.y2)) ||
			(moving.x2.between?(still.x1,still.x2) && moving.y1.between?(still.y1,still.y2)) ||
			(moving.x2.between?(still.x1,still.x2) && moving.y2.between?(still.y1,still.y2))
	end;

	def intersectHashes(c1, c2)
			(c1[:x1].between?(c2[:x1],c2[:x2]) && c1[:y1].between?(c2[:y1],c2[:y2])) ||
			(c1[:x1].between?(c2[:x1],c2[:x2]) && c1[:y2].between?(c2[:y1],c2[:y2])) ||
			(c1[:x2].between?(c2[:x1],c2[:x2]) && c1[:y1].between?(c2[:y1],c2[:y2])) ||
			(c1[:x2].between?(c2[:x1],c2[:x2]) && c1[:y2].between?(c2[:y1],c2[:y2]))
	end;	

	def intersectCoords(x1,y1,x2,y2,x3,y3,x4,y4)
			(x1.between?(x3,x4) && y1.between?(y3,y4)) ||
			(x1.between?(x3,x4) && y2.between?(y3,y4)) ||
			(x2.between?(x3,x4) && y1.between?(y3,y4)) ||
			(x2.between?(x3,x4) && y2.between?(y3,y4))
	end;

	def rectInObstacle?(x1,y1,x2,y2)
		@obstacles.each do |still|
			return true if intersectCoords(x1,y1,x2,y2, still.x1, still.y1, still.x2, still.y2)
		end;	
		return false;
	end;

	def pointInObstacle?(x1,y1)
		@obstacles.each do |still|
			return true if intersectCoords(x1,y1,x1,y1, still.x1, still.y1, still.x2, still.y2)
		end;	
		return false;
	end;	

	#def contact(moving, still)
	def contact(moving)
		still=@still;
		dx=moving.x-moving.prevX;
		dy=moving.y-moving.prevY;
		# if dx==0 return;

		hdg=dy.fdiv dx if dx!=0;	
		#puts "hdg=#{hdg}"

		x=moving.prevX;
		y=moving.prevY;
		# puts "Initial x=#{x}, y=#{y}"
		c1={x1:x, x2:x+moving.w, y1:y, y2:y+moving.h};
		c2={x1:still.x1, x2:still.x2, y1:still.y1, y2:still.y2};

		# puts c1;
		# puts c2;

		# puts ":::::: HDG=#{hdg} ::::::"

		while !intersectHashes(c1, c2)
			prevX=x; prevY=y;
			# puts "prevX=#{prevX}, prevY=#{prevY}"
			if dx==0
				y=y+sgn(dy);
			elsif hdg.abs<=1
				x=x+sgn(dx);
				y=y+hdg;
			else	
				y=y+sgn(dy);
				x=x+1.fdiv(hdg);
			end;	
			c1={x1:x.round, x2:x.round+moving.w, y1:y.round, y2:y.round+moving.h};	
		end;		
			side=case
				when (x.round+moving.w)==still.x1 then "left vertical"
				when x.round==still.x2 then "right vertical"
				when (y.round+moving.h)==still.y1 then "upper horizontal"
				when y.round==still.y2 then "lower horizontal"
			end;			
			#puts "Contact detected on #{side} side";
			return {safeX:prevX.round, 
				safeY:prevY.round, 
				contactX:x.round, 
				contactY:y.round, 
				contactType:side};
	end;	
end;	
