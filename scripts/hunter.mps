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

new movement_animation[4][32] = { "src_professor.png:front", "src_professor.png:right", "src_professor.png:back", "src_professor.png:left" };
new standing_animation[4][32] = { "src_professor.png:front_0", "src_professor.png:right_0", "src_professor.png:back_0", "src_professor.png:left_0" };
new shooting_animation[4][32] = { "src_professor.png:front", "src_professor.png:right", "src_professor.png:back", "src_professor.png:left" };


new Fixed:timer = 300.000;

displayTimer()
{
	new str[64];
	StringFormat(str, _,_, "%.2q Minutes", timer/60.0);
	GraphicsDraw(str, TEXT, 100, 300, 6, 0,0, 0xFF0000FF);
}


main()
{
	timer -= GameFrame2() * GameState();	

	if ( timer > 0 )
	{
		displayTimer();

	}	


}
