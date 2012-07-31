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

#include <clue>



public Init( ... )
{
	name = "Test Clue";
	description = "Picked up test clue";
	SetCombination("item_test2_clue", "", "Test", 2, 2, true);
	string_id = ITEM_WALLET_YOURS;
	show_on_pickup = true;

}

public Close()
{

}
