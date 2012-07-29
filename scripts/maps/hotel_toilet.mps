#tryinclude <map_default>
#include <state_manage>
#tryinclude <language_info>


forward @intro();
forward @exit_intro();
forward @entry_intro();

/* */
new screenWidth;
new screenHeight;
new object:fade = object:-1;
new timer = 0;


public Init( ... )
{
	screenWidth = MiscGetWidth("__screen__"); 
	screenHeight = MiscGetHeight("__screen__");
	fade = ObjectCreate("", RECTANGLE, 0, 0, 5, screenWidth, screenHeight, 0x000000FF );
	
	StateAdd( "@intro", "@entry_intro", "@exit_intro" );
	StateSwitch(true, "@intro");
}

main()
{
	StateHandle(true);
}


FadeTimer()
{
	new a = 0xFF;
	timer += GameFrame() * 20;
	a -= timer / 1000; 
	return 0x00000000 | (a>0 ? a : 0); 
}


/* State */
@entry_intro()
{
	DialogShow(HOTEL_TOILET_INTRO, "dialogbox");
}


@intro()
{
	new a = FadeTimer()
	ObjectEffect( fade, a );
	GameState(0);
	StateSwitch( 0x00000000 == a, "" );
}

@exit_intro()
{
	ObjectDelete( fade );
	GameState(1);
}