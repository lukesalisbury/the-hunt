forward public pickUp();
forward public displayDescription(x,y);
forward public checkCombination( match[64] );
enum combineOption
{
	matchingId,
	newClue[64],
	locationID
}

new name[64];
new description[255];
new combinations[64][combineOption]
new combination_count = 0;
new id = -1;

GetGlobalId(clue[])
{
	return EntityPublicFunction("main", "GetClueID","s", clue);
}

RegisterGlobalId(clue[])
{
	id = EntityPublicFunction("main", "RegisterClueID","s", name);
}



NextCombination()
{
	if ( combination_count >= 63 )
		return false;
	return combinations[combination_count][matchingId];
	
}

SetCombination( clueName[], newClue, location )
{
	while ( NextCombination() )
	{
		combination_count++;
	}
	if ( combination_count < 63 )
	{
		combinations[combination_count][matchingId] = GetGlobalId(clueName);
		combinations[combination_count][newClue] = newClue;
		combinations[combination_count][locationID] = location;


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

}
