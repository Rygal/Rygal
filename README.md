[Rygal](http://rygal.org)
=========================

Rygal is a free open source engine for games using haXe & NME and licensed under
the terms of the GNU Lesser General Public License (LGPL).


Getting started
---------------

I strongly recommend looking into the
[Rygal wiki](https://github.com/rynti/Rygal/wiki) if you need help to get
started, as it provides a lot of information about the
[setup](https://github.com/rynti/Rygal/wiki/Setup-guide) and links that may
be interesting to you like
[demo projects](https://github.com/rynti/Rygal/wiki/Demo-projects) or the
[documentation](http://docs.rygal.org).


Supported platforms
-------------------

Even though Rygal uses haXe with NME, not every platform is (yet)
fully supported:

<table>
	<tr>
		<th>Platform</th>
		<th>Supported</th>
		<th>Zooming</th>
		<th>Embedded fonts</th>
		<th>Storage</th>
	</tr>
	<tr>
		<td>Flash</td>
		<td>Yes</td>
		<td>Yes</td>
		<td>Yes</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>Windows<sup>[1]</sup></td>
		<td>Yes</td>
		<td>Yes</td>
		<td>Yes</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>OS X<sup>[2]</sup></td>
		<td>Yes</td>
		<td>Yes</td>
		<td>Yes</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>Linux<sup>[3]</sup></td>
		<td>Yes</td>
		<td>Yes</td>
		<td>Yes</td>
		<td>No</td>
	</tr>
	<tr>
		<td>iOS</td>
		<td>Yes</td>
		<td>Yes</td>
		<td>Yes</td>
		<td>Yes</td>
	</tr>
	<tr>
		<td>HTML 5</td>
		<td>No<sup>[4]</sup></td>
		<td>Partially<sup>[5]</sup></td>
		<td>No<sup>[6]</sup></td>
		<td>No</td>
	</tr>
</table>

<sup>[1]</sup>: Tested with *Windows x86* target<br />
<sup>[2]</sup>: Tested on *Intel Macs*.<br/>
<sup>[3]</sup>: Tested on *Ubuntu 12.04 32bit*.<br/>
<sup>[4]</sup>: Unless either clipRect in the draw()-method or alpha in the copyPixels()-method is working, I can't support it.<br />
<sup>[5]</sup>: Smoothing can't be disabled with jeash<br />
<sup>[6]</sup>: Due to [the way embedded fonts work with jeash](http://haxe.org/com/libs/jeash/embedfont)


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

The engine is written in haXe and based on NME.


Questions?
----------

If you have any questions, feel free to ask me per [mail](mailto:robert.boehm94@gmail.com).
