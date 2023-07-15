module M1
	$c='qwerty'
end;

class C1
	include M1
	def m1
		$c
	end;
end;

class C2
	include M1
	def m1
		$c
	end;
end;

c1=C1.new
c2=C2.new

puts c1.m1.object_id==c2.m1.object_id
