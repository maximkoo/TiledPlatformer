class MiniCollider<MovableGameObject
	def initialize(master,x,y)
		super(master,x,y)		
	end;

	def update

	end;

	def draw
		#Здесь ничего не написано
	end;

	def sgn(n)
  		n <=> 0
	end

	def collide?(moving)		
		@master.master.master.obstacles.each do |still|
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

	def intersectCoords?(x1,y1,x2,y2,x3,y3,x4,y4)
			(x1.round.between?(x3,x4) && y1.round.between?(y3,y4)) ||
			(x1.round.between?(x3,x4) && y2.round.between?(y3,y4)) ||
			(x2.round.between?(x3,x4) && y1.round.between?(y3,y4)) ||
			(x2.round.between?(x3,x4) && y2.round.between?(y3,y4))
	end;

	def contact(moving)
		still=@still;
		dx=moving.x-moving.prevX;
		dy=moving.y-moving.prevY;

		# puts "dx=#{dx} dy=#{dy}"
		hdg=dy.fdiv dx if dx!=0;	
		hdg=hdg.abs if !hdg.nil?
		# puts "hdg=#{hdg}"
		# puts "moving.x=#{moving.x}, moving.y=#{moving.y} moving.prevX=#{moving.prevX}, moving.prevY=#{moving.prevY}"
		x=moving.prevX;
		y=moving.prevY;
		# puts "Collider.x=#{x}, y=#{y}"
prevXX=moving.prevX; prevYY=moving.prevY;
		while !intersectCoords?(x, y, x+moving.w, y+moving.h, still.x1, still.y1, still.x2, still.y2)
			prevXX=x; prevYY=y;
			# ***
			 # puts "prevXX=#{prevXX}, prevYY=#{prevYY}, x=#{x}, y=#{y},  x+moving.w=#{ x+moving.w}, y+moving.h=#{y+moving.h}, still.x1=#{still.x1}, still.y1=#{still.y1}, still.x2=#{still.x2}, still.y2=#{still.y2}"
			# ***
			if dx==0
				y=y+sgn(dy);
			elsif hdg.abs<=1
				x=x+sgn(dx);
				y=y+hdg*sgn(dy);				
			else	
				y=y+sgn(dy);
				x=x+1.fdiv(hdg)*sgn(dx);				
			end;	
			exit if prevYY<0
			exit if prevYY>980
			exit if prevXX<0
			exit if prevXX>1000
		end;		
		
		side=case
			when (x.round+moving.w)==still.x1 then "left vertical"
			when x.round==still.x2 then "right vertical"
			when (y.round+moving.h)==still.y1 then "upper horizontal"
			when y.round==still.y2 then "lower horizontal"
		end;			
		puts  "x.round=#{x.round}, still.x1=#{still.x1}, still.x2=#{still.x2}"
		puts  "y.round=#{y.round}, still.y1=#{still.y1}, still.y2=#{still.y2}"
		puts side;
	begin
		v= {safeX:prevXX.round, 
				safeY:prevYY.round, 
				contactX:x.round, 
				contactY:y.round, 
				contactType:side};
	rescue NoMethodError => e
		puts "*** RESCUE ***"
		puts @master.class.name
		puts "Moving: x1:#{x.round},y1:#{y.round},x2:#{x.round+moving.w},y2:#{y.round+moving.h}"
		puts "Moving: prevXX: #{prevXX}, prevYY: #{prevYY}"
		puts "Still: x1:#{still.x1}, y1:#{still.y1}, x2:#{still.x2}, y2:#{still.y2}"
		puts "***"
	end	
		return v		
	end;	
end;		

class FallingCollider<MiniCollider
	def initialize(master,x,y)
		super(master,x,y)
	end;

	def update
		if collide?(@master)
			contact=contact(@master);
            @master.x=contact[:safeX];
            @master.y=contact[:safeY];

  			#@master.master.toState(@master,"walk");
  			@master.master.toState(@master,"stop");
		end;	
	end;

	def draw
		#Здесь ничего не написано
	end;
end;	

class WalkingCollider<MiniCollider
	def initialize(master,x,y)
		super(master,x,y)
	end;

	def update
		if collide?(@master)			
			contact=contact(@master);
            @master.x=contact[:safeX];
            @master.y=contact[:safeY];
  			#@master.master.toState(@master,"stop");
  			#@master.reverse;
		end;	
	end;

	def draw
		#Здесь ничего не написано
	end;
end;	

class JumpingCollider<MiniCollider
	def initialize(master,x,y)
		super(master,x,y)
	end;

	def update
		if collide?(@master)
			# puts "Collide x=#{@master.x} y=#{master.y}"
			# puts "Collide prevx=#{@master.prevX} prevy=#{master.prevY}"

			contact=contact(@master);
            @master.x=contact[:safeX];
            @master.y=contact[:safeY];
  			
             if contact[:contactType]=~/vertical/
  				 @master.xS=0;
             end;
            if contact[:contactType]=="upper horizontal"
            	@master.yS=0;
  				@master.master.toState(@master,"stop");
  			end;	
  			#@master.reverse;
		end;	
	end;

	def draw
		#Здесь ничего не написано
	end;
end;	

class ClimbingCollider<MiniCollider
	def initialize(master,x,y)
		super(master,x,y)
	end;

	def update
		if collide?(@master)
			# puts "Collide x=#{@master.x} y=#{master.y}"
			# puts "Collide prevx=#{@master.prevX} prevy=#{master.prevY}"

			contact=contact(@master);
            @master.x=contact[:safeX];
            @master.y=contact[:safeY];

            if contact[:contactType]=="upper horizontal"
            	@master.yS=0;
  				@master.master.toState(@master,"stop");
  			end;
  		end;	
	end;
	
	def draw

	end;
end;

