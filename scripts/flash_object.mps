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

new obj = -1;
new Fixed:t = 255.0;
new up = 0;

SetColourBits( &v, n, p )
{
	new sn = clamp( n, 0, 255);
	v |= (sn << p);
}

public Init( ... )
{
	obj = EntityGetNumber("object-id");
}

public Close() { }

main()
{
	if (up)
		t += GameFrame2() * 200.0;
	else
		t -= GameFrame2() * 200.0;

	if ( t >= 255.0 || t <= 0)
		up = !up;

	new acolor = 0xFFFFFF00 | clamp( fround(t), 0, 255);
	ObjectEffect( object:obj, acolor );

}
