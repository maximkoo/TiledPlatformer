require 'gosu'
require 'pathname'
require '../../../Gosu_TiledMap/Shortsplice/lib/tiled_map.rb'  
require './bin/constants.rb'
require './bin/object_pool.rb'
require './bin/player/player.rb'


class GameWindow<Gosu::Window
  attr_accessor :viewport_width, :viewport_height, :viewport_offset_x, :viewport_offset_y
  	def initialize
	    super 980,980, false
	    #$map = Gosu::Tiled.load_json(self, MAP_FILE)
      p=File.join(File.dirname($0),'assets','maps')
      abort "Incorrect path in run.rb" if !Pathname.new(p).exist?
      $map=Gosu_TiledMap::TiledMap.new(p,"LongerMap3.json", 980, 980)

      @player=Player.new($map.layer_x, Player::data_player);
      # puts @player.master.name;	    
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
      @objectPool=ObjectPool.new(self);	                                           
  	end;

  	def draw
      $map.draw
  	end

  	def needs_cursor?
    	true
  	end

  	def update  
		now=Gosu.milliseconds
		return if (now-@last_update||=now) < FRAME_DELAY 
		#@objectPool.objects.map(&:update);
		@objectPool.update;
		#@player.update;
		@last_update=now;
	end;
end;

$g=GameWindow.new
$g.show


