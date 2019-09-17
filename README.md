staw
====
Simple *stat*ic *w*eb generator, similar to (s)werc, written in Go. In contrast
to werc it generates static web sites that don't require (fast)cgi execution on
demand.

staw supports a very simple migration from existing werc sites to static staw sites.

staw creates HTML output for each directory and markdown input file. It also
copies all other files to the output directory. The output directory should be
served as docroot for the particular site by a regular web server.

staw uses Go's template approach and the
[github.com/gomarkdown/markdown](https://github.com/gomarkdown/markdown)
markdown package.  staw is self-contained and does not require any other
dependencies.

Usage
-----
	; staw -h
	Usage of ./staw:
	  -css string
		style.css file to be copied to site output directory (optional)
	  -in string
		input site directory (required)
	  -out string
		output site directory (required)
	  -p string
		url-prefix for local testing (optional)
	  -t string
		site title of the site (required)
	  -tpl string
		template file to be used (required) (default "default.tpl")

site directory
--------------
staw uses a site directory structure similar to the one introduced by werc.
Each site lives in its directory tree.

Example:

	example.com
	   +- index.md
	   +- some-topic
	      +- intro.md

	; ./[example.sh](https://github.com/garbeam/staw/blob/master/example.sh)

This run will generate:

	example.com
	   +- style.css
	   +- index.html
	   +- some-topic
	      +- index.html
	      +- intro
                 +- index.html

Template
--------
Have a look at the
[default.tpl](https://github.com/garbeam/staw/blob/master/default.tpl) provided
by staw.

staw uses a recursive menu structure and defines the following variables that
can be used during the template execution on each markdown page:

	.Site string
	.SiteTitle string
	.Prefix string
	.Title string
	.HtmlContent string
	range .Items {
		.Prefix string
		.Path string
		.Name string
		.Sel bool
		range .Items ...
	}

Happy hacking.
