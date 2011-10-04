>From: Alex @ Orb.com
>Subject: Re: waiting on that code test...
>Date: October 3, 2011 10:11:53 AM PDT
>To: Michael Dautermann 

>Hi Michael,

>I apologize, we've had some issue this weekend on a major release we put out on friday
>and it started taking all my time.

>Here is the assignment. You can do it whenever you can.

>  ------
>  Write a simple iOS app that displays a list of images from a remote source.
>  Touching one of the images should open a new view displaying the image in fullscreen.
>
>  The remote source you'll be using is at <https://orby.orb.com/~jregisser/download/
>  iOSTest/images.plist>
>  ------


> Be aware that we will take note of the elegance of code, covering of edge cases & 
> overall performances.

> Good luck,
> Alex

The bulk of the work and the code is in the main view controller, "ViewPictureFromWebViewController".  

We first grab the XML list of pictures and create an array of image entries and throw the titles up into a table view as quickly as possible.  

Then, via a separate background thread, we go through the array of image entries and fetch each image thumbnail and update the table entry with the thumbnail image as soon as it is successfully retrieved.

Hopefully the edge cases you're thinking of have been covered (no table entries if there's no XML file, no thumbnails if there's no thumbnail image URL, no big image if there's no "url" entry for the image, etc.).

There's plenty of places for optimization here (i.e. more caching! better error detection and handling!), but I wanted to get this sent back to you after a couple hours of writing it just to demonstrate that I can come up with semi-optimized code pretty quickly.

Let me know if I can provide further elaboration or details.

michael
dautermann @ spamarrest.com
10/4/2011
