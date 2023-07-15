require './movableGameObject.rb'

	@m=Player.new(0,0)
	@m.w,@m.h=10,10;
	@m.prevX,@m.prevY=0,0
	@m.x,@m.y=5.5,11


	@s1=Obstacle.new(20,20)
	@s1.w,@s1.h=10,10

	@s2=Obstacle.new(10,20)
	@s2.w,@s2.h=10,10

	@s3=Ladder.new(0,20)
	@s3.w,@s3.h=10,10

	@s4=Obstacle.new(0,30)
	@s4.w,@s4.h=10,10	

	@collider=ColliderCore.new();

	# puts "Test intersection"
	# (0..10).each do |d|
	# 	@m.x=0
	# 	@m.y=2*d
	# 	puts "x,y=#{@m.x}, #{@m.y}"
	# 	a=@collider.intersect?(@m,@s1)
	# 	puts a
	# 	a=@collider.intersect?(@m,@s2)
	# 	puts a
	# 	puts		
	# end;
	# puts

	puts "Test Contacts"
		@m.x=0
		@m.y=30
		@m.prevX=0
		@m.prevY=0
		puts "Moving x,y=#{@m.x}, #{@m.y}"
		a=@collider.getContacts(@m,[@s1,@s2,@s3,@s4])
		puts
		puts "Finally, the contacts are:"
		puts a
		
b=a.select{|c| c.stillClass=="Obstacle"||(c.stillClass=="Ladder" && c.contactType=="upper horizontal")}.first
puts "The critical point is: #{b.safeX}, #{b.safeY}"

