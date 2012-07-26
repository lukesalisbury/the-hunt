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
 *  You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). 
 *  You may not use this work for commercial purposes.
 * Full terms of use: http://creativecommons.org/licenses/by-nc/3.0/

 ***********************************************/
forward public PickUp();




new Fixed:_x_, Fixed:_y_, Fixed:_z_;
public object:obj = object:-1;

new hotSpotX,hotSpotY;

new childrenEntity[64];

public Init( ... )
{
	obj = object:EntityGetNumber("object-id");

	EntityGetPosition(_x_, _y_, _z_);
	EntityGetSetting("clue-item", childrenEntity);

	// childrenEntity has the extension, so remove it.
	new q = StringFind( childrenEntity, "." );
	if (q > 2 )
		childrenEntity{q} = 0;

	// Get Hotspot info
	new dx = fround(_x_);
	new dy = fround(_y_);
	new w, h;
	ObjectInfo(obj, w, h);

	dx += w/2; // center point.

	hotSpotX = dx - (w - 16)/2;
	hotSpotY = dy + (h - 8);

}

public Close()
{
	CollisionSet(SELF, 0);
	CollisionSet(SELF, 1);
}

main()
{
	CollisionSet(SELF, 0, TYPE_CLUE, hotSpotX, hotSpotY, 16, 16 );
	CollisionSet(SELF, 1, TYPE_CLUEALERT, hotSpotX - 64, hotSpotY - 64, 128, 128  );
}


public PickUp()
{
	if ( childrenEntity[0] )
	{
		EntityCreate(childrenEntity, childrenEntity, 1, 1, 1, GLOBAL_MAP, 64, "");
		EntityPublicFunction(childrenEntity, "pickedUp", "" );
	}
	
	EntityDelete();
}

