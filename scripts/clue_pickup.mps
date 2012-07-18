
forward public PickUp();

new Fixed:_x_, Fixed:_y_, Fixed:_z_;
new object:obj = object:-1;

new hotSpotX,hotSpotY;

new childrenEntity[64];

public Init( ... )
{
	EntityGetPosition(_x_, _y_, _z_);
	obj = object:EntityGetNumber("object-id");

	
	EntityGetSetting("clue-item", childrenEntity);
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

	DebugText("Item: %s",childrenEntity);
	CollisionSet(SELF, 0, TYPE_CLUE, hotSpotX, hotSpotY, 16, 16 );
	CollisionSet(SELF, 1, TYPE_CLUEALERT, hotSpotX - 64, hotSpotY - 64, 128, 128  );


}


public PickUp()
{
	if ( childrenEntity[0] )
	{
		EntityCreate(childrenEntity, childrenEntity, 1, 1, 1, GLOBAL_MAP, 64, "");
		EntityPublicFunction(childrenEntity, "pickUp", "" );
	}
	
	EntityDelete();
}

