require './ColliderCore.rb'
class Rectangle
	attr_accessor :x,:y,:w,:h
	def initialize(x,y,w,h)
		@x,@y=x,y
		@w,@h=w,h
	end;
	
	def x1
		@x;
	end;
	
	def x2
		@x+@w-1;
	end;
	
	def y1
		@y
	end;
	
	def y2
		@y+@h-1
	end;
end;

class MovableGameObject<Rectangle
	attr_accessor :x,:y,:xS,:yS, :prevX, :prevY
	def initialize(x,y)			
		@x,@y=x,y
		@prevX,@prevY=x,y
		@xS,@yS=0,0
		if block_given?
			yield self
		end;	
	end;

	def move
		@prevX=@x;
    	@prevY=@y;
    	@x+=@xS;
    	@y+=@yS;
	end;
end;

class Player<MovableGameObject
end;

class MapObject<MovableGameObject
	attr_accessor :name,:type,:visible,:enabled,:layer
	def initialize(x,y)
		super(x,y)
		@q=Proc.new do |this|
			if this.x>300 || this.x<0
				this.xS=-1*this.xS
				#puts "#{this.name} reverse"
			end;

			this.move
		end;	

		@qq=Proc.new do |this|
			if this.y<420 || this.y>840
				this.yS=-1*this.yS
				#puts "#{this.name} reverse"
			end;

			this.move
		end;	
	end;

	def setX(a)
		@x=a;
		$map.layers.object.each do |object_layer|
			object_layer.data["objects"].select{|c| c["name"]==@name}.each do |obj|
				obj["x"]=a
			end;	
		end;
	end;

	def setY(a)	
		@y=a;
		$map.layers.object.each do |object_layer|
			object_layer.data["objects"].select{|c| c["name"]==@name}.each do |obj|
				obj["y"]=a
			end;	
		end;
	end;

	def move
		super
		setX(@x+@xS);
		setY(@y+@yS)
	end;	
	
	def update
		@qq.call(self)
	end;	
end;	
