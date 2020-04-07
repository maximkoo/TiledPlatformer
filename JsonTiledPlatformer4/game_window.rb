require 'gosu'
require 'gosu_tiled'
require './images.rb'
require './Override/layer_override.rb'
require './MovableGameObject.rb'

class C1<Gosu::Window
  def initialize
    super 980,980, false
    $map = Gosu::Tiled.load_json(self, MAP_FILE)
    
    #$m=@map
    json=JSON.parse(File.read(MAP_FILE));
    #$map_width=json["width"]
    #$map_height=json["height"]
    $map_width=$map.width
    $map_height=$map_height

    $viewport_x=0
    $viewport_y=0
    $viewport_width=980
    $viewport_height=980
    @viewport_offset_x=0

    # f=File.join(File.dirname(__FILE__), '/map.txt');
    # ff=File.open(f,"w")
    # ff.write($map.inspect);
    # ff.close

    # f=File.join(File.dirname(__FILE__), '/map_layers.txt');
    # ff=File.open(f,"w")
    # ff.write($map.layers.object.inspect);
    # ff.close

    @map_objects=[]
     $map.layers.object.each do |object_layer|
        object_layer.data["objects"].each do |obj|
            puts obj.to_s
            @map_objects<<MapObject.new(obj["x"],obj["y"]) do |mo|
              mo.w=obj["width"];
              mo.h=obj["height"] 
              mo.name=obj["name"] 
              mo.type=obj["type"]  
              mo.xS=0
              mo.yS=-2;  
              mo.layer=object_layer.data["name"]     
              #puts mo.inspect
            end;  
        end;  
     end;
     #puts @map_objects.to_s
  end
  
  def draw
      $map.draw(@viewport_offset_x,0)
  end
  
  def needs_cursor?
    true
  end

  def update
    keyControl();
	  now=Gosu.milliseconds
	  return if (now-@last_update||=now) < FRAME_DELAY 
	  #@objectPool.objects.map(&:update);
	  #@player.update;
    @map_objects.select{|c| c.type=="Platform"}.each do |obj|
      obj.update;
    end;  
	  @last_update=now;
  end; 

  def keyControl
    if button_down?(Gosu::KbLeft)      
      @viewport_offset_x-=TILE_SIZE/7 unless @viewport_offset_x<=0
    end;
    if button_down?(Gosu::KbRight)
      @viewport_offset_x+=TILE_SIZE/7 unless @viewport_offset_x+$viewport_width>=$map_width
    end;

  if button_down?(Gosu::KB_D)
    $map.layers.object.each do |object_layer|
        object_layer.data["objects"].select{|c| c["name"]="Stone1"}.first["x"]+=TILE_SIZE/7
    end;
   end; 

   if button_down?(Gosu::KB_A)
    $map.layers.object.each do |object_layer|
        object_layer.data["objects"].select{|c| c["name"]="Stone1"}.first["x"]-=TILE_SIZE/7
    end;
   end; 

  end;

  # def getMapObjects(json)
  #   json['layers'].select{|x| x["name"]=~/ObjectLayer/}.each do |x|
  #     x['objects'].select{|xx| xx["visible"]==true }.each do |xx|
  #       case xx["type"]
  #         when OBSTACLE then qq=@obstacles#@grounds
  #         when LADDER then qq=@ladders
  #         else qq=nil
  #       end;  
  #       if qq
  #         qq<<Rectangle.new( xx["x"],xx["y"],xx["width"],xx["height"]);
  #         qq.last.rectangle_name=xx["name"];
  #         qq.last.rectangle_type=xx["type"];
  #       end;
  #     end;
  #   end;     
  # end;

end;      

$g=C1.new
$g.show