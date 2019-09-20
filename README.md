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
markdown package.

Usage
-----
	; staw -h
	Usage of ./staw:
	  -in string
		input site directory (required)
	  -out string
		output site directory (required)
	  -t string
		site title of the site (required)
	  -tpl string
		template file to be used (required) (default "page.tpl")

Template
--------
Have a look at the

	sample/page.tpl

staw uses a recursive menu structure and defines the following variables that
can be used during the template execution on each markdown page:

	.Site        string
	.SiteTitle   string
	.Title       string
	.HtmlContent string
	.Items range {
		.Path   string
		.Name   string
		.Sel    bool
		.Items  range...
	}

Happy hacking.
