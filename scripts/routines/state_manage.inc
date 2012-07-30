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

#include <core>
native Hash(name[]);

enum localstate
{
	lsname,
	lsfunction,
	lsentry,
	lsexit
}

static lstates = 0;
static lstate[6][localstate];
static current_state = -1;


forward @MokoiGaming93BUG();
@MokoiGaming93BUG()
{	
	//BUG in FunctionCall
}


StateAdd( state_name[], state_entry[], state_exit[])
{
	if ( lstates < 6 )
	{
		lstate[lstates][lsname] = Hash(state_name);
		lstate[lstates][lsfunction] = FunctionID(state_name);
		lstate[lstates][lsexit] = FunctionID(state_exit);
		lstate[lstates][lsentry] = FunctionID(state_entry);
		lstates++;
	}

}


StateSwitch( exp = true, name[] )
{
	if ( exp )
	{
		if ( !name[0] ) // Quit State management
		{
			if ( current_state >= 0 )
				FunctionCall( lstate[current_state][lsexit] );
			current_state = -1;
			return;
		}

		new h = Hash(name);
		new next = -1;
		for( new i = 0; i < lstates; i++ )
		{
			if ( lstate[i][lsname] == h )
			{
				next = i;
			}
		}
		
		if ( next >= 0 )
		{
			if ( current_state >= 0 )
				FunctionCall( lstate[current_state][lsexit] );
			current_state = next;
			FunctionCall( lstate[current_state][lsentry] );
		}
	}
}

StateHandle( display = false )
{
	if ( current_state >= 0 )
	{
		if ( display )
		{
			DebugText("Current States: %d ( %d, %d, %d )", current_state, lstate[current_state][lsfunction], lstate[current_state][lsentry], lstate[current_state][lsexit]);
		}
		FunctionCall( lstate[current_state][lsfunction] );
	}
}
