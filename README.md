[Rygal](http://rygal.org)
======================================

Rygal is a free open source engine for games using haXe & NME.
Rygal is licensed under the terms of the GNU Lesser General
Public License (LGPL).


Supported platforms
----------------------------------------------

Even though Rygal uses haXe with NME, not every platform is (yet)
supported:

 - **Flash:** Fully supported & tested (Only platform with Multi-Game support)
 - **C++:** Fully supported & tested (Tested on *Windows x86* target)
 - **HTML 5:** Restricted support:
  - Zoom is not working properly (Smoothing can't be disabled)
  - Embedded fonts are not working properly (Due to [the way they work with jeash](http://haxe.org/com/libs/jeash/embedfont))
  - Storage is not supported
 - **Everything else:** Not tested yet

Sometimes, features of the *latest* branch aren't tested on every
platform, while on the other hand, sometimes there are features
that are already in the *stable* branch without support for some
platforms that have just been implemented in the *latest* branch.

To sum up, you could try another branch if something doesn't
work on a platform you'd like to use ;)


Can I have more information about the license?
----------------------------------------------

The LGPL, under which this project is licensed, makes Rygal
free to use in your project, even if they may be with commercial
purposes.

You may ask, why the engine uses LGPL instead of GPL, well the
reason is very simple, projects that are licensed under the
terms of GPL aren't allowed to be used - even as a library - in
projects that are using other licenses than GPL. The LGPL gives
you the right to use this library in your project, no matter
under which license your project is.


What is the engine built on?
----------------------------

The engine is made using haXe & NME.


Questions?
----------

If you have any questions, feel free to ask me per [mail](mailto:robert.boehm94@gmail.com)
or write me a [message on GitHub](https://github.com/inbox/new/rynti) 
