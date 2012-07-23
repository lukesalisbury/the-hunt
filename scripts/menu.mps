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
 *     2012/07/23 [luke]: new file.
 ***********************************************/



#include <helper>
enum CLUE_DETAIL {
	id[64],
	name[64]
}

forward public Index();
forward public Travel();
forward public Clues();

static menuSelect = 0;
static clueChoosen = 0;
static clueCount = -1;
static clues[256][CLUE_DETAIL];

static menuWait = 0;

main()
{
}

CheckButton()
{
	if ( menuWait > 0 )
	{
		if ( InputButton(6) ==1 )
			return true;	
	}
	else
	{
		menuWait -= GameFrame();
	}
	return false;
}

AddWait(time)
{
	menuWait = time;
}
ScanClues()
{
	if ( clueCount != -1 )
		return;
	clueCount = 0;	
	clueChoosen = 0;

	new enityt[64];
	new c = EntitiesList(0);
	new q = 0;
	if ( c )
	{
		while ( EntitiesNext(enityt, 0) ) 
		{
			q = StringFind( enityt, "item_" );
			if ( q == 0 )
			{
				
				StringCopy( clues[clueCount][id], enityt );
				clueCount++;
			}
	
		}
	}
}

CombineClues()
{
	new c1  = clueChoosen - 1;
	new c2  = menuSelect - 1;
	new an = EntityPublicFunction(clues[c2][id], "checkCombination", "s", clues[c1][id] );

	if ( an )
		clueChoosen = 0;

	AddWait(10);
}



public Clues()
{
	if ( CheckButton() ) // Enter pressed
	{
		if ( menuSelect == 0 )
			return 2;
		else if ( clueChoosen && menuSelect != clueChoosen )
		{
			CombineClues();
		}
		else
			clueChoosen = menuSelect;
	}

	
	ScanClues();

	GraphicsDraw("", RECTANGLE, 16,16, 6, 180,64 + (clueCount*20), 0x00000099);
	GraphicsDraw("Return", TEXT, 24,24, 6, 0,0, menuSelect == 0 ? 0xFF3333FF : 0xFFFFFFFF);

	if ( clueCount )
	{
		for ( new n = 0; n< clueCount; n++ )
		{
			GraphicsDraw(clues[n][id], TEXT, 24,44+(20*n), 6, 0,0, menuSelect == n+1 ? 0xFF3333FF : 0xFFFFFFFF);

			if ( clueChoosen == n + 1)
			{
				new offset = StringLength(clues[n][id])*8;
				GraphicsDraw("combine", TEXT, 24 + offset ,44+(20*n), 6, 0,0,  0xFFFF00FF);
			}
		
		}

	}


	/* Check for Up/down input then use the remainder to loop */
	if ( InputButton(7) == 1 )
		menuSelect--;
	else if ( InputButton(8) == 1 )
		menuSelect++;

	menuSelect %= clueCount+1;
	

	return 0;
}

/* Travel Menu */

#define LOCATIONS 20
new available_location[LOCATIONS][64];
new locations_count = 0;

/*
scanLocations()
{
	if ( section_scanned )
		return;

	new files[LOCATIONS][64];
	FileGetList(files, "sections");

	for ( new c = 0; c < LOCATIONS; c++ )
	{
		if ( files[c][0] ) //Check if the string exists
		{
			// remove the .txt from the file name.
			new w = StringFind( files[c], "." ); 
			if (w > 2 )
				files[c][w] = 0;

			StringCopy( available_location[locations_count][LNAME], files[c])
		}
		else 
		{
			// Exit for loop
			break;
		}	
	}	
}
*/

public unlockLocation( location[64] )
{
	if ( locations_count < LOCATIONS)
	{
		StringCopy( available_location[locations_count], location);
		locations_count++;
	}
}

public Travel()
{
	if ( InputButton(6) ==1 ) // Enter pressed
	{
		if ( menuSelect == 0 )
			return 2;
		else if ( menuSelect > 0 )
		{
			EntityPublicFunction("transition", "SetTarget", "sssnn", "tom", "", available_location[menuSelect-1], 0,0);
			EntityPublicFunction("jerry", "newLocation", "s",  available_location[menuSelect-1]);
			return 1;
		}

	}

	GraphicsDraw("", RECTANGLE, 16,16, 6, 288,44 + (locations_count*20), 0x00000099);
	GraphicsDraw("Return", TEXT, 24,24, 6, 0,0, menuSelect == 0 ? 0xFF3333FF : 0xFFFFFFFF);

	for ( new n = 0; n < locations_count; n++ )
	{
		if ( available_location[n][0] )
		{
			GraphicsDraw(available_location[n], TEXT, 24,44+(20*n), 6, 0,0, menuSelect == n+1 ? 0xFF3333FF : 0xFFFFFFFF);
		}	
	}


	/* Check for Up/down input then use the remainder to loop */
	if ( InputButton(7) == 1 )
		menuSelect--;
	else if ( InputButton(8) == 1 )
		menuSelect++;

	menuSelect %= 20;


	return 0;
}

/* Main Menu */

public Index()
{
	/* Reset counter */
	clueCount = -1;

	if ( InputButton(6) ==1 ) // Enter pressed
	{
		if ( menuSelect == 0 )
			return 3;
		else if ( menuSelect == 1 )
		{
			menuSelect = 0;
			return 4;
		}		
		else 
			return 1;
	}

	GraphicsDraw("", RECTANGLE, 16,16, 6, 288,68, 0x00000099);
	GraphicsDraw("Travel", TEXT, 24,24, 6, 0,0, menuSelect == 0 ? 0xFF3333FF : 0xFFFFFFFF);
	GraphicsDraw("Clues", TEXT, 24,44, 6, 0,0, menuSelect == 1 ? 0xFF3333FF : 0xFFFFFFFF);
	GraphicsDraw("Continue", TEXT, 24,64, 6, 0,0, menuSelect == 2 ? 0xFF3333FF : 0xFFFFFFFF);
	

	/* Check for Up/down input then use the remainder to loop */
	if ( InputButton(7) == 1 )
		menuSelect--;
	else if ( InputButton(8) == 1 )
		menuSelect++;

	menuSelect %= 3;


	return 0;
}
