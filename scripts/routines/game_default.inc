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

#define TYPE_CLUE 1
#define TYPE_CLUEALERT 2
#define TYPE_PLAYER 3
#define TYPE_CLUEUSE 4
#define TYPE_CLUEEVENT 5
#define TYPE_EVENTMSG 6


#define PLAYRIDENT	"tom"
#define AGENTIDENT	"jerry"
#define TRANSIDENT	"transition"
#define MENU_IDENT	"menu"

stock PLAYRENTITY = 0xFFFFFFFF;
stock AGENTENTITY = 0xFFFFFFFF;
stock TRANSENTITY = 0xFFFFFFFF;
stock MENU_ENTITY = 0xFFFFFFFF;
stock MAIN_ENTITY = 0xFFFFFFFF;

public AutoPreInit()
{
	PLAYRENTITY = EntityHash( PLAYRIDENT );
	AGENTENTITY = EntityHash( AGENTIDENT );
	TRANSENTITY = EntityHash( TRANSIDENT );
	MENU_ENTITY = EntityHash( MENU_IDENT );
	MAIN_ENTITY = EntityHash( "main" );
}


stock SetEntityTarget( nsection[], ngridx, ngridy )
{
	EntityPublicFunction(TRANSENTITY, "SetTarget", ''snn'', nsection, ngridx, ngridy );
}


stock AllowPlayerMovement( able )
{
	EntityPublicFunction(PLAYRENTITY, "ableMovement", ''n'', able );
}

//Mokoi Gaming 0.93a Bug
stock StringClear(str[], s = sizeof(str) )
{
	for (new c = 0;c < s ;c++ )
	{
		str[c] = 0;
	}
}