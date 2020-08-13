require_relative '../components/listeners/listeners.rb';
require_relative '../components/listeners/detector_listeners.rb';

class PlayerState<Gosu_TiledMap::MovableGameObject
	attr_accessor :face, :listeners, :criticalContact,:detectorListeners
	def initialize(master,x,y)
		super(master,x,y)
		@face="right"
		@listeners=[]
		@detectorListeners=[]
		@criticalContact=false;
	end;

	def enter(x,y)

	end;

	def leave(x,y)

	end;

	def keyControl

	end;

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

