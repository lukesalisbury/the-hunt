forward public ShowMsg( str[] );

new gstate = 1;
new msgStr[64];
new screenWidth, screenHeight;

public Init( ... )
{
	gstate  = GameState(gstate);
	screenWidth = MiscGetWidth("__screen__")/2;
	screenHeight = MiscGetHeight("__screen__")/2;
}


main()
{
	if ( msgStr[0] )
	{
		new msgLen = StringLength(msgStr)*4;
		GraphicsDraw("", RECTANGLE, screenWidth - msgLen, screenHeight - 8, 5, (msgLen*2) + 4, 20,RED);
		GraphicsDraw(msgStr, TEXT,  screenWidth - msgLen +2, screenHeight - 6, 5, 0,0,WHITE);
	}
}


public ShowMsg( str[] )
{
	StringCopy(msgStr,str);

}

