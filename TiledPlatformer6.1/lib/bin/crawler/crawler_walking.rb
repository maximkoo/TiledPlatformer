class CrawlerWalking<PlayerState
	def initialize(master, x,y)
		super(master,x,y)
		@xS=0; #TILE_SIZE; 
		@yS=0;

		@img=Gosu::Image.load_tiles(CRAWLER_FILE, 210/3,94);
		@w,@h=img.width,img.height;
		#@collider=CommonCollider.new(self,x,y)
		#@listeners<<HitAWallListener.new(self, :onHitAFloor); 
		@detector=CommonDetector.new(self,x,y);
		@detectorListeners<<IsNoFloorListener.new(self, :onNoFloor); 
		@detectorListeners<<IsWallLeftListener.new(self, :onWallLeft); 
		@detectorListeners<<IsWallRightListener.new(self, :onWallRight); 
	end;

	def enter(x,y)
		puts "--- Crawler Walking! ---"
		@x,@y=x,y
		@yS=0;
		@detector.reset(x,y)
	end;

	def update
		super
	end;

	def img
		@img[0]
	end;	

	def onNoFloor
		cp={x:@x, y:@y, xTiles:@x/TILE_SIZE, yTiles:(@y+@h-1)/TILE_SIZE, properties:[]}
		cp[:properties]<<:fall
		@master.registerCheckPoint(cp);		
		#@master.toState(self, "fall");
	end;	

	def onWallLeft
		cp={x:@x, y:@y, xTiles:@x/TILE_SIZE, yTiles:(@y+@h-1)/TILE_SIZE, properties:[]}
		cp[:properties]<<:climb if @properties[:hasLadder]
		cp[:properties]<<:climb_down if @properties[:hasLadderDown]
		cp[:properties]<<:walk_right
		@master.registerCheckPoint(cp);				
	end;

	def onWallRight
		cp={x:@x, y:@y, xTiles:@x/TILE_SIZE, yTiles:(@y+@h-1)/TILE_SIZE, properties:[]}
		cp[:properties]<<:climb if @properties[:hasLadder]
		cp[:properties]<<:climb_down if @properties[:hasLadderDown]
		cp[:properties]<<:walk_left
		@master.registerCheckPoint(cp);
	end;

	def onLadderUp
		cp={x:@x, y:@y, xTiles:@x/TILE_SIZE, yTiles:(@y+@h-1)/TILE_SIZE, properties:[]}
		cp[:properties]<<:climb
		cp[:properties]<<:climb_down if @properties[:hasLadderDown]
		cp[:properties]<<:walk_left if !@properties[:hasWallLeft]
		cp[:properties]<<:walk_right if !@properties[:hasWallRight]
	end;

	def onLadderDown
		cp={x:@x, y:@y, xTiles:@x/TILE_SIZE, yTiles:(@y+@h-1)/TILE_SIZE, properties:[]}
		cp[:properties]<<:climb if @properties[:hasLadder]
		cp[:properties]<<:climb_down 
		cp[:properties]<<:walk_left if !@properties[:hasWallLeft]
		cp[:properties]<<:walk_right if !@properties[:hasWallRight]
	end;	
end;