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

forward public Play();

new Fixed:x, Fixed:y, Fixed:z;
new w, h;
new event;
new watch;
new msg = -1;

public Init( ... )
{
	new obj = -1;

	event = EntityGetNumber("event");
	msg = EntityGetNumber("message");
	obj = EntityGetNumber("object-id");
	watch = EntityGetSettingHash("entity_watch");

	EntityGetPosition(x,y,z);
	ObjectInfo(object:obj, w, h);
	ObjectEffect(object:obj, 0x55005555);

	MaskFill( fround(x),fround(y), w, h,200);
	CollisionSet(SELF, 0, event, fround(x)-8,fround(y)-8, w+16, h+16  );
}


public Close()
{
	MaskFill( fround(x),fround(y), w, h,0);
}


public Play()
{
	DialogShow(msg);
	CollisionSet(SELF, 0 );
}


main()
{
	if ( watch )
	{
		if ( EntityPublicFunction(watch, "exists", "") == 99 )
		{
			EntityDelete();
		}
	}
}

