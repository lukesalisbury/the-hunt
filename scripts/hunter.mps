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
 *     2012/07/21 [luke]: new file. 
 ***********************************************/
enum AgentLocation
	LNAME[64],
	LTIMER
}

new movement_animation[4][32] = { "src_professor.png:front", "src_professor.png:right", "src_professor.png:back", "src_professor.png:left" };
new standing_animation[4][32] = { "src_professor.png:front_0", "src_professor.png:right_0", "src_professor.png:back_0", "src_professor.png:left_0" };
new shooting_animation[4][32] = { "src_professor.png:front", "src_professor.png:right", "src_professor.png:back", "src_professor.png:left" };

new timer = 40000; //300000
new attacking  = false;
new attack_timer = 1000;
new obj = -1;

new locations[64][AgentLocation];


forward public NewLocation(name[]);
public NewLocation( name[] )
{
	player_alive = false;
}

public Init( ... )
{

}


appendLocation( name[64] )
{
	new c = 0;
	while ( locations[c][LNAME][0] )
	{
		c++;
		if ( c > 63 )
			break;
	}
	StringCopy(locations[c][LNAME], name);

}

popLocation()
{
	new c = 1;
	while ( locations[c][LNAME][0] )
	{
		StringCopy(locations[c-1][LNAME], locations[c][LNAME] );
		locations[c-1][LTIMER] =  locations[c][LTIMER]; 
		c++;
		
	}
}

displayTimer(t)
{
	new str[64];
	new minutes = t / 60;
	new seconds = t %60;
	StringFormat(str, _,_, "%d:%d Minutes",minutes, seconds);
	GraphicsDraw(str, TEXT, 100, 300, 6, 0,0, 0xFF0000FF);
}

handleAttack()
{
	if ( !attacking )
	{
		obj = ObjectCreate( shooting_animation[0], SPRITE, 0,0,3,0,0);
	} 	
	else
	{
		attack_timer -= GameFrame();
		if (attack_timer < 0 )
		{
			EntityPublicFunction("tom", "KillByAgent", "");
			ObjectDelete(obj);
		}
	}
	attacking = true;
}


main()
{
	if ( timer > 0 )
	{
		timer -= GameFrame() * GameState();	
		displayTimer(timer/1000);
	}
	else
	{
		handleAttack()
	}


}
