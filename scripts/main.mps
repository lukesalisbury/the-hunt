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

forward public ShowMsg( str[] ); 
forward public dialogbox(line);
enum MESSAGE { 
	TEXT[255], 
	MX, 
	MY, 
	MS, 
	MTIMER 
} 
 
/* */ 
new screenWidth, screenHeight; 

new msgStr[6][MESSAGE]; 
new msgs = 0;  

new dialog_line = -1;
new dialog_msg[1024];
new dialog_show[1024];
new dialog_char = 0;
new dialog_timer = -1;
new dialog_length = -1;


public Init( ... ) 
{ 
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
	dialog();
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
 



dialog()
{
	if (dialog_line == -1)
		return;
	AllowPlayerMovement(false);
	if ( dialog_msg[dialog_char] != 0 )
	{
		dialog_timer += GameFrame();
		if ( dialog_timer > 100 )
		{
			dialog_show[dialog_char] = dialog_msg[dialog_char];
			dialog_timer -= 100;
			dialog_char++;
		}
		if ( InputButton(0) == 1 ) //Exit Dialog
		{
			StringCopy(dialog_show, dialog_msg);
			dialog_char = StringLength(dialog_show);
		}
	}
	else
	{
		GraphicsDraw("hint.png:2", SPRITE, 8+dialog_length, screenHeight-44, 6,0,0, WHITE);
		if ( InputButton(0) == 1 ) //Exit Dialog
		{
			dialog_line = -1;
			AllowPlayerMovement(true);
		}
	}

	GraphicsDraw(dialog_show, TEXT, 8, screenHeight-40, 6, 0, 0, 0xFFFFFFFF);

}

public dialogbox(line)
{
	dialog_line = line;
	dialog_timer = 0;
	dialog_length = 2;
	dialog_char = 0;
	StringClear(dialog_msg);
	StringClear(dialog_show);
	DialogGetString(dialog_line, dialog_msg);
	
	// End of Line
	dialog_length = StringFind(dialog_msg, "\n");
	if (dialog_length == -1)
	{
		dialog_length = StringLength(dialog_msg);
	}
	dialog_length = (dialog_length * 7) + 2;

	//DialogPlayAudio(dialog_line);
}