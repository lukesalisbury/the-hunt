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
 
#define FADEIN		1 
#define FADESWITCH	2 
#define FADEOUT		3	 
#define FADEEND		4 
 
 
forward public SetTarget(nsection[], ngridx, ngridy) 
 
/* Target Varibles */ 
new section_name[64]; 
new section_x, section_y; 
 
new tstate; 
 
new acolor = 0xFFFFFFFF; 
new Fixed:timer; 
 
new error_map = 0; 
 
public Init(...) 
{ 
	error_map = MapID("empty"); 
} 
public Close() {} 
 
main() 
{ 
	if ( tstate ) 
	{ 
		if ( tstate == FADEEND ) // End Animation 
		{ 
			tstate = 0; 
			LayerColour(0, 0xFFFFFFFF); 
			LayerColour(1, 0xFFFFFFFF); 
			LayerColour(2, 0xFFFFFFFF); 
			LayerColour(3, 0xFFFFFFFF); 
			LayerColour(4, 0xFFFFFFFF); 
			LayerColour(5, 0xFFFFFFFF); 
			GameState(1); 
		} 
		else if ( tstate == FADEOUT) 
		{ 
			Fade(); 
		} 
		else if (  tstate == FADESWITCH ) 
		{ 
			// An entity on the map should update the entry point 
			new x = EntityPublicVariable( CURRENT_MAP, "entry_x" ); 
			new y = EntityPublicVariable( CURRENT_MAP, "entry_y" ); 
 
			EntityPublicVariableSet( PLAYRENTITY, "_x_", fixed(x) ); 
			EntityPublicVariableSet( PLAYRENTITY, "_y_", fixed(y) ); 
 
			EntityPublicFunction( PLAYRENTITY, "RefreshPosition", "" ); 
 
			tstate = FADEOUT; 
			Fade(); 
		} 
		else // FADEIN 
		{ 
			Fade(); 
		} 
	} 
} 
 
public SetTarget(nsection[], ngridx, ngridy) 
{ 
	StringCopy(section_name, nsection); 
	section_x = ngridx; 
	section_y = ngridy; 
 
	tstate = FADEIN; 
	return true; 
} 
 
MoveToTarget() 
{ 
	if ( section_name[0] ) 
	{ 
		GameLog( "SectionSet '%s' '%dx%d'", section_name, section_x, section_y ); 
		SectionSet(section_name, section_x, section_y); 
		if ( !SectionValid(section_name, section_x, section_y) ) 
		{ 
			GameLog( "Invalid Section '%s' '%dx%d'", section_name, section_x, section_y ); 
			MapChange( error_map ); 
		} 
		 
 
		 
		SectionGet(section_name, section_x, section_y); 
		GameLog( "Section '%s' '%dx%d'", section_name, section_x, section_y ); 
 
		section_name[0] = 0; 
		return true; 
	} 
	return false; 
} 
 
Fade() 
{ 
	new alpha = 255; 
 
	timer += GameFrame2() * 400.0; 
	 
	if ( tstate == FADEOUT ) 
		alpha = 0 + fround(timer); 
	else if ( tstate == FADEIN ) 
		alpha = 255 - fround(timer); 
 
	if ( timer >= 255.0 ) // Switch FADE mode 
	{ 
		// For the last frame of FADEIN we move the entity 
		// so FADESWITCH can move toe entity to the right 
		// x/y position. 
		if ( tstate == FADEIN ) 
		{ 
			if ( MoveToTarget() ) 
				return; 
		} 
 
		tstate++; 
		timer = 0.0; 
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
 
 
