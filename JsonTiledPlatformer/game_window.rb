require 'json'
require 'gosu'
require 'gosu_tiled'
require './player.rb'
require './collider.rb'
require './animator.rb'
require './rectangle.rb'

  MAP_FILE = File.join(File.dirname(__FILE__), 'ArtPackMap70.json')
  FRAME_DELAY=16 

class C1<Gosu::Window
  def initialize
    super 980,980, false
    @map = Gosu::Tiled.load_json(self, MAP_FILE)
    json=JSON.parse(File.read(MAP_FILE));
    #super @map.width, @map.height, false
    @x = @y = 0
    #$collider=Collider.new;
    $collider=Collider.new(json);
    @player=Player.new(100,200);

    #@q=@map.tilesets.get(172);
    #$animator=Animator.new(json);

  end
  
  def draw
    @map.draw(@x,@y)
    @player.draw;
    #@q.draw(10,10,10);
  end
  
  def needs_cursor?
    true
  end

  def update
	now=Gosu.milliseconds
	return if (now-@last_update||=now) < FRAME_DELAY 
	#@objectPool.objects.map(&:update);

	@player.update;

	@last_update=now;
end;
end;  

C1.new.show