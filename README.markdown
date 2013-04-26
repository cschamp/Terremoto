![](http://farm4.static.flickr.com/3465/3780079330_ff0a853cf9_o.png) 
Terremoto
=========

[Terremoto is now on the App Store](http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=326157784&mt=8).

Terremoto is a sample iPhone application that I wrote as an exercise in iPhone programming.

[![](http://farm4.static.flickr.com/3566/3779173249_914199a9a4.jpg)](http://farm4.static.flickr.com/3566/3779173249_07a6c21212_o.png)
[![](http://farm4.static.flickr.com/3470/3779173293_062292f34c.jpg)](http://farm4.static.flickr.com/3470/3779173293_721cbe7ea5_o.png)
[![](http://farm4.static.flickr.com/3450/3779982324_60bb869592.jpg)](http://farm4.static.flickr.com/3450/3779982324_97d22cdc2e_o.png) 


Implementation Overview
=======================

This iOS 6 application uses NSXMLParser to fetch and parse earthquake information from the USGS web site. It then plots the earthquakes on a world map using MapKit.

There are several similar apps on the web and in the app store. Apple has sample code to show the use of the NSXMLParser, but that code displays the earthquakes in arbitrary order in a UITableView with no map.

Another similar application is from [Bill Dudney's](http://bill.dudney.net/roller/objc/) screencast and [sample code at Pragmatic Programmers](http://www.pragprog.com/screencasts/v-bdmapkit/using-map-kit/). The code in Terremoto (my application) uses Dudney's XML parser code (with permission) almost verbatim at present. My view controller is similar to Dudney's, since I learned from his code and there are only so many ways to do this, although over time my view controller code has taken its own direction. Among the ways my app, Terremoto, differs from Dudney's is that Terremoto displays all earthquake events fetched from the USGS site, not just the 50 or 100 nearest to the user's location. This requires changes in the way Terremoto zooms to the user's current location, among other things. My application also displays details about the earthquake in a UIWebView within the application, whereas Dudney's demo app displayed this information by launching Safari on a USGS URL.

I plan to show earthquakes on the map using a custom annotation view to resemble the maps on the USGS web site itself, where events are displayed not as color-coded pins, but as squares of varying sizes and colors. I also want to add a control to allow the user to zoom to the current location at any time. Another feature I plan to add is one that will show the most recent earthquakes first, perhaps making a recent earthquake the initial zoom location, or perhaps adding a view that shows the earthquakes in a list sorted by time of the event or by magnitude.


*Craig Schamp*

