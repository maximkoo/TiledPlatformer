@data=Hash.new
@data["name"]="ObjectLayer1"
@data["objects"]=[]
objs=Hash.new
objs={"gid"=>21, 
	"height"=>70, 
	"id"=>1, 
	"name"=>"Stone1", 
	"rotation"=>0, 
	"type"=>"Elevator", 
	"visible"=>true, 
	"width"=>70, 
	"x"=>0, 
	"y"=>560}
@data["objects"]<<objs

puts @data.to_s

puts @data["objects"].select{|c| c["name"]="Stone1"}

puts @data["objects"].select{|c| c["name"]="Stone1"}.first["x"]
@data["objects"].select{|c| c["name"]="Stone1"}.first["x"]=70
puts @data.to_s