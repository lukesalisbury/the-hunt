
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

StateSwitch( exp, state_name[] )
{
	if ( exp )
	{
		if ( !state_name[0] ) // Quit State management
		{
			if ( current_state )
				FunctionCall( lstate[current_state][lsexit] );
			current_state = -1;
			return;
		}

		new h = Hash(state_name);
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
	DebugText("Current States: %d", FunctionID("@MokoiGaming93BUG") );
	if ( current_state >= 0 )
	{
		if ( display )
		{
			DebugText("Current States: %d ( %d, %d, %d )", current_state, lstate[current_state][lsfunction], lstate[current_state][lsentry], lstate[current_state][lsexit]);
		}
		FunctionCall( lstate[current_state][lsfunction] );
	}
}
