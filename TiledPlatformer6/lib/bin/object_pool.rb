class ObjectPool
    attr_accessor :objects, :master
    def initialize(master) # Game Window is the master
        @master=master
        @objects=[]
        #@map_objects=[]
        #getMapObjects # obsolete now
        @objects=$map.get_all_objects();
        puts "Object count is #{@objects.size}"
        #@objects.each {|z| puts "#{z.name} : #{z.master.name}" };
    end;

    def update
        @objects.map(&:update);
    end;           
end;    