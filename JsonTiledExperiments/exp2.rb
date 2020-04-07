require 'json'
require 'gosu'

OBJECTLAYER="objectgroup"
TILELAYER="tilelayer"
TILESIZE=70

#map=JSON.parse(File.read('c:\Users\max\Ruby\JsonTiledPlatformer4.1\assets\maps\LongerMap.json'));
MAP=JSON.parse(File.read('./exp2.json'))
# $map["layers"].each do |layer|
# 	puts layer["name"];
# end;

class TiledMap	
	attr_reader :height,:width, :layers, :tilesets  #:tilelayers, :objectlayers

	def initialize(json)
		puts "Can not process infinite maps" if json["infinite"]=="true"
		@height=json["height"]
		@width=json["width"]
		@tilewidth=json["tilewidth"]
		@tileheight=json["tileheight"]

		#@tilelayers=[]
		#@objectlayers=[]
		@layers=[]
		@tilesets=[]

		json["layers"].each do |layer_data|
			if layer_data["type"]==TILELAYER
				TileLayer.new(self, layer_data);
			elsif layer_data["type"]==OBJECTLAYER
				ObjectLayer.new(self, layer_data);
			end;	
		end;	

		json["tilesets"].each do |tileset_data|
			Tileset.new(self, tileset_data);
		end;	
	end;

	def all_objects
		#return all objects from all layers
	end;	

	def getTilesetByGid(n)
		@tilesets.select{|t| n.between?(t.firstgid, t.lastgid)}.first
	end;	

	def getTileByGid(gid)
		tileset=getTilesetByGid(gid)
		#puts "GID=#{gid}"
		local_id=gid-tileset.firstgid;
		tileset.getTileByLocalId(local_id)
	end;

	def draw
		#puts "@Layers length is #{@layers.size}"
		@layers.each do |layer|
			layer.draw;
		end;	
	end;
end;

class AbstractLayer
	def initialize(master, data)
		@master=master;
		#@id=data["id"]
		@data=data["data"]
		@name=data["name"]
		@type=data["type"]
		@visible=data["visible"]		  
		@x,@y=data["x"],data["y"]
		@width,@height=data["width"],data["height"]
		master.layers<<self;
	end;
		
end;	

class TileLayer<AbstractLayer
	def initialize(master,data)
		super(master,data)
		@data=data["data"]
		puts "Layer created"
		@iter=0
	end;	

	def draw
		x,y=@x,@y;		# the layer offset		
		#@iter==0 and puts  
		#@iter==0 and puts "#{@name} is drawing"
		(0..@height-1).each do |i|
			(0..@width-1).each do |j|
				gid=@data[i*@width+j]
				if gid!=0 
					tile=@master.getTileByGid(gid);
					#@iter==0 and print @data[i*@width+j].to_s<<','
					###					
					#@iter==0 and puts j*tile.width, i*tile.height
					tile.draw(j*tile.width, i*tile.height,10,1,1)
					###
				end;	
			end;	
		end;	
		@iter+=1
	end;		
end;

class ObjectLayer<AbstractLayer
	attr_accessor :objects
	def initialize(master,data)
		super(master,data)
		#@objects=data["objects"]
	end;

	def draw

	end;   	
end;

class AbstractObject
	attr_accessor :layer
	def initialize(layer)
		@layer=layer
		@layer.objects<<self
	end;
end;	

class EmptyObject<AbstractObject

end;	

class TiledObject<AbstractObject

end;

class Tileset
	attr_reader :firstgid, :lastgid	
	def initialize(master, data)
		@firstgid=data["firstgid"]
		@tilecount=data["tilecount"]
		@lastgid=@firstgid+@tilecount-1
		@columns=data["columns"]
		
		@tileheight=data["tileheight"]
		@tilewidth=data["tilewidth"]
		path=''
			#path='c:\/Users\/max\/Ruby\/JsonTiledPlatformer4.1\/assets\/maps\/'
		@tiles=Gosu::Image.load_tiles(path+data["image"], data["tilewidth"], data["tileheight"],{tileable:true});
		master.tilesets<<self;
	end;

	def getTileByLocalId(id)
		@tiles[id]
	end;	

	def getTileByTilesetAndId

	end;

end;	


class G1<Gosu::Window
	def initialize
		super 700,700, false  
		@tm=TiledMap.new(MAP)
	end;

	def draw
		@tm.draw
	end;
end;

g1=G1.new
g1.show;		