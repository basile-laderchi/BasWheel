BasWheel [![Project Status](http://stillmaintained.com/basile-laderchi/BasWheel.png)](http://stillmaintained.com/basile-laderchi/BasWheel)
========
LEGO Technic axle compatibility tested out ok by Gareth Chiprobot (http://letsmakerobots.com/user/2941, http://www.thingiverse.com/Chiprobot).

Ideas from http://www.thingiverse.com/thing:21486, http://www.thingiverse.com/thing:17514 and http://www.thingiverse.com/thing:5713  
The servohead cutout is based on http://www.thingiverse.com/thing:28566

The OpenSCAD Parts Library (http://www.thingiverse.com/thing:6021) is needed. (not included)  
The Lego axle size 2 (http://www.thingiverse.com/thing:66884) is needed. (not included)  
The Parametric servo arms (http://www.thingiverse.com/thing:28566) is not needed. (code parts included)

v 1.26,  4 Jun 2014 : Added hub\_type "hex" and parameter hex\_size  
v 1.25, 14 Mar 2014 : Added spoke\_type "dxf" and parameter dxf\_filename  
v 1.24, 25 Feb 2014 : Added parameters tire\_compatibility and flip\_wheel  
v 1.23, 14 Jan 2014 : Fixed bug with parameter outer\_thickness  
v 1.22,  3 Jan 2014 : Added parameter wheel\_extra\_height  
v 1.21,  2 Jan 2014 : Added parameters servo\_hole\_ID and servo\_hole\_OD  
v 1.20, 24 Dec 2013 : Added hub\_type "legoturntable"  
v 1.19, 29 Nov 2013 : Changed license from CC BY-NC-SA 3.0 to CC BY-NC-SA 4.0 and added comments to parameters  
v 1.18, 26 Nov 2013 : Removed parameter slot\_height  
v 1.17, 20 Nov 2013 : Changed license from CC BY-SA 3.0 to CC BY-NC-SA 3.0 and added hub\_type "hubattachment"  
v 1.16, 18 Nov 2013 : Added hub\_type "stepper" (built to match stepper type 28BYJ-48)  
v 1.15, 18 Sep 2013 : Added hub\_type "servohead"  
v 1.14, 23 July 2013 : Added magnet\_diameter (used if you need holes for neodymium magnets on the servo\_hub) and magnet\_offset parameters  
v 1.13, 18 July 2013 : Added hub\_type "no" used for push-fit axles  
v 1.12, 18 July 2013 : Added spoke\_type "spring", spring\_segments variable, changed "double\_left" to "spiral\_left\_double", "double\_right" to "spiral\_right\_double", "left" to "spiral\_left" and "right" to "spiral\_right"  
v 1.11, 19 June 2013 : Added small spacing between double spokes  
v 1.10, 18 June 2013 : Fixed hub high for the screw to be able to be bolted  
v 1.09, 6 June 2013: Added hub\_type "lego" and added all the variables on top of the file (Customizer ready - not working yet due to imported libraries and external stl file)  
v 1.08, 5 June 2013: Added support from spoke to wheel  
v 1.07, 31 May 2013: Fix servo hub (added a small distance between the main hub and the servo hub)  
v 1.06, 29 May 2013: Added servo hub  
v 1.05, 27 May 2013: $fn deleted from file and included in function call  
v 1.04, 24 May 2013: Added spoke\_type "double\_right", changed "both" to "double\_left"  
v 1.03, 23 May 2013: Added parameter Screw\_size and calculation of hub based on it  
v 1.02, 22 May 2013: Screw shaft  
v 1.01, 21 May 2013: Rim added  
v 1.00, 20 May 2013: Initial release
