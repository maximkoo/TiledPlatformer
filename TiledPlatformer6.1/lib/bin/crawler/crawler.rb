require './bin/crawler/crawler_walking.rb'
require './bin/crawler/crawler_falling.rb'
#require './bin/crawler/crawler_jumping.rb'
#require './bin/crawler/crawler_climbing.rb'
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
		#@states["climb"]=CrawlerClimbing.new(self,x,y);

		@state=@states["fall"]
		@w,@h=@state.img.width,@state.img.height;
		@state.face="right";
	
		@checkPoints=[]
		@checkPoints<<{x:@state.x, y:@state.y, xTiles:@state.x/TILE_SIZE, yTiles:(@state.y+@h-1)/TILE_SIZE, properties:[:fall]}

		@logfile = File.open("log.txt",'w')
	end;

	def draw
		@state.draw;
	end;

	def update	
		@state.update;
    	#@master.master.set_viewport_offset(@state.x, @state.y)
	end;

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
	
		ns.face=old_state.face;	   
		@state=ns;
	end;

	def registerCheckPoint(cp)
		#@checkPoints<<cp if @checkPoints.select{|cc| cc.xTiles==cp.xTiles && cc.yTiles==cp.yTiles}.size==0;
		@checkPoints<<cp if !@checkPoints.any?{|cc| cc[:xTiles]==cp[:xTiles] && cc[:yTiles]==cp[:yTiles]};
		puts @checkPoints.to_s
		@logfile.write(cp.to_s);
	end;	

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