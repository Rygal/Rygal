// Copyright (C) 2012 Robert Böhm, Christopher Kaster
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
 * <h2>Description</h2>
 * <p>
 *  This class holds the most used color keys.
 * </p>
 * 
 * <h2>Example</h2>
 * <code>
 * screen.drawString(font, "IM IN SPACE!", Color.RED, 10, 10);
 * </code>
 * 
 * @author Christopher Kaster
 * @author Robert Böhm
 */
class Color {
    
    public static inline var ALICE_BLUE:Int = 0xF0F8FF;
    public static inline var ANTIQUE_WHITE:Int = 0xFAEBD7;
    public static inline var AQUA:Int = 0x00FFFF;
    public static inline var AQUAMARINE:Int = 0x7FFFD4;
    public static inline var AZURE:Int = 0xF0FFFF;
    public static inline var BEIGE:Int = 0xF5F5DC;
    public static inline var BISQUE:Int = 0xFFE4C4;
    public static inline var BLACK:Int = 0x000000;
    public static inline var BLANCHED_ALMOND:Int = 0xFFEBCD;
    public static inline var BLUE:Int = 0x0000FF;
    public static inline var BLUE_VIOLET:Int = 0x8A2BE2;
    public static inline var BROWN:Int = 0xA52A2A;
    public static inline var BURLY_WOOD:Int = 0xDEB887;
    public static inline var CADET_BLUE:Int = 0x5F9EA0;
    public static inline var CHARTREUSE:Int = 0x7FFF00;
    public static inline var CHOCOLATE:Int = 0xD2691E;
    public static inline var CORAL:Int = 0xFF7F50;
    public static inline var CORN_SILK:Int = 0xFFF8DC;
    public static inline var CORNFLOWER_BLUE:Int = 0x6495ED;
    public static inline var CRIMSON:Int = 0xDC143C;
    public static inline var CYAN:Int = 0x00FFFF;
    public static inline var DARK_BLUE:Int = 0x00008B;
    public static inline var DARK_CYAN:Int = 0x008B8B;
    public static inline var DARK_GOLDEN_ROD:Int = 0xB8860B;
    public static inline var DARK_GRAY:Int = 0xA9A9A9;
    public static inline var DARK_GREEN:Int = 0x006400;
    public static inline var DARK_KHAKI:Int = 0xBDB76B;
    public static inline var DARK_MAGENTA:Int = 0x8B008B;
    public static inline var DARK_OLIVE_GREEN:Int = 0x556B2F;
    public static inline var DARK_ORANGE:Int = 0xFF8C00;
    public static inline var DARK_ORCHID:Int = 0x9932CC;
    public static inline var DARK_RED:Int = 0x8B0000;
    public static inline var DARK_SALMON:Int = 0xE9967A;
    public static inline var DARK_SEA_GREEN:Int = 0x8FBC8F;
    public static inline var DARK_SLATE_BLUE:Int = 0x483D8B;
    public static inline var DARK_SLATE_GRAY:Int = 0x2F4F4F;
    public static inline var DARK_TURQUIOSE:Int = 0x00CED1;
    public static inline var DARK_VIOLET:Int = 0x9400D3;
    public static inline var DEEP_PINK:Int = 0xFF1493;
    public static inline var DEEP_SKY_BLUE:Int = 0x00BFFF;
    public static inline var DIM_GRAY:Int = 0x696969;
    public static inline var DODGER_BLUE:Int = 0x1E90FF;
    public static inline var FIREBRICK:Int = 0xB22222;
    public static inline var FLORAL_WHITE:Int = 0xFFFAF0;
    public static inline var FOREST_GREEN:Int = 0x228B22;
    public static inline var FUCHSIA:Int = 0xFF00FF;
    public static inline var GAINSBORO:Int = 0xDCDCDC;
    public static inline var GHOST_WHITE:Int = 0xF8F8FF;
    public static inline var GOLD:Int = 0xFFD700;
    public static inline var GOLDEN_ROD:Int = 0xDAA520;
    public static inline var GRAY:Int = 0x808080;
    public static inline var GREEN:Int = 0x008000;
    public static inline var GREEN_YELLOW:Int = 0xADFF2F;
    public static inline var HONEY_DEW:Int = 0xF0FFF0;
    public static inline var HOT_PINK:Int = 0xFF69B4;
    public static inline var INDIAN_RED:Int = 0xCD5C5C;
    public static inline var INDIGO:Int = 0x4B0082;
    public static inline var IVORY:Int = 0xFFFFF0;
    public static inline var KHAKI:Int = 0xF0E68C;
    public static inline var LAVENDER:Int = 0xE6E6FA;
    public static inline var LAVENDER_BLUSH:Int = 0xFFF0F5;
    public static inline var LAWN_GREEN:Int = 0x7CFC00;
    public static inline var LEMON_CHIFFON:Int = 0xFFFACD;
    public static inline var LIGHT_BLUE:Int = 0xADD8E6;
    public static inline var LIGHT_CORAL:Int = 0xF08080;
    public static inline var LIGHT_CYAN:Int = 0xE0FFFF;
    public static inline var LIGHT_GOLDEN_ROD_YELLOW:Int = 0xFAFAD2;
    public static inline var LIGHT_GRAY:Int = 0xD3D3D3;
    public static inline var LIGHT_GREEN:Int = 0x90EE90;
    public static inline var LIGHT_PINK:Int = 0xFFB6C1;
    public static inline var LIGHT_SALMON:Int = 0xFFA07A;
    public static inline var LIGHT_SEA_GREEN:Int = 0x20B2AA;
    public static inline var LIGHT_SKY_BLUE:Int = 0x87CEFA;
    public static inline var LIGHT_SLATE_GRAY:Int = 0x778899;
    public static inline var LIGHT_STEEL_BLUE:Int = 0xB0C4DE;
    public static inline var LIGHT_YELLOW:Int = 0xFFFFE0;
    public static inline var LIME:Int = 0x00FF7F;
    public static inline var LIME_GREEN:Int = 0x32CD32;
    public static inline var LINEN:Int = 0xFAF0E6;
    public static inline var MAGENTA:Int = FUCHSIA;
    public static inline var MAROON:Int = 0x800000;
    public static inline var MEDIUM_AQUA_MARINE:Int = 0x66CDAA;
    public static inline var MEDIUM_BLUE:Int = 0x0000CD;
    public static inline var MEDIUM_ORCHID:Int = 0xBA55D3;
    public static inline var MEDIUM_PURPLE:Int = 0x9370D8;
    public static inline var MEDIUM_SEA_GREEN:Int = 0x3CB371;
    public static inline var MEDIUM_SLATE_BLUE:Int = 0x7B68EE;
    public static inline var MEDIUM_SPRING_GREEN:Int = 0x00FA9A;
    public static inline var MEDIUM_TURQUOISE:Int = 0x48D1CC;
    public static inline var MEDIUM_VIOLET_RED:Int = 0xC71585;
    public static inline var MIDNIGHT_BLUE:Int = 0x191970;
    public static inline var MINT_CREAM:Int = 0xF5FFFA;
    public static inline var MISTY_ROSE:Int = 0xFFE4E1;
    public static inline var MOCCASIN:Int = 0xFFE4B5;
    public static inline var NAVAJO_WHITE:Int = 0xFFDEAD;
    public static inline var NAVY:Int = 0x000080;
    public static inline var OLD_LACE:Int = 0xFDF5E6;
    public static inline var OLIVE:Int = 0x808000;
    public static inline var OLIVE_DRAB:Int = 0x6B8E23;
    public static inline var ORANGE:Int = 0xFFA500;
    public static inline var ORANGE_RED:Int = 0xFF4500;
    public static inline var ORCHID:Int = 0xDA70D6;
    public static inline var PALE_GOLDEN_ROD:Int = 0xEEE8AA;
    public static inline var PALE_GREEN:Int = 0x98FB98;
    public static inline var PALE_TURQUOISE:Int = 0xAFEEEE;
    public static inline var PALE_VIOLET_RED:Int = 0xD87093;
    public static inline var PAPAYA_WHIP:Int = 0xFFEFD5;
    public static inline var PEACH_PUFF:Int = 0xFFDAB9;
    public static inline var PERU:Int = 0xCD853F;
    public static inline var PINK:Int = 0xFFC0CB;
    public static inline var PLUM:Int = 0xDDA0DD;
    public static inline var POWDER_BLUE:Int = 0xB0E0E6;
    public static inline var PURPLE:Int = 0x800080;
    public static inline var RED:Int = 0xFF0000;
    public static inline var ROSY_BROWN:Int = 0xBC8F8F;
    public static inline var ROYAL_BLUE:Int = 0x4169E1;
    public static inline var SADDLE_BROWN:Int = 0x8B4513;
    public static inline var SALMON:Int = 0xFA8072;
    public static inline var SANDY_BROWN:Int = 0xF4A460;
    public static inline var SEA_GREEN:Int = 0x2E8B57;
    public static inline var SEA_SHELL:Int = 0xFFF5EE;
    public static inline var SIENNA:Int = 0xA0522D;
    public static inline var SILVER:Int = 0xC0C0C0;
    public static inline var SKY_BLUE:Int = 0x87CEEB;
    public static inline var SLATE_BLUE:Int = 0x6A5ACD;
    public static inline var SLATE_GRAY:Int = 0x708090;
    public static inline var SNOW:Int = 0xFFFAFA;
    public static inline var SPRING_GREEN:Int = 0x00FF7F;
    public static inline var STEEL_BLUE:Int = 0x4682B4;
    public static inline var TAN:Int = 0xD2B48C;
    public static inline var TEAL:Int = 0x008080;
    public static inline var THISTLE:Int = 0xD8BFD8;
    public static inline var TOMATO:Int = 0xFF6347;
    public static inline var TURQUOISE:Int = 0x40E0D0;
    public static inline var VIOLET:Int = 0xEE82EE;
    public static inline var WHEAT:Int = 0xF5DEB3;
    public static inline var WHITE:Int = 0xFFFFFF;
    public static inline var WHITE_SMOKE:Int = 0xF5F5F5;
    public static inline var YELLOW:Int = 0xFFFF00;
    public static inline var YELLOW_GREEN:Int = 0x9ACD32;
    
    
    /**
     * As of now, you shouldn't create an instance of this class.
     */
    private function new () { }
    
    
    /**
     * Generates the hexadecimal color value from the given parameters.
     * 
     * @param   red     The red component of the color. (0 - 255)
     * @param   blue    The blue component of the color. (0 - 255)
     * @param   green   The green component of the color. (0 - 255)
     * @param   alpha   The visibility of the color. (0 = Invisible, 1 = Solid)
     * @return  The hexadecimal representation of the color with the given
     *          parameters.
     */
    public static function fromRgba(red:Int, blue:Int, green:Int,
            alpha:Float = 1):Int {
        
        return (Std.int(alpha * 255) << 24) |
            (red << 16) |
            (green << 8) |
            (blue);
    }
    
    /**
     * Generates the hexadecimal color value from the given parameters.
     * 
     * @param   red     The red component of the color. (0 - 255)
     * @param   blue    The blue component of the color. (0 - 255)
     * @param   green   The green component of the color. (0 - 255)
     * @return  The hexadecimal representation of the color with the given
     *          parameters.
     */
    public static function fromRgb(red:Int, blue:Int, green:Int):Int {
        return (red << 16) |
            (green << 8) |
            (blue);
    }

}
