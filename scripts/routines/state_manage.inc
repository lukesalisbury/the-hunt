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

#define LOCALSTATE[.statename, .statefunction, .entry, .exit]

#include <core>

static lstates = 0;
static lstate[6][LOCALSTATE];
static current_state = -1;


forward @MokoiGaming93BUG();
@MokoiGaming93BUG()
{	
	//BUG in FunctionCall
}


StateAdd( state_name{}, state_entry{}, state_exit{})
{
	if ( lstates < 6 )
	{
		lstate[lstates].statename = EntityHash(state_name);
		lstate[lstates].statefunction = FunctionID(state_name);
		lstate[lstates].exit = FunctionID(state_exit);
		lstate[lstates].entry = FunctionID(state_entry);
		lstates++;
	}

}


StateSwitch( exp = true, name{} )
{
	if ( exp )
	{
		if ( !name{0} ) // Quit State management
		{
			if ( current_state >= 0 )
				FunctionCall( lstate[current_state].exit );
			current_state = -1;
			return;
		}

		new h = EntityHash(name);
		new next = -1;
		for( new i = 0; i < lstates; i++ )
		{
			if ( lstate[i].statename == h )
			{
				next = i;
			}
		}
		
		if ( next >= 0 )
		{
			if ( current_state >= 0 )
				FunctionCall( lstate[current_state].exit );
			current_state = next;
			FunctionCall( lstate[current_state].entry );
		}
	}
}

StateHandle( display = false )
{
	if ( current_state >= 0 )
	{
		if ( display )
		{
			DebugText("Current States: %d ( %d, %d, %d )", current_state, lstate[current_state].statefunction, lstate[current_state].entry, lstate[current_state].exit );
		}
		FunctionCall( lstate[current_state].statefunction );
	}
}
