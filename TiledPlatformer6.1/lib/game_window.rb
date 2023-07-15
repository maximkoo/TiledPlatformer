require 'gosu'
require 'pathname'
require '../../../Gosu_TiledMap/Shortsplice/lib/tiled_map.rb'  
require './bin/constants.rb'
require './bin/object_pool.rb'
require './bin/player/player.rb'
require './bin/crawler/crawler.rb'
#<<<<<<< HEAD
require './bin/populator.rb'
#=======
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe

class GameWindow<Gosu::Window
  attr_accessor :viewport_width, :viewport_height, :viewport_offset_x, :viewport_offset_y
  	def initialize
	    super 980,980, false
      p=File.join(File.dirname($0),'assets','maps')
      abort "Incorrect path in run.rb" if !Pathname.new(p).exist?
#<<<<<<< HEAD
      #$map=Gosu_TiledMap::TiledMap.new(p,"LongerMap3.json", 980, 980)
      #$map=Gosu_TiledMap::TiledMap.new(p,"test6.json", 980, 980)
      $map=Gosu_TiledMap::TiledMap.new(p,"cyclic.json", 980, 980)

      Populator.new do |p|
        p.populate; # creates Player, Crawler and Opponent objects
        p.set_borders; # creates left and right map borders
      end;  
      
#=======
      # $map=Gosu_TiledMap::TiledMap.new(p,"LongerMap3.json", 980, 980)

      # @player=Player.new($map.layer_x, DATA_PLAYER);
      # @crawler=Crawler.new($map.layer_x, DATA_CRAWLER);
      # # puts @player.master.name;	    
      # Gosu_TiledMap::EmptyObject.new($map.layer_x, {"id"=>20001,
      #                                               "height"=>980,
      #                                               "width"=>70,
      #                                               "name"=>"BorderLeft",
      #                                               "rotation"=>0,
      #                                               "type"=>"Obstacle",
      #                                               "visible"=>true,
      #                                               "x"=>-70,
      #                                               "y"=>0});
      # Gosu_TiledMap::EmptyObject.new($map.layer_x, {"id"=>20002,
      #                                               "height"=>980,
      #                                               "width"=>70,
      #                                               "name"=>"BorderRight",
      #                                               "rotation"=>0,
      #                                               "type"=>"Obstacle",
      #                                               "visible"=>true,
      #                                               "x"=>980*2,
      #                                               "y"=>0});
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
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


