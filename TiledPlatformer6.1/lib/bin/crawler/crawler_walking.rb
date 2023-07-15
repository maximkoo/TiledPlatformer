class CrawlerWalking<PlayerState
#<<<<<<< HEAD
	attr_accessor :start_cp
#=======
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
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
#<<<<<<< HEAD
		@detectorListeners<<IsLadderDownListener.new(self, :onLadderDown); 
#=======
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	end;

	def enter(x,y)
		puts "--- Crawler Walking! ---"
		@x,@y=x,y
		@yS=0;
#<<<<<<< HEAD
			@xS=7;
#=======
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
		@detector.reset(x,y)
	end;

	def update
		super
#<<<<<<< HEAD
		@detector.update
#=======
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	end;

	def img
		@img[0]
	end;	

	def onNoFloor
		cp={x:@x, y:@y, xTiles:@x/TILE_SIZE, yTiles:(@y+@h-1)/TILE_SIZE, properties:[]}
		cp[:properties]<<:fall
#<<<<<<< HEAD
		@master.registerCheckPoint(@start_cp, cp);		
		#@master.toState(self, "fall");
		puts "Walking detects NO GROUND!"
		@master.stateCallback(self, nil);		
#=======
		@master.registerCheckPoint(cp);		
		#@master.toState(self, "fall");
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	end;	

	def onWallLeft
		cp={x:@x, y:@y, xTiles:@x/TILE_SIZE, yTiles:(@y+@h-1)/TILE_SIZE, properties:[]}
		cp[:properties]<<:climb if @properties[:hasLadder]
		cp[:properties]<<:climb_down if @properties[:hasLadderDown]
		cp[:properties]<<:walk_right
#<<<<<<< HEAD
		@master.registerCheckPoint(@start_cp, cp);	
		@master.stateCallback(self, nil);			
#=======
#		@master.registerCheckPoint(cp);				
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	end;

	def onWallRight
		cp={x:@x, y:@y, xTiles:@x/TILE_SIZE, yTiles:(@y+@h-1)/TILE_SIZE, properties:[]}
		cp[:properties]<<:climb if @properties[:hasLadder]
		cp[:properties]<<:climb_down if @properties[:hasLadderDown]
		cp[:properties]<<:walk_left
#<<<<<<< HEAD
		@master.registerCheckPoint(@start_cp, cp);
		@master.stateCallback(self, nil);
#=======
#		@master.registerCheckPoint(cp);
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
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
#<<<<<<< HEAD
		#cp[:properties]<<:climb if @properties[:hasLadder]
		cp[:properties]<<:climb_down 
		cp[:properties]<<:walk_left if !@properties[:hasWallLeft]
		cp[:properties]<<:walk_right if !@properties[:hasWallRight]
		@master.registerCheckPoint(@start_cp, cp);
		@master.stateCallback(self, nil);
#=======
#		cp[:properties]<<:climb if @properties[:hasLadder]
#		cp[:properties]<<:climb_down 
#		cp[:properties]<<:walk_left if !@properties[:hasWallLeft]
#		cp[:properties]<<:walk_right if !@properties[:hasWallRight]
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	end;	
end;