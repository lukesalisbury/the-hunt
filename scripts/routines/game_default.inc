

#define TYPE_CLUE 1
#define TYPE_CLUEALERT 2
#define TYPE_PLAYER 3
#define TYPE_CLUEUSE 4
#define TYPE_CLUEEVENT 5
#define TYPE_EVENTMSG 6



#define PLAYRENTITY	"tom"
#define AGENTENTITY	"jerry"
#define TRANSENTITY	"transition"
#define MENUSENTITY	"menu"


stock SetEntityTarget( nsection[], ngridx, ngridy )
{
	EntityPublicFunction(TRANSENTITY, "SetTarget", "snn", nsection, ngridx, ngridy );
}


stock AllowPlayerMovement( able )
{
	EntityPublicFunction(PLAYRENTITY, "ableMovement", "n", able );
}

//Mokoi Gaming 0.93a Bug
stock StringClear(str[], s = sizeof(str) )
{
	for (new c = 0;c < s ;c++ )
	{
		str[c] = 0;
	}

}