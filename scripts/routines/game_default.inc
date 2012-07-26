

#define TYPE_CLUE 1
#define TYPE_CLUEALERT 2
#define TYPE_PLAYER 3
#define TYPE_CLUEUSE 4
#define TYPE_CLUEEVENT 5


#define PLAYRENTITY	"tom"
#define AGENTENTITY	"jerry"
#define TRANSENTITY	"transition"
#define MENUSENTITY	"menu"


stock SetEntityTarget( nsection[], ngridx, ngridy )
{
	EntityPublicFunction(TRANSENTITY, "SetTarget", "snn", nsection, ngridx, ngridy );
}
