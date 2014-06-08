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
 
 
public Init( ... ) 
{ 
	screenWidth = MiscGetWidth("__screen__");  
	screenHeight = MiscGetHeight("__screen__"); 
 
	StateAdd( "@intro", "@entry_intro", "@exit_intro" ); 

	EntityDelete(PLAYRENTITY); 

	StateSwitch( .name = "@intro" ); 
 
} 
 
main() 
{ 
	StateSwitch( InputButton(6) == 1, "@intro" ); 
	StateHandle(true); 
} 
 
 
FadeTimer() 
{ 
	new a = 0x00; 
	timer += GameFrame(); 
	a += timer / 10;  
	return 0x00000000 | (a < 255 ? a : 255);  
} 
 
 
/* States */ 
@entry_intro() 
{ 
	fade = ObjectCreate("", RECTANGLE, 0, 0, 5, screenWidth, screenHeight, 0x00000000 ); 
} 
 
 
@intro() 
{ 
	new a = FadeTimer() 
	ObjectEffect( fade, a ); 
	StateSwitch( 0x000000FF == a, "" ); 
} 
 
@exit_intro() 
{ 
	ObjectDelete( fade ); 
	SectionSet("Hotel", 0, 2 ); 
}