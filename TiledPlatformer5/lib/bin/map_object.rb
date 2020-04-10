class MapObject<MovableGameObject
	attr_accessor :name,:type,:visible,:enabled,:layer
	def initialize(master,x,y)
		super(master,x,y);
	end;

	def move
		super
		#setX(@x+@xS);
		#setY(@y+@yS)
	end;	
	
	def update		
		return unless [VIRTUAL, PLATFORM].include? @type 
		#@qq.call(self)
	end;

	def disappear
		@visible=false;
		$map.layers.object.each do |object_layer|
            object_layer.data["objects"].select {|c| c["name"]==@name}.each do |obj|
            	# puts "#{obj['name']}"
            	puts "#{obj['name']} disappears!"
            	obj["visible"]=false;
            end;
        end;    	
	end;

	def appear
		@visible=true;
	end;	

	def visible?
		@visible
	end;		
end;