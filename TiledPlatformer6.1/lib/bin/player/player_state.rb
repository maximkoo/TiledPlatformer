require_relative '../components/listeners/collider_listeners.rb';
require_relative '../components/listeners/detector_listeners.rb';

class PlayerState<Gosu_TiledMap::MovableGameObject
#<<<<<<< HEAD
	attr_accessor :face, 
	              :listeners, 
	              :detectorListeners,
	              :criticalContact,
	              :properties
#=======
#	attr_accessor :face, :listeners, :criticalContact,:detectorListeners
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	def initialize(master,x,y)
		super(master,x,y)
		@face="right"
		@listeners=[]
		@detectorListeners=[]
		@criticalContact=false;
		@properties={hasFloor:nil,
#<<<<<<< HEAD
				     hasWallLeft:nil,
					 hasWallRight:nil,
					 hasLadder:nil,
					 hasLadderDown:nil}
#=======
#				    hasWallLeft:nil,
#					hasWallRight:nil,
#					hasLadder:nil,
#					hasLadderDown:nil}
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	end;

	def enter(x,y)

	end;

	def leave(x,y)

	end;

	def keyControl

	end;

#<<<<<<< HEAD
	def outerControl
		yield self
	end;	

#=======
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
	def img

	end;	

	#def move
    def update
		super
	end;	
  
  def centerOnTileX(x,y)	
		@x=(@x+@w/2)/TILE_SIZE * TILE_SIZE
	end;
		
	def centerOnTileY(x,y)	
		
	end;

	def centerOnTileXY(x,y)	
		centerOnTileX(x,y)
		centerOnTileY(x,y)
	end
end;	

