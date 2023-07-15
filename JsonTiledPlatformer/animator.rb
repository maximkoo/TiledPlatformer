class Animator
	def initialize(json)
		get_animations(json);

	end;

	def get_animations(json)
		#h["tilesets"]["tiles"]["animation"].each do |a|
		json["tilesets"].each do |t|
			firstgid=t["firstgid"]
			if !t["tiles"].nil? 
				t["tiles"].each do |tt|
					puts tt["id"]
					puts tt["id"]+firstgid
					tt["animation"].each do |a|
						puts a;
					end;
				end;
			end;
		end;

		json["layers"].each do |l|
			puts "Layer: #{l["id"]}";
			if l["type"]=="tilelayer"
				##puts "Index: #{l["data"].index("172")}";
				puts "index"
				#puts l["data"].to_s
				puts l["data"].each_index.select{|i| l["data"][i]==172}

			end;
		end;		
	end;
end;	