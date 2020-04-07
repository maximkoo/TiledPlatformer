require './movable_game_object.rb'
class PlayerState<MovableGameObject
	attr_accessor :face
	def initialize(master,x,y)
		super(master,x,y)
	end;

	def enter(x,y)

	end;

	def leave(x,y)

	end;

	def keyControl

	end;
end;	