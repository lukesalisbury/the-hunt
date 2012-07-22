main()
{
	
}


public Init( ... )
{
	new Fixed:x, Fixed:y, Fixed:z;
	new obj = -1;
	EntitySetPosition(x,y,z);
	EntityPublicVariableSet("__map__", "entry_x", fround(x) );
	EntityPublicVariableSet("__map__", "entry_y", fround(y) );
	obj = EntityGetNumber("object-id");


	ObjectEffect(object:obj, 0xffffff55);
}