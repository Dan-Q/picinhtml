A Ruby application to "hide images within plain sight". Given an image file and a text file as inputs,
produces (on standard output) a HTML file which at a glance appears to contain the monospaced text
from the text file. However, when the text is selected with the cursor, the image becomes apparent.
The image is encoded in CSS as a series of rgb() values on ::selected selectors (with ::-moz-selected
selectors for compatability with Firefox).

Prerequisites:

* Requires the RMagick gem to be installed. You're on your own with that.

Usage:

 ruby picinhtml.rb image-file text-file posterization-level

Usage example:

 ruby picinhtml.rb my-cat.jpg magna-carta.txt 20 > output.html

Samples:

Two sample images, text files, and their outputs are included in the examples directory.

 * Example 1 is a GIF file containing a splash of colour, mapped onto the book of Genesis.
 * Example 2 is a JPG file containing a picture of a lifeboatman, mapped onto the terms and conditions of a software company.

Recommendations:

 * This application produces monsterously huge HTML files. Keep your image files small to minimize their enormity. As a maximum, I suggest no more than 10,000 pixels (100x100), or else the resulting output is liable to crash web browsers.
 * The tool optimises for color reuse. The LOWER the posterization-level, the smaller and simpler the output file, but the fewer colors used: try starting with 20 for photos, 10 for logos/line art, and adapting as necessary.

License:

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
