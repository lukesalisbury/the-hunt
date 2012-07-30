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


new sheet[64];
new sprite[64];
new replace[64];

new obj = -1;
new Fixed:timer = 0.0;


public Init( ... )
{
	new image[128];

	obj = EntityGetNumber("object-id");

	EntityGetSetting("object-image", image);
	EntityGetSetting("last-frame", replace);


	new i = StringFind(image,":");
	StringExtract( sheet, image, 0, i );
	StringExtract( sprite, image, i+1, StringLength(image) );



	timer = AnimationGetLength2(sheet, sprite) - 0.1;

}




main()
{
	
	timer -= GameFrame2();
	if (timer <= 0.0)
	{
		if ( replace[0] )
		{
			ObjectReplace( object:obj, replace, SPRITE );
		}
		else
		{
			ObjectDelete( object:obj );
		}
		EntityDelete();
	}


}
