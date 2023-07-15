require './bin/crawler/crawler_walking.rb'
require './bin/crawler/crawler_falling.rb'
#require './bin/crawler/crawler_jumping.rb'
#<<<<<<< HEAD
require './bin/crawler/crawler_climbing.rb'
#=======
#require './bin/crawler/crawler_climbing.rb'
>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
#require './bin/crawler/crawler_standing.rb'
class Crawler<Gosu_TiledMap::MapObject
	attr_reader :state
  	def initialize(master,data)
    	super(master, data)
    	puts "Crawler reporting: master is #{@master.name}"
		@type=@name=CRAWLER
    	x,y=data["x"],data["y"]

		@states=Hash.new;
		@states["walk"]=CrawlerWalking.new(self,x,y);
		@states["fall"]=CrawlerFalling.new(self,x,y);
		#@states["stop"]=CrawlerStanding.new(self,x,y);
		#@states["jump"]=CrawlerJumping.new(self,x,y);
#<<<<<<< HEAD
		@states["climb"]=CrawlerClimbing.new(self,x,y);
#=======
		#@states["climb"]=CrawlerClimbing.new(self,x,y);
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe

		@state=@states["fall"]
		@w,@h=@state.img.width,@state.img.height;
		@state.face="right";
	
		@checkPoints=[]
#<<<<<<< HEAD
		@checkPoints<<{num: 0, x:@state.x, y:@state.y, xTiles:@state.x/TILE_SIZE, yTiles:(@state.y+@h-1)/TILE_SIZE, properties:[:fall]}
		@state.start_cp=@checkPoints.first
		@cpIterator=@checkPoints.each; #--<<--
		#getNextCheckPoint();
		@currentCp=@cpIterator.next;
		@cpPropsIterator=@currentCp[:properties].each;
		@currentCpProperty=@cpPropsIterator.next;

		@edges=[]

		@logfile = File.open("log.txt",'w')
		all_checkpoints_secured=false
#=======
#		@checkPoints<<{x:@state.x, y:@state.y, xTiles:@state.x/TILE_SIZE, yTiles:(@state.y+@h-1)/TILE_SIZE, properties:[:fall]}

#		@logfile = File.open("log.txt",'w')
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	end;

	def draw
		@state.draw;
#<<<<<<< HEAD
		draw_checkpoints;
#=======
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	end;

	def update	
		@state.update;
    	#@master.master.set_viewport_offset(@state.x, @state.y)
	end;

#<<<<<<< HEAD
	def draw_checkpoints
		@checkPoints.each_with_index do |c,idx|
			hp=DATA_PLAYER["height"] # for brevity
			Gosu.draw_line(c[:x],c[:y],Gosu::Color::RED,c[:x]+TILE_SIZE,c[:y],Gosu::Color::RED,20)
			Gosu.draw_line(c[:x]+TILE_SIZE,c[:y],Gosu::Color::RED,c[:x]+TILE_SIZE,c[:y]+DATA_PLAYER["height"],Gosu::Color::RED,20)
			Gosu.draw_line(c[:x],c[:y]+DATA_PLAYER["height"],Gosu::Color::RED,c[:x]+TILE_SIZE,c[:y]+DATA_PLAYER["height"],Gosu::Color::RED,20)
			Gosu.draw_line(c[:x],c[:y],Gosu::Color::RED,c[:x],c[:y]+DATA_PLAYER["height"],Gosu::Color::RED,20)
			# directions
			Gosu.draw_line(c[:x]+TILE_SIZE/2,c[:y]+hp/2,Gosu::Color::RED,c[:x]+TILE_SIZE/2,c[:y]+hp,Gosu::Color::RED,20) if c[:properties].include? :fall
			Gosu.draw_line(c[:x]+TILE_SIZE/2,c[:y]+hp/2,Gosu::Color::RED,c[:x],c[:y]+hp/2,Gosu::Color::RED,20) if c[:properties].include? :walk_left
			Gosu.draw_line(c[:x]+TILE_SIZE/2,c[:y]+hp/2,Gosu::Color::RED,c[:x]+TILE_SIZE,c[:y]+hp/2,Gosu::Color::RED,20) if c[:properties].include? :walk_right
			Gosu.draw_line(c[:x]+TILE_SIZE/2,c[:y]+hp/2,Gosu::Color::RED,c[:x]+TILE_SIZE/2,c[:y],Gosu::Color::RED,20) if c[:properties].include? :climb
			Gosu.draw_line(c[:x]+TILE_SIZE/2,c[:y]+hp/2,Gosu::Color::RED,c[:x]+TILE_SIZE/2,c[:y]+hp,Gosu::Color::RED,20) if c[:properties].include? :climb_down
			LARGE_FONT.draw_text(idx.to_s,c[:x],c[:y],20,1,1,Gosu::Color::RED)
		end;	
	end;	

#=======
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	def toState(old_state,new_state)
		#>>> old_state - PlayerState
		#>>> new_state - String
		ns=@states[new_state];

		#puts "New state is #{new_state}"
		#puts "New state objects is #{@states[new_state]}"
		ns.xS=old_state.xS;
		ns.yS=old_state.yS;
		ns.xx=old_state.xx;
		ns.yy=old_state.yy;
		#ns.docked_to=old_state.docked_to; # before #enter, because in the #enter methog @docket_to may be reset to nil
    
    	ns.enter(old_state.x,old_state.y);	
	
#<<<<<<< HEAD
		ns.face=old_state.face;	
		ns.start_cp=old_state.start_cp   
		@state=ns;
	end;

	def registerCheckPoint(start_cp, cp)
		#@checkPoints<<cp if @checkPoints.select{|cc| cc.xTiles==cp.xTiles && cc.yTiles==cp.yTiles}.size==0;
		if !@checkPoints.any?{|cc| cc[:xTiles]==cp[:xTiles] && cc[:yTiles]==cp[:yTiles]}
			cp[:num]=@checkPoints.size # way to invent something smarter
			@checkPoints<<cp 
			#puts @checkPoints.to_s
			@logfile.write(cp.to_s+"\n");
			puts "Checkpoint added. Total checkpoint number is #{@checkPoints.size}"
			@edges<<[start_cp, cp]
		else
			ccc=@checkPoints.select{|cc| cc[:xTiles]==cp[:xTiles] && cc[:yTiles]==cp[:yTiles]}.first
			@edges<<[start_cp, ccc]
		end;
	end;	

	#to be called from a state

	def stateCallback(oldState, param)
		return if @all_checkpoints_secured
		puts "callback called back!"
		begin
			#cpIterator.next;
			begin
				@currentCpProperty=@cpPropsIterator.next;
				puts "@currentCpProperty=#{@currentCpProperty}"
				@state.x=@currentCp[:x];
				@state.y=@currentCp[:y];
			rescue StopIteration
				#puts "Stop Operation-1"
				#getNextCheckPoint		
				@currentCp=@cpIterator.next;
				puts "Next checkpoint is "+@currentCp.to_s
				@cpPropsIterator=@currentCp[:properties].each;
				@currentCpProperty=@cpPropsIterator.next;				
			end;	
		rescue StopIteration
		 	puts "All check points are secured, total number #{@checkPoints.size}"
		 	@state.xS=@state.yS=0;
		 	@all_checkpoints_secured=true;
		 	###
		 	print_edges;
		 	###
		 	return	
		end; 
		puts "FINAL:@currentCpProperty.to_s="+@currentCpProperty.to_s
		@state.start_cp=@currentCp;
		case @currentCpProperty #.to_s
			#when "fall"
			when :fall
			then toState(@state, "fall"); 
			#when "walk_right"		
			when :walk_right		
			then toState(@state, "walk"); @state.outerControl {|state| state.xS=70}	
			#when "walk_left"		
			when :walk_left		
			then toState(@state, "walk"); @state.outerControl {|state| state.xS=-70}
			when :climb_down
			then toState(@state, "climb"); @state.outerControl {|state| state.yS=70}

		end;
		#@state.outerControl {|state| state.x=@currentCp[:x]; state.y=@currentCp[:y];}	
		@state.x=@currentCp[:x]; 
		@state.y=@currentCp[:y];	
	end;	

	def build_graph

	end;
		
	def print_edges
		@edges.each do |e|
			#puts "#{e[0]} - #{e[1]}"
			puts "#{e[0][:num]} - #{e[1][:num]}"
		end;	
	end;	

alias next_checkpoint stateCallback
#=======
#		ns.face=old_state.face;	   
#		@state=ns;
#	end;

#	def registerCheckPoint(cp)
#		#@checkPoints<<cp if @checkPoints.select{|cc| cc.xTiles==cp.xTiles && cc.yTiles==cp.yTiles}.size==0;
#		@checkPoints<<cp if !@checkPoints.any?{|cc| cc[:xTiles]==cp[:xTiles] && cc[:yTiles]==cp[:yTiles]};
#		puts @checkPoints.to_s
#		@logfile.write(cp.to_s);
#	end;	

#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	# def registerCheckPoint(cp)
	# 	cc=@checkPoints.select{|c| c.x==cp.x && c.y==cp.y}
	# 	if cc.size==0
	# 		@checkPoints<<cp
	# 	else
	# 		mergeCheckPoint(cc,cp)
	# 	end;	
	# end;

	# def mergeCheckPoint(cc, cp)
	# 	cc.each do |c|
	# 		c[:properties].remove(:walk_left) if !cp[:properties].include?(:walk_left)			
	# 		c[:properties].remove(:walk_right) if !cp[:properties].include?(:walk_right)
	# 	end;	
	# end;	
end;