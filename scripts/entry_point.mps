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


main()
{
	
}


public Init( ... )
{
	new Fixed:x, Fixed:y, Fixed:z;
	new obj = -1;
	EntityGetPosition(x,y,z);
	EntityPublicVariableSet("__map__", "entry_x", fround(x) );
	EntityPublicVariableSet("__map__", "entry_y", fround(y) );
	obj = EntityGetNumber("object-id");


	ObjectEffect(object:obj, 0xffffff55);
}