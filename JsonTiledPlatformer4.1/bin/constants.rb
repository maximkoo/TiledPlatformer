MAP_FILE = File.join(File.dirname($0), 'assets','maps','LongerMap.json');
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

FRAME_DELAY=16 
TILE_SIZE=70

PLAYER_CLASS="Player"
PLAYER="Player Blue"
OBSTACLE="Obstacle"
LADDER="Ladder"
PRIZE="Prize"
VIRTUAL="Virtual"
START_POSITION="StartPosition"
PLATFORM="Platform"
BONUS="Bonus"
CONTROL="Control"

WALKING_SPEED=5
JUMPING_SPEED=20
JUMPING_DECELERATION=2
CLIMBING_SPEED=3