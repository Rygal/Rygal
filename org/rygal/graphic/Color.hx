// 
// This file is part of Rygal.
// 
// Rygal is free software: you can redistribute it and/or modify it under the
// terms of the GNU Lesser General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
// 
// Rygal is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
// more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with Rygal. If not, see: <http://www.gnu.org/licenses/>.


package org.rygal.graphic;

/**
 * ...
 * @author Christopher Kaster
 */
class Color {
	// sorted by hex value
	public static var BLACK:Int = 0x000000;
	public static var NAVY:Int = 0x000080;
	public static var DARK_BLUE:Int = 0x00008B;
	public static var MEDIUM_BLUE:Int = 0x0000CD;
	public static var BLUE:Int = 0x0000FF;
	public static var DARK_GREEN:Int = 0x006400;
	public static var GREEN:Int = 0x008000;
	public static var TEAL:Int = 0x008080;
	public static var DARK_CYAN:Int = 0x008B8B;
	public static var DEEP_SKY_BLUE:Int = 0x00BFFF;
	public static var DARK_TURQUIOSE:Int = 0x00CED1;
	public static var MEDIUM_SPRING_GREEN:Int = 0x00FA9A;
	public static var LIME:Int = 0x00FF7F;
	public static var SPRING_GREEN:Int = 0x00FF7F;
	public static var AQUA:Int = 0x00FFFF;
	public static var CYAN:Int = 0x00FFFF;
	public static var MIDNIGHT_BLUE:Int = 0x191970;
	public static var DODGER_BLUE:Int = 0x1E90FF;
	public static var LIGHT_SEA_GREEN:Int = 0x20B2AA;
	public static var FOREST_GREEN:Int = 0x228B22;
	public static var SEA_GREEN:Int = 0x2E8B57;
	public static var DARK_SLATE_GRAY:Int = 0x2F4F4F;
	public static var DARK_SLATE_GREY:Int = DARK_SLATE_GRAY;
	public static var LIME_GREEN:Int = 0x32CD32;
	public static var MEDIUM_SEA_GREEN:Int = 0x3CB371;
	public static var TURQUOISE:Int = 0x40E0D0;
	public static var ROYAL_BLUE:Int = 0x4169E1;
	public static var STEEL_BLUE:Int = 0x4682B4;
	public static var DARK_SLATE_BLUE:Int = 0x483D8B;
	public static var MEDIUM_TURQUOISE:Int = 0x48D1CC;
	public static var INDIGO:Int = 0x4B0082;
	public static var DARK_OLIVE_GREEN:Int = 0x556B2F;
	public static var CADET_BLUE:Int = 0x5F9EA0;
	public static var CORNFLOWER_BLUE:Int = 0x6495ED;
	public static var MEDIUM_AQUA_MARINE:Int = 0x66CDAA;
	public static var DIM_GRAY:Int = 0x696969;
	public static var DIM_GREY:Int = DIM_GRAY;
	public static var SLATE_BLUE:Int = 0x6A5ACD;
	public static var OLIVE_DRAB:Int = 0x6B8E23;
	public static var SLATE_GRAY:Int = 0x708090;
	public static var SLATE_GREY:Int = SLATE_GRAY;
	public static var LIGHT_SLATE_GRAY:Int = 0x778899;
	public static var LIGHT_SLATE_GREY:Int = LIGHT_SLATE_GRAY;
	public static var MEDIUM_SLATE_BLUE:Int = 0x7B68EE;
	public static var LAWN_GREEN:Int = 0x7CFC00;
	public static var CHARTREUSE:Int = 0x7FFF00;
	public static var AQUAMARINE:Int = 0x7FFFD4;
	public static var MAROON:Int = 0x800000;
	public static var PURPLE:Int = 0x800080;
	public static var OLIVE:Int = 0x808000;
	public static var GRAY:Int = 0x808080;
	public static var GREY:Int = GRAY;
	public static var SKY_BLUE:Int = 0x87CEEB;
	public static var LIGHT_SKY_BLUE:Int = 0x87CEFA;
	public static var BLUE_VIOLET:Int = 0x8A2BE2;
	public static var DARK_RED:Int = 0x8B0000;
	public static var DARK_MAGENTA:Int = 0x8B008B;
	public static var SADDLE_BROWN:Int = 0x8B4513;
	public static var DARK_SEA_GREEN:Int = 0x8FBC8F;
	public static var LIGHT_GREEN:Int = 0x90EE90;
	public static var MEDIUM_PURPLE:Int = 0x9370D8;
	public static var DARK_VIOLET:Int = 0x9400D3;
	public static var PALE_GREEN:Int = 0x98FB98;
	public static var DARK_ORCHID:Int = 0x9932CC;
	public static var YELLOW_GREEN:Int = 0x9ACD32;
	public static var SIENNA:Int = 0xA0522D;
	public static var BROWN:Int = 0xA52A2A;
	public static var DARK_GRAY:Int = 0xA9A9A9;
	public static var DARK_GREY:Int = DARK_GRAY;
	public static var LIGHT_BLUE:Int = 0xADD8E6;
	public static var GREEN_YELLOW:Int = 0xADFF2F;
	public static var PALE_TURQUOISE:Int = 0xAFEEEE;
	public static var LIGHT_STEEL_BLUE:Int = 0xB0C4DE;
	public static var POWDER_BLUE:Int = 0xB0E0E6;
	public static var FIREBRICK:Int = 0xB22222;
	public static var DARK_GOLDEN_ROD:Int = 0xB8860B;
	public static var MEDIUM_ORCHID:Int = 0xBA55D3;
	public static var ROSY_BROWN:Int = 0xBC8F8F;
	public static var DARK_KHAKI:Int = 0xBDB76B;
	public static var SILVER:Int = 0xC0C0C0;
	public static var MEDIUM_VIOLET_RED:Int = 0xC71585;
	public static var INDIAN_RED:Int = 0xCD5C5C;
	public static var PERU:Int = 0xCD853F;
	public static var CHOCOLATE:Int = 0xD2691E;
	public static var TAN:Int = 0xD2B48C;
	public static var LIGHT_GRAY:Int = 0xD3D3D3;
	public static var LIGHT_GREY:Int = LIGHT_GRAY;
	public static var PALE_VIOLET_RED:Int = 0xD87093;
	public static var THISTLE:Int = 0xD8BFD8;
	public static var ORCHID:Int = 0xDA70D6;
	public static var GOLDEN_ROD:Int = 0xDAA520;
	public static var CRIMSON:Int = 0xDC143C;
	public static var GAINSBORO:Int = 0xDCDCDC;
	public static var PLUM:Int = 0xDDA0DD;
	public static var BURLY_WOOD:Int = 0xDEB887;
	public static var LIGHT_CYAN:Int = 0xE0FFFF;
	public static var LAVENDER:Int = 0xE6E6FA;
	public static var DARK_SALMON:Int = 0xE9967A;
	public static var VIOLET:Int = 0xEE82EE;
	public static var PALE_GOLDEN_ROD:Int = 0xEEE8AA;
	public static var LIGHT_CORAL:Int = 0xF08080;
	public static var KHAKI:Int = 0xF0E68C;
	public static var ALICE_BLUE:Int = 0xF0F8FF;
	public static var HONEY_DEW:Int = 0xF0FFF0;
	public static var AZURE:Int = 0xF0FFFF;
	public static var SANDY_BROWN:Int = 0xF4A460;
	public static var WHEAT:Int = 0xF5DEB3;
	public static var BEIGE:Int = 0xF5F5DC;
	public static var WHITE_SMOKE:Int = 0xF5F5F5;
	public static var MINT_CREAM:Int = 0xF5FFFA;
	public static var GHOST_WHITE:Int = 0xF8F8FF;
	public static var SALMON:Int = 0xFA8072;
	public static var ANTIQUE_WHITE:Int = 0xFAEBD7;
	public static var LINEN:Int = 0xFAF0E6;
	public static var LIGHT_GOLDEN_ROD_YELLOW:Int = 0xFAFAD2;
	public static var OLD_LACE:Int = 0xFDF5E6;
	public static var RED:Int = 0xFF0000;
	public static var FUCHSIA:Int = 0xFF00FF;
	public static var MAGENTA:Int = FUCHSIA;
	public static var DEEP_PINK:Int = 0xFF1493;
	public static var ORANGE_RED:Int = 0xFF4500;
	public static var TOMATO:Int = 0xFF6347;
	public static var HOT_PINK:Int = 0xFF69B4;
	public static var CORAL:Int = 0xFF7F50;
	public static var DARK_ORANGE:Int = 0xFF8C00;
	public static var LIGHT_SALMON:Int = 0xFFA07A;
	public static var ORANGE:Int = 0xFFA500;
	public static var LIGHT_PINK:Int = 0xFFB6C1;
	public static var PINK:Int = 0xFFC0CB;
	public static var GOLD:Int = 0xFFD700;
	public static var PEACH_PUFF:Int = 0xFFDAB9;
	public static var NAVAJO_WHITE:Int = 0xFFDEAD;
	public static var MOCCASIN:Int = 0xFFE4B5;
	public static var BISQUE:Int = 0xFFE4C4;
	public static var MISTY_ROSE:Int = 0xFFE4E1;
	public static var BLANCHED_ALMOND:Int = 0xFFEBCD;
	public static var PAPAYA_WHIP:Int = 0xFFEFD5;
	public static var LAVENDER_BLUSH:Int = 0xFFF0F5;
	public static var SEA_SHELL:Int = 0xFFF5EE;
	public static var CORN_SILK:Int = 0xFFF8DC;
	public static var LEMON_CHIFFON:Int = 0xFFFACD;
	public static var FLORAL_WHITE:Int = 0xFFFAF0;
	public static var SNOW:Int = 0xFFFAFA;
	public static var YELLOW:Int = 0xFFFF00;
	public static var LIGHT_YELLOW:Int = 0xFFFFE0;
	public static var IVORY:Int = 0xFFFFF0;
	public static var WHITE:Int = 0xFFFFFF;

	private function new () {
	}

}
