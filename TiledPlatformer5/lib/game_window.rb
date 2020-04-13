require 'gosu'
require 'pathname'
require '../../../Gosu_TiledMap/Shortsplice/lib/tiled_map.rb'  
#require 'gosu_tiled'
require './bin/constants.rb'
#require './Override/layer_override.rb'
#require './bin/movable_game_object.rb'
#require './bin/map_object.rb'
require './bin/object_pool.rb'
require './bin/player.rb'


class GameWindow<Gosu::Window
  attr_accessor :viewport_width, :viewport_height, :viewport_offset_x, :viewport_offset_y
  	def initialize
	    super 980,980, false
	    #$map = Gosu::Tiled.load_json(self, MAP_FILE)
      p=File.join(File.dirname($0),'assets','maps')
      abort "Incorrect path in run.rb" if !Pathname.new(p).exist?
      $map=Gosu_TiledMap::TiledMap.new(p,"LongerMap2.json", 980, 980)
	    
	    #$map_width=$map.width
	    #$map_height=$map_height

#	    $viewport_x=0
#	    $viewport_y=0
#	    $viewport_width=980
#	    $viewport_height=980
#	    $viewport_offset_x=0
#	    $viewport_offset_y=0

      @player=Player.new($map.layer_x, 280,70);
      puts @player.master.name
	    @objectPool=ObjectPool.new(self);
	    #@player=Player.new(@objectPool, 750,80);
#	    @player=Player.new(@objectPool, 280,70);
  	end;

  	def draw
      $map.draw
      #$map.draw  ;
      #@player.draw; # Player is an objects of Layer_X, so it redraws in $map.draw
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


