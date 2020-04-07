require './movable.rb'
class PlayerState
	include Movable
	attr_accessor :components
	def initialize(origin, x,y)
		@x,@y=x,y
		@origin=origin;
		@components=[]
	end;
end;
