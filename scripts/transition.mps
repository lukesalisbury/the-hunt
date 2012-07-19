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
 *     2010/01/11 [luke]: new file.
 ***********************************************/

#define FADEIN			1
#define FADESWITCH	2
#define FADEOUT		3	
#define FADEEND		4

forward public SetTarget(nplayer[], ntargetentity[], nsection[], ngridx, ngridy)


/* Target Varibles */
new section_name[64];
new target_entity[32];
new player_entity[64];
new section_x, section_y;

new tstate;

new acolor = 0xFFFFFFFF;
new Fixed:seconds;

public Init(...) {}
public Close() {}

main()
{
	if ( tstate )
	{
		if ( tstate == FADEEND )
		{
			tstate = 0;
			LayerColour(0, 0xffffffff);
			LayerColour(1, 0xffffffff);
			LayerColour(2, 0xffffffff);
			LayerColour(3, 0xffffffff);
			LayerColour(4, 0xffffffff);
			LayerColour(5, 0xffffffff);
			GameState(1);
		}
		else if ( tstate == FADEOUT || tstate == FADESWITCH)
		{
			if (  tstate == FADESWITCH )
			{
				EntityPublicVariableSet( "tom", "_x_", 10);
				EntityPublicVariableSet( "tom", "_y_", 200);

				tstate = FADEOUT;
			}
			Fade();
		}
		else
		{
			Fade();
		}
	}
}

public SetTarget(nplayer[], ntargetentity[], nsection[], ngridx, ngridy)
{
	StringCopy(target_entity,ntargetentity);
	StringCopy(player_entity,nplayer);
	StringCopy(section_name,nsection);
	section_x = ngridx;
	section_y = ngridy;

	tstate = FADEIN;

	return true;
}

MoveToTarget()
{
	if ( section_name[0] )
	{
		SectionSet(section_name, section_x, section_y);
		section_name[0] = 0;
		return true;
	}
	tstate = FADESWITCH;
	return false;
}

Fade()
{
	new alpha;

	seconds += GameFrame2() * 400.0;
	
	if ( tstate == FADEOUT )
		alpha = 0 + fround(seconds);
	else 
		alpha = 255 - fround(seconds);

	if ( seconds >= 255.0 )
	{
		if ( tstate == FADEIN )
		{
			if ( MoveToTarget() )
				return;
		}

		tstate++;
		seconds = 0.0;
	}
	else
	{
		acolor = (alpha << 24 | alpha << 16 | alpha << 8 | alpha);

		LayerColour(0, acolor);
		LayerColour(1, acolor);
		LayerColour(2, acolor);
		LayerColour(3, acolor);
		LayerColour(4, acolor);
		LayerColour(5, acolor);
	}

}


