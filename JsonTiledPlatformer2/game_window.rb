require 'json'
require 'gosu'
require 'gosu_tiled'
require './images.rb'
require './movable_game_object.rb'
require './player.rb'
require './player_state.rb'
#require './collider.rb'
#require './animator.rb'
require './rectangle.rb'
require './nps.rb'


class C1<Gosu::Window
  def initialize
    super 980,980, false
    $map = Gosu::Tiled.load_json(self, MAP_FILE)
    
    $m=@map
    json=JSON.parse(File.read(MAP_FILE));
    $map_width=json["width"]
    $map_height=json["height"]
    @objectPool=ObjectPool.new(json);
    #$collider=Collider.new(json);
    @player=Player.new(@objectPool, 750,80);
  end
  
  def draw
    $map.draw(0,0)
    @player.draw;
    @objectPool.nps.each do |n|
      n.draw;
     end; 
  end
  
  def needs_cursor?
    true
  end

  def update
	  now=Gosu.milliseconds
	  return if (now-@last_update||=now) < FRAME_DELAY 
	  @objectPool.objects.map(&:update);
	  #@player.update;
	  @last_update=now;
  end;
end;  

class ObjectPool
    attr_accessor :objects, :obstacles, :ladders, :nps
    def initialize(json)
        @objects=[]        
        @obstacles=[]
        @ladders=[]        
        @nps=[]
        getMapObjects(json)
        #@nps=Nps.new(self,70,70);
        getNPS(json)
    end;

    def getMapObjects(json)
    json['layers'].select{|x| x["name"]=~/ObjectLayer/}.each do |x|
      x['objects'].select{|xx| xx["visible"]==true }.each do |xx|
        case xx["type"]
          when OBSTACLE then qq=@obstacles#@grounds
          when LADDER then qq=@ladders
          else qq=nil
        end;  
        if qq
          qq<<Rectangle.new( xx["x"],xx["y"],xx["width"],xx["height"]);
          qq.last.rectangle_name=xx["name"];
          qq.last.rectangle_type=xx["type"];
        end;
      end;
     
    end;     
  end;

  def getNPS(json)
    #json['layers'].select{|x| x["name"]=~/ObjectLayer/}.each do |x|
      json["tilesets"].each do |tileset|
        firstgid=tileset["firstgid"]
        if !tileset["tiles"].nil?
        tileset["tiles"].each do |tile|
            nps_tile={}
            puts tile["id"]
            nps_tile["id"]=tile["id"]+firstgid
            nps_tile["durations"]=[]
            nps_tile["tileids"]=[]
            nps_tile["animation"]=[]
            tile["animation"].each do |anim_pos|
              nps_tile["tileids"]<<(anim_pos["tileid"]+firstgid)
              nps_tile["durations"]<<anim_pos["duration"]
              nps_tile["animation"]<<$map.tilesets.get(anim_pos["tileid"]+firstgid);
            end;   
         
          # Надо пройти по всем слоям и найти тайлы с таким же ИД 
          # на каждую анимацию может быть несколько объектов
          layer_data=json["layers"].select{|l| l["name"]=="TileLayer2"}[0]["data"]        
#          puts "nps.tileID=#{nps_tile["id"]}"
          cidx=layer_data.each_index.select{|i| layer_data[i]==nps_tile["id"]}
 #         puts "cidx=#{cidx.to_s}"
          cidx.each do |c|
            nps=Nps.new(self, 0,0);
            nps.tileids=nps_tile["tileids"]
            nps.durations=nps_tile["durations"]
            nps.animation=nps_tile["animation"]
            nps.x=(c % $map_width)*TILE_SIZE
            nps.y=(c.fdiv($map_width).floor)*TILE_SIZE
            @nps<<nps;
          end;  
         end;
        end;  
      end;  
   # end;
   puts @nps[0].x
  end;  

  def objectsByPoint(x,y)
    arr=@obstacles+@ladders;
    res=[]
    arr.each do |a| 
      if (x.between?(a.x1,a.x2-1) && y.between?(a.y1,a.y2-1)) 
        res<<a.rectangle_type;
      end;  
    end;  
    res
  end;

end;  

$g=C1.new
$g.show