class ObjectPool
    attr_accessor :objects, :master
    def initialize(master) # Game Window is the master
        @master=master
        @objects=[]
        #@map_objects=[]
        #getMapObjects # obsolete now
        @objects=$map.get_all_objects();
        puts "Object count is #{@objects.size}"
        @objects.each {|z| puts "#{z.name} : #{z.master.name}" };
    end;

    def getMapObjects
        $map.layers.object.each do |object_layer|
            object_layer.data["objects"].each do |obj|
                #puts obj.to_s
                if obj["gid"]
                    h=obj["y"]-obj["height"];
                else
                    h=obj["y"];
                end;    
                @objects<<MapObject.new(self, obj["x"],h) do |mo|
                    mo.w=obj["width"];
                    mo.h=obj["height"] 
                    mo.name=obj["name"] 
                    mo.type=obj["type"]  
                    mo.xS=0
                    mo.yS=0;  
                    mo.layer=object_layer.data["name"]   
                    mo.visible=obj["visible"]  
                    #puts mo.inspect
                end;
        end;  
        end;
    end;

    # def objectsByPoint(x,y)
    #     arr=@obstacles+@ladders;
    #     res=[]
    #     arr.each do |a| 
    #         if (x.between?(a.x1,a.x2-1) && y.between?(a.y1,a.y2-1)) 
    #             res<<a.rectangle_type;
    #         end;  
    #     end;  
    #     res
    # end;
    def update
        @objects.map(&:update);
    end;    

    def objectsByPoint(x,y)
        res=[]
        @objects.each do |obj|
            if (x.between?(obj.x1,obj.x2-1) && y.between?(obj.y1,obj.y2-1)) 
                #begin
                    res<<obj.type if !obj.type.nil?;
                #rescue NameError => e
                #    puts obj.class
                #end;    
            end;    
            
        end;
        res
    end;        
end;    