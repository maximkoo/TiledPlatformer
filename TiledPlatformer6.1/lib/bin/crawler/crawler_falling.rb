class CrawlerFalling<PlayerState
<<<<<<< HEAD
	attr_accessor :start_cp
	def initialize(master, x,y)
		super(master,x,y)
		@xS=0; 
		#@yS=TILE_SIZE;
		@yS=10;
		
=======
	def initialize(master, x,y)
		super(master,x,y)
		@xS=0; 
		@yS=TILE_SIZE;

>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
		@img=Gosu::Image.load_tiles(CRAWLER_FILE, 210/3,94);
		@w,@h=img.width,img.height;
		@collider=CommonCollider.new(self,x,y)
		@listeners<<HitAFloorListener.new(self, :onHitAFloor); 
		@detector=CommonDetector.new(self,x,y);
<<<<<<< HEAD
		#@detectorListeners<<IsWallLeftListener.new(self, :onWallLeft); 
		#@detectorListeners<<IsWallRightListener.new(self, :onWallRight); 
=======
		@detectorListeners<<IsWallLeftListener.new(self, :onWallLeft); 
		@detectorListeners<<IsWallRightListener.new(self, :onWallRight); 
>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	end;

	#def draw

	#end;	

	def update
		super
		@collider.update
		@detector.update
	end;	

	def enter(x,y)
		puts "--- Crawler Falling! ---"
		@x,@y=x,y
		@xS=0;
		@yS=TILE_SIZE;
    	centerOnTileX(@x,@y)
		#@detector.reset(x,y)
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
<<<<<<< HEAD
		@master.registerCheckPoint(@start_cp, cp);
		@yS=0;
		puts "HIT A FLOOR!! #{@x} #{@y+h-1}"		
		# state doesn'r change itself
		#@master.toState(self,"walk");
		#it calls master's callback method
		puts @x,@y+@h
		@master.stateCallback(self, nil);
=======
		@master.registerCheckPoint(cp);
		#puts "to WALK!! #{@x} #{@y+h-1}"		
		@master.toState(self,"walk");
>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	end;	

	def onWallLeft

	end;	

	def onWallLeft

	end;	
end;