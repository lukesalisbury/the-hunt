/***********************************************
 * Copyright © Luke Salisbury
 *
 * This work is release under the GNU GENERAL PUBLIC LICENSE Version 3
 * For Full Terms visit http://www.gnu.org/licenses/gpl-3.0.html
 *
 * --- OR ---
 *
 * You are free to share, to copy, distribute and transmit this work
 * You are free to adapt this work
 * Under the following conditions:
 * - You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). 
 * - You may not use this work for commercial purposes.
 * - If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
 * Full terms of use: http://creativecommons.org/licenses/by-nc-sa/3.0/
 ***********************************************/
enum AgentLocation {
	LNAME[64],
	LTIMER
}

new shooting_animation[4][32] = { "src_agent.png:front", "src_agent.png:right", "src_agent.png:back", "src_agent.png:left" };

new second_counter = 0;
new timer = 0; //300000
new attacking  = false;
new attack_timer = 1000;
new obj = -1;
new screen = 0;

new locations[64][AgentLocation];


forward public newLocation(name[64]);

public newLocation( name[64] )
{
	appendLocation( name );
}

public Init( ... )
{
	screen = MiscGetWidth("__screen__")/2;
	appendLocation("OnTheRoad");
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
	locations[c][LTIMER] = 200;
	timer += 200000;
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
	StringFormat(str, _,_, "%02d:%02d",minutes, seconds);
	GraphicsDraw(str, TEXT, screen-20, 2, 6, 0,0, 0xFF0000FF);
}

handleAttack()
{
	if ( !attacking )
	{
		new x = EntityPublicVariable("__map__", "entry_x" );
		new y = EntityPublicVariable("__map__", "entry_y" );

		obj = ObjectCreate( shooting_animation[0], SPRITE, x,y,3,0,0);
	} 	
	else
	{
		attack_timer -= GameFrame();
		if (attack_timer < 0 )
		{
			EntityPublicFunction(PLAYRENTITY, "KillByAgent", "");
			ObjectDelete(object:obj);
		}
	}
	attacking = true;
}


main()
{
	DebugText( "Agent Location: %s %d", locations[0][LNAME], locations[0][LTIMER]);
	
	if ( timer > 0 )
	{
		second_counter += GameFrame() * GameState();
		if ( second_counter >= 1000 )
		{
			locations[0][LTIMER]--;
			if ( locations[0][LTIMER] <= 0 )
			{
				popLocation();
			}
			second_counter -= 1000;
		} 
		timer -= GameFrame() * GameState();	
		displayTimer(timer/1000);
	}
	else
	{
		handleAttack()
	}


}
