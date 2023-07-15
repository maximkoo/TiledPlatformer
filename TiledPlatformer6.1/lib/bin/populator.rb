class Populator
def initialize
	yield(self) if block_given?;
end;

def populate
	#@player=Player.new($map.layer_x, DATA_PLAYER);
    @crawler=Crawler.new($map.layer_x, DATA_CRAWLER);
end;

def set_borders
		return if $cyclic
		Gosu_TiledMap::EmptyObject.new($map.layer_x, {"id"=>20001,
                                                    "height"=>980,
                                                    "width"=>70,
                                                    "name"=>"BorderLeft",
                                                    "rotation"=>0,
                                                    "type"=>"Obstacle",
                                                    "visible"=>true,
                                                    "x"=>-70,
                                                    "y"=>0});
      	Gosu_TiledMap::EmptyObject.new($map.layer_x, {"id"=>20002,
                                                    "height"=>980,
                                                    "width"=>70,
                                                    "name"=>"BorderRight",
                                                    "rotation"=>0,
                                                    "type"=>"Obstacle",
                                                    "visible"=>true,
                                                    "x"=>980*2,
                                                    "y"=>0});
end;

end;