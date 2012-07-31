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

#tryinclude <map_default>
#tryinclude <language_info>
#include <state_manage>

forward @intro();
forward @exit_intro();
forward @entry_intro();

/* */
new screenWidth;
new screenHeight;
new object:fade = object:-1;
new timer = 0;
new intro = true;

public Init( ... )
{

	screenWidth = MiscGetWidth("__screen__"); 
	screenHeight = MiscGetHeight("__screen__");
	
	
	StateAdd( "@intro", "@entry_intro", "@exit_intro" );
	StateSwitch(intro, "@intro");
	intro = false;
}

main()
{
	StateHandle(true);
	DebugText("%d %d", EntityPublicVariable("__map__", "entry_x" ), EntityPublicVariable("__map__", "entry_y" ) );
}

FadeTimer()
{
	new a = 0xFF;
	timer += GameFrame() * 20;
	a -= timer / 500; 
	return 0x00000000 | (a>0 ? a : 0); 
}


/* State */
@entry_intro()
{
	AllowPlayerMovement( false );
	GameState(0);
	fade = ObjectCreate("", RECTANGLE, 0, 0, 5, screenWidth, screenHeight, 0x000000FF );
	DialogShow(HOTEL_TOILET_INTRO, "dialogbox");
	
}


@intro()
{
	new a = FadeTimer()
	ObjectEffect( fade, a );
	
	StateSwitch( 0x00000000 == a, "" );
}

@exit_intro()
{
	ObjectDelete( fade );
	GameState(1);
}