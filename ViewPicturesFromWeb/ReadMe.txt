
The bulk of the work and the code is in the main view controller, "ViewPictureFromWebViewController".  

We first grab the XML list of pictures and create an array of image entries and throw the titles up into a table view as quickly as possible.  

Then, via a separate background thread, we go through the array of image entries and fetch each image thumbnail and update the table entry with the thumbnail image as soon as it is successfully retrieved.

Hopefully the edge cases you're thinking of have been covered (no table entries if there's no XML file, no thumbnails if there's no thumbnail image URL, no big image if there's no "url" entry for the image, etc.).

There's plenty of places for optimization here (i.e. more caching! better error detection and handling!), but I wanted to get this sent back to you after a couple hours of writing it just to demonstrate that I can come up with semi-optimized code pretty quickly.

Let me know if I can provide further elaboration or details.

michael
dautermann@mac.com
10/4/2011
