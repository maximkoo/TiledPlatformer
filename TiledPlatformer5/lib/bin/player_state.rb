#require '../../../Gosu_TiledMap/Shortsplice/lib/movable_game_object.rb'
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

	def move
		super
		#puts @master.master.master.class
		# if (@x>@master.master.master.viewport_width/2)
		# 	@master.master.master.viewport_offset_x=@x-@master.master.master.viewport_width/2
		# else
		# 	@master.master.master.viewport_offset_x=0;
		# end;	
		# @xV=@x-@master.master.master.viewport_offset_x #Game Window
		# @yV=@y
	end;	
end;	

