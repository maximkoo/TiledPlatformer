class PlayerState<Gosu_TiledMap::MovableGameObject
	attr_accessor :face
	def initialize(master,x,y)
		super(master,x,y)
		@face="right"
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
		#puts "x=#{@x}"
		#puts "@x+@w/2=#{@x+@w/2}"
		#puts "(@x+@w/2)/TILE_SIZE=#{(@x+@w)/TILE_SIZE}"  
		@x=(@x+@w/2)/TILE_SIZE * TILE_SIZE
	end;
		
	def centerOnTileY(x,y)	
		
	end;

	def centerOnTileXY(x,y)	
		centerOnTileX(x,y)
		centerOnTileY(x,y)
	end
end;	

