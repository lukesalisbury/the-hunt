
new Fixed:_x_, Fixed:_y_, Fixed:_z_;
new object:obj = object:-1;

new hotSpotX,hotSpotY;


public Init( ... )
{
	EntityGetPosition(_x_, _y_, _z_);
	obj = object:EntityGetNumber("object-id");
	
	// Get Hotspot info
	new dx = fround(_x_);
	new dy = fround(_y_);
	new w, h;
	ObjectInfo(obj, w, h);

	dx += w/2; // center point.

	hotSpotX = dx - (w - 16)/2;
	hotSpotY = dy + (h - 8);

}


main()
{

	
	CollisionSet(SELF, 0, TYPE_CLUE, hotSpotX, hotSpotY, 16, 16 );
	CollisionSet(SELF, 1, TYPE_CLUEALERT, hotSpotX - 64, hotSpotY - 64, 128, 128  );


}
