class CrawlerClimbing<PlayerState
	attr_accessor :start_cp
	def initialize(master, x,y)
		super(master,x,y)
		@xS=0; #TILE_SIZE; 
		@yS=0;

		@img=Gosu::Image.load_tiles(CRAWLER_FILE, 210/3,94);
		@w,@h=img.width,img.height;
		@collider=CommonCollider.new(self,x,y)
		@listeners<<HitAFloorListener.new(self, :onHitAFloor); 
		@detector=CommonDetector.new(self,x,y);
		#@detectorListeners<<IsNoFloorListener.new(self, :onNoFloor); 
		#@detectorListeners<<IsWallLeftListener.new(self, :onWallLeft); 
		#@detectorListeners<<IsWallRightListener.new(self, :onWallRight); 
		@detectorListeners<<IsNoLadderListener.new(self, :onNoLadder); 
	end;

	def enter(x,y)
		puts "--- Crawler Walking! ---"
		@x,@y=x,y
		@yS=0;
			@xS=7;
		@detector.reset(x,y)
	end;

	def update
		super
		@collider.update
		@detector.update
	end;

	def img
		@img[0]
	end;

	def onHitAFloor
		cp={x:@x, y:@y, xTiles:@x/TILE_SIZE, yTiles:(@y+@h-1)/TILE_SIZE, properties:[]}
		cp[:properties]<<:walk_left if !@properties[:hasWallLeft];
		cp[:properties]<<:walk_right if !@properties[:hasWallRight];
		cp[:properties]<<:climb if @properties[:hasLadder];
		cp[:properties]<<:climbDown if @properties[:hasLadderDown];
		@master.registerCheckPoint(@start_cp, cp);
		@yS=0;
		puts "HIT A FLOOR!! #{@x} #{@y+h-1}"		
		# state doesn'r change itself
		#@master.toState(self,"walk");
		#it calls master's callback method
		puts @x,@y+@h
		@master.stateCallback(self, nil);
	end;	

	def onNoLadder
		cp={x:@x, y:@y, xTiles:@x/TILE_SIZE, yTiles:(@y+@h-1)/TILE_SIZE, properties:[]}
		cp[:properties]<<:walk_left if !@properties[:hasWallLeft];
		cp[:properties]<<:walk_right if !@properties[:hasWallRight];
		cp[:properties]<<:climbDown if @properties[:hasLadderDown];
		@master.registerCheckPoint(@start_cp, cp);
		@yS=0;
		puts "NO LADDER!!1 #{@x} #{@y+h-1}"
		@master.stateCallback(self, nil);
	end;	
end;	