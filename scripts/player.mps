/***********************************************
 * Copyright © Luke Salisbury
 *
 * You are free to share, to copy, distribute and transmit this work
 * You are free to adapt this work
 * Under the following conditions:
 *  You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). 
 *  You may not use this work for commercial purposes.
 * Full terms of use: http://creativecommons.org/licenses/by-nc/3.0/
 * Changes:
 *     2012/07/05 [luke]: new file. Basic Player movement and Clue detection
 ***********************************************/

new movement_animation[4][32] = { "src_professor.png:front", "src_professor.png:right", "src_professor.png:back", "src_professor.png:left" };
new standing_animation[4][32] = { "src_professor.png:front_0", "src_professor.png:right_0", "src_professor.png:back_0", "src_professor.png:left_0" };
public Fixed:_x_, Fixed:_y_, Fixed:_z_, Fixed:_angle_;
public object:obj = object:-1;
new _flipx_, _flipy_;
public Fixed:_speed_ = 1.0;
new player_direction = 0;
new checks[8][3];

new player_mode = 1;

/* South, west, north, east */
stock round_method:move_round[4][2] = { {round_floor, round_ceil}, {round_ceil, round_ceil}, {round_ceil, round_floor}, {round_floor, round_floor} }; //Used round player's position in the correct directions

stock EntityMove( maxmask )
{
	new Fixed:speed =  _speed_ * GameFrame2();
	new results = 0;
	
	if (speed > 1.0)
	{
		while ( speed > 1.0 )
		{
			results += EntityMoveCode(maxmask, 1.0);
			speed -= 1.0;
		}
	}
	results += EntityMoveCode(maxmask, speed);
	CollisionSet(SELF, 0, TYPE_PLAYER, fround(_x_)+16, fround(_y_) + 48, 32, 24 );

	return results;
}

stock EntityMoveCode( maxmask, Fixed:speed )
{
	if (!speed)
		return false;

	new Fixed:movex = ( _flipx_ ? -fsin(_angle_, degrees) : fsin(_angle_, degrees) ) * speed;
	new Fixed:movey = ( _flipy_ ? -fcos(_angle_, degrees) : fcos(_angle_, degrees) ) * speed;
	new r = false;

	player_direction = Angle2Dir(_angle_, 90 );
	
	UpdatePoints();

	if ( MoveCheck(_angle_, maxmask, movex, movey) )
	{
		_x_ += movex;
		_y_ += movey;
		r = true;
	}
	else
	{
		_x_ = fixed( fround(_x_, move_round[player_direction][0]) );
		_y_ = fixed( fround(_y_, move_round[player_direction][1]) );
	}
	
	return r;
}

stock Angle2Dir(Fixed:a, q = 90, Fixed:offset = 0.0)
{
	a += offset;
	if ( a < 0.0 )
		a += 360.0;
	else if ( a >= 360.0 )
		a -= 360.0;
	return NumberClamp(fround(a) / q, 0, (q == 45 ? 7 : 3) );
}



stock MoveCheck(Fixed:angle, maxmask, Fixed:movex, Fixed:movey)
{
	new l,r,q = Angle2Dir(angle, 45, 22.5);
	l = (q >= 7 ? 0 : q + 1);
	r = (q == 0 ? 7 : q - 1);

	new maskv = MaskGetValue( checks[q][0], checks[q][1]);
	new maskvl = MaskGetValue( checks[l][0], checks[l][1]);
	new maskvr = MaskGetValue( checks[r][0], checks[r][1]);

	if( maskv > 255 || maskv < 0 )
	{
		return false;
	}
	else if ( maskv > maxmask || maskvl > maxmask || maskvr > maxmask  )
	{
		return false;
	}

	return true;
}

stock UpdatePoints( )
{
	new dx = fround(_x_);
	new dy = fround(_y_);

	checks[SOUTH][XAXIS] = dx + 32;
	checks[SOUTH][YAXIS] = dy + 64;

	checks[SOUTHEAST][XAXIS] = dx + 48 - 2;
	checks[SOUTHEAST][YAXIS] = dy + 64 - 2;

	checks[EAST][XAXIS] = dx + 48;
	checks[EAST][YAXIS] = dy + 56;

	checks[NORTHEAST][XAXIS] = dx + 48 - 2;
	checks[NORTHEAST][YAXIS] = dy + 48 + 2;

	checks[NORTH][XAXIS] = dx + 32;
	checks[NORTH][YAXIS] = dy + 48;

	checks[NORTHWEST][XAXIS] = dx + 16 + 2;
	checks[NORTHWEST][YAXIS] = dy + 48 + 2;

	checks[WEST][XAXIS] = dx + 16;
	checks[WEST][YAXIS] = dy + 56;

	checks[SOUTHWEST][XAXIS] = dx + 16 + 2;
	checks[SOUTHWEST][YAXIS] = dy + 64 - 2;

	for ( new c = 0; c < 8; c++ )
	{
		GraphicsDraw("", RECTANGLE, checks[c][XAXIS], checks[c][YAXIS], 5, 2,2, 0xFF00FFAA);
	}
	
}

/*---------------*/

public Init( ... )
{
	EntityGetPosition(_x_, _y_, _z_);
	obj = object:ObjectCreate( movement_animation[0], SPRITE,  fround(_x_), fround(_y_), 1, 0, 0, WHITE);
	EntityCreate("menu", "menu", 1, 1, 1, GLOBAL_MAP);
	EntityCreate("transition", "transition", 1, 1, 1, GLOBAL_MAP);

}


public UpdatePosition()
{

}

main()
{
	if ( player_mode == 1 )
	{
		if ( InputButton(6) ==1 )
			player_mode = !player_mode;
		PlayerMove();
		CheckCollisions();
		UpdateSprite();
	}
	else
	{
		Menu();
	}
}

Menu()
{
	static menuFunction[10] = "Index";
	static menuMode = 0;

	
	menuMode = EntityPublicFunction("menu", menuFunction, "" );

	if ( menuMode == 1 ) // return to game 
		player_mode = 1; 
	else if (menuMode == 2) // return to main menu
	{
		menuFunction = "Index"
	}
	else if (menuMode == 3) // return to main menu
	{
		menuFunction = "Travel"
	}
	else if (menuMode == 4) // return to main menu
	{
		menuFunction = "Clues"
	}
}


UpdateSprite()
{
	if (_speed_ > 0.2 )
	{
		ObjectReplace( obj, movement_animation[player_direction], SPRITE );
	}
	else
	{
		ObjectReplace( obj, standing_animation[player_direction], SPRITE );
	}
	ObjectPosition( obj, fround(_x_), fround(_y_), 2, 0, 0 );
}


PlayerMove()
{
	new x_movement = 0;
	new y_movement = 0;

	x_movement = InputAxis(0,0);
	y_movement = InputAxis(1,0);
	
	if ( x_movement || y_movement )
	{
		_angle_ = fatan2( x_movement, -y_movement, degrees) + 90.0;
		_speed_ = 32.0;
	}
	else
	{
		_speed_ = 0.0;
	}
	
	EntityMove(128);
}


CheckCollisions()
{
	if ( CollisionCalculate() )
	{
		new current[64];
		new angle;
		new dist;
		new rect;
		new type;
		while ( CollisionGetCurrent(SELF, current, angle, dist, rect, type) )
		{
			if ( type == TYPE_CLUEALERT )
			{
				GraphicsDraw("Clue nearby", TEXT, 0,0,6,0,0, WHITE);
			}
			else if ( type == TYPE_CLUE )
			{
				GraphicsDraw("Pickup Clue?", TEXT, 0,16,6,0,0, WHITE);
				if ( InputButton(0) )
				{
					EntityPublicFunction( current, "PickUp", "");
				}
			}
		}
	}
}