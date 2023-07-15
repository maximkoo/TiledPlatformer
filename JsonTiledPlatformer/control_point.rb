require './movable.rb'
require './component.rb'
class ControlPoint<Component
	include Movable
	#attr_accessor :x,:y,:w,:h, :prevX, :prevY
	def initialize(master,x,y)
		super(master)
		@x,@y=x,y
		@w=@h=0
		@xS,@yS=master.xS,master.yS
	end;

	def update
		move 
	end;
	
	def draw

	end;	
end;		
