forward public pickUp();
forward public displayDescription(x,y);
forward public checkCombination( match[64] );
enum combineOption
{
	matchingClue[64],
	newClue[64],
	locationID
}

new name[64];
new description[255];
new combinations[64][combineOption]
new combination_count = 0;
new id = -1;


SetCombination( clueName[], clue[], location )
{
	if ( combination_count < 63 )
	{
		StringCopy(combinations[combination_count][matchingClue], clueName);
		StringCopy(combinations[combination_count][newClue], clue);
		combinations[combination_count][locationID] = location;
		combination_count++;
	}
}




public pickUp()
{
	EntityPublicFunction("main", "ShowMsg", "s", description );
}

public displayDescription(x,y)
{

}

public checkCombination( match[64] )
{
	if (combination_count > 0)
	{
		for ( new i = 0; i < combination_count; i++ )
		{
			if ( StringEqual( match, combinations[i][matchingClue] ) )
			{
				if ( combinations[i][newClue][0] ) 
					EntityPublicFunction("main", "ShowMsg", "s", "New Clue Found" );
				else if ( combinations[i][locationID] ) 
					EntityPublicFunction("main", "ShowMsg", "s", "New Location Discovered" );
				return true;
			}
		}
	}
	EntityPublicFunction("main", "ShowMsg", "s", "No Match" );
	return false;
}
