#<<<<<<< HEAD
#MAP_FILE = File.join(File.dirname($0), 'assets','maps','LongerMap.json');
#MAP_FILE = File.join(File.dirname($0), 'assets','maps','cyclic.json');
MAP_FILE = File.join(File.dirname($0), 'assets','maps','test6.json');
#=======
#MAP_FILE = File.join(File.dirname($0), 'assets','maps','LongerMap.json');
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
#MAP_FILE = File.join(File.dirname(__FILE__), 'TinyMap.json');
PLAYER_BLUE_WALK_RIGHT_FILE=File.join(File.dirname($0), 	'assets','images','player','player_blue_walk_right.png');
PLAYER_GREEN_WALK_RIGHT_FILE=File.join(File.dirname($0), 	'assets','images','player','player_green_walk_right.png');
PLAYER_RED_WALK_RIGHT_FILE=File.join(File.dirname($0), 		'assets','images','player','player_red_walk_right.png');
PLAYER_BLUE_WALK_LEFT_FILE=File.join(File.dirname($0), 		'assets','images','player','player_blue_walk_left.png');
PLAYER_GREEN_WALK_LEFT_FILE=File.join(File.dirname($0), 	'assets','images','player','player_green_walk_left.png');
PLAYER_RED_WALK_LEFT_FILE=File.join(File.dirname($0), 		'assets','images','player','player_red_walk_left.png');

PLAYER_BLUE_FALL_FILE=File.join(File.dirname($0), 	'assets','images','player','player_blue_hurt.png');
PLAYER_BLUE_JUMP_FILE=File.join(File.dirname($0), 	'assets','images','player','player_blue_jump.png');
PLAYER_BLUE_CLIMB_FILE=File.join(File.dirname($0), 	'assets','images','player','player_blue_climb.png');
PLAYER_BLUE_STAND_FILE=File.join(File.dirname($0), 	'assets','images','player','player_blue_stand.png');

CRAWLER_FILE=File.join(File.dirname($0), 	'assets','images','crawler','p3_walk03_1.png');

#<<<<<<< HEAD
LARGE_FONT=Gosu::Font.new(height=20,options={name:"Courier New"})

#=======
#>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
FRAME_DELAY=16 
TILE_SIZE=70

PLAYER_CLASS="Player"
PLAYER="Player Blue"
CRAWLER="Crawler"
OBSTACLE="Obstacle"
LADDER="Ladder"
VIRTUAL="Virtual"
START_POSITION="StartPosition"
PLATFORM="Platform"
BONUS="Bonus"
CONTROL="Control"
SWITCH="Switch"
KEY="Key"

WALKING_SPEED=5
JUMPING_SPEED=20
JUMPING_DECELERATION=2
CLIMBING_SPEED=3

DATA_PLAYER={"id"=>10000,
                  "height"=>94,
                  "width"=>70,
                  "name"=>"Player",
                  "rotation"=>0,
                  "type"=>"Player",
                  "visible"=>true,
                  "x"=>280,
                  "y"=>70
                  };

DATA_CRAWLER={"id"=>10001,
                  "height"=>94,
                  "width"=>70,
                  "name"=>"Crawler",
                  "rotation"=>0,
                  "type"=>"Crawler",
                  "visible"=>true,
<<<<<<< HEAD
                  "x"=>490,
                  "y"=>0
=======
                  "x"=>140,
                  "y"=>70
>>>>>>> c619dc701e6b49ddd1dd22f95df8f619bf5d0dbe
                  };

