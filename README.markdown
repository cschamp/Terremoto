![](http://farm4.static.flickr.com/3465/3780079330_ff0a853cf9_o.png) 
QuakeInfo
=========

QuakeInfo is a sample iPhone application that I wrote as an exercise in iPhone programming. It has given me exposure to Objective-C 2.0, which I can't use in my day job, where we need to support older Mac OS X platforms unsupported by Obj-C 2.0. QuakeInfo also gives me a chance to learn about iPhone programming. Although I use Cocoa at work, I don't write iPhone code, and, as mentioned above, supporting older Mac OS X versions means that I don't often have a chance to use the latest features in Cocoa. 

[![](http://farm4.static.flickr.com/3566/3779173249_914199a9a4.jpg)](http://farm4.static.flickr.com/3566/3779173249_07a6c21212_o.png)
[![](http://farm4.static.flickr.com/3470/3779173293_062292f34c.jpg)](http://farm4.static.flickr.com/3470/3779173293_721cbe7ea5_o.png)
[![](http://farm4.static.flickr.com/3450/3779982324_60bb869592.jpg)](http://farm4.static.flickr.com/3450/3779982324_97d22cdc2e_o.png) 


Implementation Overview
=======================

This iPhone OS 3.0 application uses the NSXMLParser to fetch and parse earthquake information from the USGS web site. It then plots the earthquakes on a world map using MapKit.

There are several similar apps on the web and in the app store. Apple has sample code to show the use of the NSXMLParser, but that code displays the earthquakes in arbitrary order in a UITableView. At least two apps at the iPhone app store are identical copies of this sample code and list for $0.99. I guess that makes the developers some kind of expert iPhone programmers.

Another similar application is from [Bill Dudney's](http://bill.dudney.net/roller/objc/) screencast and [sample code at Pragmatic Programmers](http://www.pragprog.com/screencasts/v-bdmapkit/using-map-kit/). The code in QuakeInfo (my application) uses Dudney's XML parser code almost verbatim at present. My view controller is similar to Dudney's, since I learned from his code and there are only so many ways to code this up, although over time my view controller code has taken its own direction.

Among the ways my app, QuakeInfo, differs from Dudney's is that QuakeInfo displays all earthquake events fetched from the USGS site, not just the 50 or 100 nearest to the user's location. This requires changes in the way QuakeInfo zooms to the user's current location, among other things. My application also displays details about the earthquake in a UIWebView within the application, whereas Dudney's demo app displayed this information by launching Safari on a USGS URL.

I plan to show earthquakes on the map using a custom annotation view to resemble the maps on the USGS web site itself, where events are displayed not as color-coded pins, but as squares of varying sizes and colors. I also want to add a control to allow the user to zoom to the current location at any time. Another feature I plan to add is one that will show the most recent earthquakes first, perhaps making a recent earthquake the initial zoom location, or perhaps adding a view that shows the earthquakes in a list sorted by time of the event or by magnitude.


*Craig Schamp*

