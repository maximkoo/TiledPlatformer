require 'minitest/autorun'
require './movableGameObject.rb'
class ColliderTest < Minitest::Test

def init
	@m=Player.new(0,0)
	@m.w,@m.h=10,10;
	@m.prevX,@m.prevY=0,0
	@m.x,@m.y=0,0


	@s1=Obstacle.new(0,20)
	@s1.w,@s1.h=10,10

	@s2=Obstacle.new(10,20)
	@s2.w,@s2.h=10,10

	@collider=ColliderCore.new();
end;


def test_start_position1
	init
	a=@collider.intersect?(@m,@s1)
	assert(a==false,'Start position OK-1')
end;

def test_start_position2	
	init
	a=@collider.intersect?(@m,@s2)
	assert(a==false,'Start position OK-2')
end;	

end;
