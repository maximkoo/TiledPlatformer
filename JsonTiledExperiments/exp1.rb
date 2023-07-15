require 'json'
require 'gosu'
require 'gosu_tiled'

	#MAP_FILE = File.join("c:","Users","kopa","Documents","Tiled","tiled1.json")
  #MAP_FILE = File.join(File.dirname(__FILE__), 'tiled1_new.json')
  #MAP_FILE = File.join(File.dirname(__FILE__), 'ArtPackMapWithTileset.json')
  #MAP_FILE = File.join(File.dirname(__FILE__), 'ArtTest.json')
  MAP_FILE = File.join(File.dirname(__FILE__), 'ArtPackMap70.json')
  FRAME_DELAY=16 

class TiledParser
	def initialize
		#@h=JSON.parse(File.read("./tiled1_new.json"));
		@h=JSON.parse(File.read("./ArtPackMap.json"));
	end;	

	def getLayers

	end;

	def getObstacles	
		obstacles=[]
		@h['layers'].select{|x| x["name"]=="ObjectLayer1"}.each do |x|
			#puts x['objects']
			x['objects'].select{|xx| xx["type"]=="Obstacle"}.each do |xx|
				obstacles<<xx;
			end;
		end;
		obstacles	 
	end;	
end;


class Player
	def initialize
		@walker=PlayerWalker.new;
		@faller==PlayerFaller.new;
		@state=@walker;
	end;

	def draw
		@state.draw;
	end;

	def toState(new_state)
		case new_state
			when "walk" then @state=@walker
			when "fall" then @state=@faller
		end;
	end;

	def update
		@state.update;
	end;	
end;	

class PlayerWalker
	def initialize
		@player_anim=Gosu::Image.load_tiles('C:\/Users\/kopa\/Documents\/Ruby\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_walk\/Player2.png', 770/11,94); 
		@img=@player_anim.first;	
	end;

	def draw
		@img.draw(100,100,10);
	end;	

	def update
	end;	
end;	

class PlayerFaller
	def initialize
		#@player_anim=Gosu::Image.load_tiles('C:\/Users\/kopa\/Documents\/Ruby\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_walk\/Player2.png', 770/11,94); 
		#@img=@player_anim.first;
		@img=Gosu::Image.new('C:\/Users\/kopa\/Documents\/Ruby\/Graphics\/Platformer Art Complete Pack\/Base pack\/Player\/p2_hurt.png')
	end;

	def draw
		@img.draw(100,100,10);
	end;	
	
	def update
	end;	
end;

class C1<Gosu::Window
  def initialize
    #super(3840, 3840, false)
    #super(896,576)
    super 980,980, false
    @map = Gosu::Tiled.load_json(self, MAP_FILE)
    #super @map.width, @map.height, false
    @x = @y = 0
    puts @map.width, @map.height;

    @player=Player.new;

  end
  
  def draw
    @map.draw(@x,@y)
    @player.draw;
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


#t=TiledParser.new;
#puts t.getObstacles


# puts ({1=>:a,"a"=>"b",100=>"242"}.keys)
# puts aaa.keys

C1.new.show