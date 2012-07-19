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

main() {}

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




}



public Clues()
{
	if ( InputButton(6) ==1 ) // Enter pressed
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
	//GraphicsDraw(enityt, TEXT, 24,24+(20*i), 6, 0,0, menuSelect == i ? 0xFF3333FF : 0xFFFFFFFF);
	
	if ( InputButton(7) == 1 )
		menuSelect--;
	else if ( InputButton(8) == 1 )
		menuSelect++;

	menuSelect %= clueCount+1;
	

	return 0;
}


public Travel()
{
	new files[20][64];
	FileGetList(files, "sections");
	new fileCount = 0;
	for ( ; fileCount < 20; fileCount++ )
	{
		if ( files[fileCount][0] )
		{
			new w = StringFind( files[fileCount], "." );
			if (w > 2 )
				files[fileCount][w] = 0;
		}
		else 
		{
			break;
		}	
	}	


	if ( InputButton(6) ==1 ) // Enter pressed
	{
		if ( menuSelect == 0 )
			return 2;
		else if ( menuSelect > 0 )
		{
			//files[menuSelect-1]
			
			EntityPublicFunction("transition", "SetTarget", "sssnn", "tom", "", files[menuSelect-1], 0,0);
			return 1;
		}

	}

	GraphicsDraw("", RECTANGLE, 16,16, 6, 288,320, 0x00000099);
	GraphicsDraw("Return", TEXT, 24,24, 6, 0,0, menuSelect == 0 ? 0xFF3333FF : 0xFFFFFFFF);

	for ( new n = 0; n < 20; n++ )
	{
		if ( files[n][0] )
		{
			GraphicsDraw(files[n], TEXT, 24,44+(20*n), 6, 0,0, menuSelect == n+1 ? 0xFF3333FF : 0xFFFFFFFF);
		}	
	}	
	if ( InputButton(7) == 1 )
		menuSelect--;
	else if ( InputButton(8) == 1 )
		menuSelect++;

	menuSelect %= 20;


	return 0;
}

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
	
	if ( InputButton(7) == 1 )
		menuSelect--;
	else if ( InputButton(8) == 1 )
		menuSelect++;

	menuSelect %= 3;


	return 0;
}
