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
#define combineOption[.matchingClue{64}, .newClue{64}, .location{64}, .location_grid, .remove ]

#include <private_language>
#include <locations_info>

forward public pickedUp();
forward public checkCombination( match{64} );
forward public printName( x, y, z, color)
forward public exists();

new name{64};
new description{100};
new combinations[64][combineOption]
new combination_count = 0;
new id = -1;

new show_on_pickup = false;

public string_id = 0;

SetCombination( clueName{}, clue{}, locationName{}, lx, ly, removeEntity = false )
{
	if ( combination_count < 63 )
	{
		StringCopy( combinations[combination_count].matchingClue, clueName );
		StringCopy( combinations[combination_count].newClue, clue );
		StringCopy( combinations[combination_count].location, locationName );
		combinations[combination_count].location_grid = lx + (ly*8);
		combinations[combination_count].remove = removeEntity;
		combination_count++;
	}
}

public exists()
{
	return 99;
}

public printName(x, y, z, color)
{
	GraphicsDraw( name, TEXT, x, y, z, 0, 0, color );
	return StringLength( name ) * 8;
}

public pickedUp()
{
	EntityPublicFunction( __MAIN_ENTITY__, "ShowMsg", [ ARG_STRING, ARG_END], description );
}

public checkCombination( match{64} )
{
	if (combination_count > 0 && combination_count < 64 )
	{
		for ( new i = 0; i < combination_count; i++ )
		{
			if ( StringEqual( match, combinations[i].matchingClue ) )
			{

 				if ( combinations[i].newClue )
				{
					EntityPublicFunction( __MAIN_ENTITY__, "ShowMsg", [ARG_STRING, ARG_END], "New Clue Found" );
					EntityCreate(combinations[i].newClue, combinations[i].newClue, 1, 1, 1, GLOBAL_MAP);
				}
				else if ( combinations[i].location )
				{
					EntityPublicFunction( __MAIN_ENTITY__, "ShowMsg", [ARG_STRING, ARG_END], "New Location Discovered" );
					EntityPublicFunction( MENU_ENTITY, "unlockLocation", [ARG_STRING, ARG_NUMBER, ARG_NUMBER, ARG_END], combinations[i].location, combinations[i].location_grid % 64, combinations[i].location_grid / 64 );
				}	

				if ( combinations[i].remove )
				{
					EntityDelete( combinations[i].matchingClue );
					EntityDelete();
				}

				return true;
			}
		}
	}
	EntityPublicFunction( __MAIN_ENTITY__, "ShowMsg", [ARG_STRING, ARG_END], "No Match" );
	return false;
}



main()
{
	
}

