uiimagerotate
=============

(NOTE: This project is long since obsolete, and should not be used in new code. There are no doubt better ways to do this, in modern iOS programs. I have not kept up with that scene, so I have no idea how you would go about that these days.)

This project contains a category add-on for UIImage that can rotate an image to any 90-degree orientation, with or without left-to-right mirroring. It also includes a couple of UIImage scaling functions and a demo program that lets you see the result of various rotate operations.

All the code is Objective-C, and works only on iOS devices and the simulator. I used Xcode 4.3.3, but you can likely adapt it to any other version.

Once you’ve built the project, you can rotate the test image to one of four orientations by pressing the big arrows. To activate mirroring, press the button labelled “Mirrored” at the bottom. To deactivate mirroring, press the button again.

![screenshot](https://github.com/allenbrunson/uiimagerotate/raw/master/screenshots/screenshot_small.png)
