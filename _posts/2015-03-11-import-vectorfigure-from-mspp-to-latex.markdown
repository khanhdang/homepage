---
layout: 	post
title: 	Editing vector figure from MS Powerpoint to Latex with free software
date: 	2015-03-11 23:59:59
summary: I sometime struggling with how to export vector figure from MS powerpoint then import it into Latex
categories: blog
tags: [latex, blog, msoffice, inkscape]
---

I used to draw in MS Visio for 4-5 years. This tool is quite strong for drawing and it support to export
into vector format (EPS or PDF) that you can include inside Latex easily with better quality. Obviously, 
you can find out some tools that support drawing then export Latex file. However if you still have to work 
with MS Word, Visio is best choice.

<!--more-->

I moved to Japan then setup new machine without Visio (it probably cost me 30,000 JPY if I buy) so I have to
try drawing in Powerpoint. To be honest, drawing tool is powerpoint is really bad, you cannot add connection 
point, free-shape and so on. Furthermore, it import method is horrible. I normally import to MS Word with acceptable
quality but to Latex is not good at all. Figure pixel is easily to be broken and hard to deal with several scaling.


I tried with some tool then find out [Inkscape](https://inkscape.org/ja/) and  how to deal with it:

* Export Powerpoint page to PDF figure: Save As -> Select PDF -> Select Option : Current Page.
* Crop it by Inkscape (free software). Open PDF file -> Select region 
-> Crop by Ctrl + Shift + D -> Choose resize page to content -> Save as PDF.

It's done!

Furthermore I can draw completely in Inkscape then export vector image now but 
I have to do with Powerpoint since my fellas still using it.

P/S: For free software alternative of Visio, you can try [Dia](http://sourceforge.net/projects/dia-installer/).