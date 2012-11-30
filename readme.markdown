inkexport
=========

inkexport is a batch export tool for iOS developers, using Inkscape.
To add a few information for your SVG, you can export all PNG files, including Retina images (@2x), at one time.

Prepare - Inkscape
------------------

1. Run Inkscape, and create SVG file.
2. Add `export` layer for export.
3. Add rectangles to `export` layer as export area.
4. Select a rectangle, and choose `Object > Object Properties`.
5. Input an export file name to `Label` field, except file extension.
6. Press `Apply` button.
7. Finally, set `Opacity` of `export` layer to `0%`.
8. Save your SVG file.

Run
---

Open a terminal, and run the command as follows.

	$ inkexport -f [SVG file] -o [output dir]

