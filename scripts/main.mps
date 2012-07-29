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
 *  You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).  
 *  You may not use this work for commercial purposes. 
 * Full terms of use: http://creativecommons.org/licenses/by-nc/3.0/ 
 ***********************************************/ 
 
forward public ShowMsg( str[] ); 
 
enum MESSAGE { 
	TEXT[255], 
	MX, 
	MY, 
	MS, 
	MTIMER 
} 
 
/* */ 
new gstate = 1; 
new msgStr[6][MESSAGE]; 
new msgs = 0;  
new screenWidth, screenHeight; 
 
public Init( ... ) 
{ 
	gstate  = GameState(gstate); 
	screenWidth = MiscGetWidth("__screen__"); 
	screenHeight = MiscGetHeight("__screen__");
	LanguageSet("00"); 
} 
 
 
main() 
{ 
	new y = 0; 
	for ( new c = 0; c < 6; c++ ) 
	{ 
		if ( msgStr[c][TEXT][0] ) 
		{ 
			msgStr[c][MY] = (++y) * 30; 
			drawMessage(msgStr[c]); 
		} 
	} 
} 
 
drawMessage( msg[MESSAGE] ) 
{ 
	new background = 0x000000DD; 
	new text = WHITE; 
	new width = 160; 
 
	if ( msg[MTIMER] < 1000 ) 
	{ 
		new a = msg[MTIMER] / 4; 
 
		background = 0x00000000 | (a>0 ? a :0); 
		text = 0xFFFFFF00 | (a>0 ? a :0); 
	} 
 
	GraphicsDraw("", RECTANGLE, screenWidth - width - 10, screenHeight - msg[MY], 5, width, 26, background ); 
	GraphicsDraw(msg[TEXT], TEXT,  screenWidth - width - 8, screenHeight - msg[MY] + 2, 5, 0,0, text); 
 
	if ( msg[MTIMER] <= 0 ) 
	{ 
		msg[TEXT][0] = 0; 
		msgs--; 
	} 
	msg[MTIMER] -= GameFrame(); 
} 
 
 
wrapText( text[255] ) 
{ 
	new c = 20; 
	new l = StringLength(text); 
	if ( l >= 20 ) 
	{ 
		while ( c < l ) 
		{ 
			StringInsert( text, "\n", c); // TODO replace with nicer formatting 
			l++; 
			c += 20; 
		} 
	} 
} 
 
 
public ShowMsg( str[] ) 
{ 
	for ( new c = 0; c < 6; c++ ) 
	{ 
		if ( !msgStr[c][TEXT][0] ) 
		{ 
			StringCopy(msgStr[c][TEXT], str); 
			wrapText( msgStr[c][TEXT] ); 
			msgStr[c][MTIMER] = 5000; 
			msgs++; 
			return; 
		} 
	} 
} 
 
