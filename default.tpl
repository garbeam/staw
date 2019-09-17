<!doctype html>
<html>
<head> 
	<title>{{.Title}} | {{.SiteTitle}}</title>
	<link rel="stylesheet" type="text/css" href="{{.Prefix}}/style.css">
	<meta charset="utf-8"> 
</head> 
<body>
	<div id="header">
		<a href="/">{{.SiteTitle}}</a>
	</div>
	<div id="menu">
		<span class="right">
{{if eq .Site "garbe.ca"}}
		<a class="thisSite" href="http://garbe.ca/index.html">garbe.ca</a>
{{else}}
		<a href="http://garbe.ca/index.html">garbe.ca</a>
{{end}}
{{if eq .Site "beec.ca"}}
		<a class="thisSite" href="http://beec.ca/index.html">beec.ca</a>
{{else}}
		<a href="http://beec.ca/index.html">beec.ca</a>
{{end}}
{{if eq .Site "sta.li"}}
		<a class="thisSite" href="http://sta.li/index.html">sta.li</a>
{{else}}
		<a href="http://sta.li/index.html">sta.li</a>
{{end}}
		</span>
	</div>

	<div id="content">
	{{if .Items}}
	<div id="nav">
		<ul>
			{{range .Items}}
			{{template "submenu" .}}
			{{end}}
		</ul>
	</div>
	{{end}}
	<div id="main">
	{{.HtmlContent}}
	</div>

	</div>
	<div id="footer">
	<span class="left">
		<a href="https://github.com/garbeam/staw">staw</a> powered
	</span>
	<span class="right">
	&copy; MMXIX Anselm R. Garbe | <a href="http://garbe.ca/Contact/">Contact</a>
	</span>
	</div>
</body>
</html>

{{/* recursive (sub-)menu */}}
{{define "submenu"}}
	{{if .Sel}}
	<li><a href="{{.Prefix}}/{{.Path}}" class="thisPage">{{.Name}}</a>
	{{else}}
	<li><a href="{{.Prefix}}/{{.Path}}" class="normal">{{.Name}}</a>
	{{end}}
		{{if .Items}}
			<ul>
				{{range .Items}}
				{{template "submenu" .}}
				{{end}}
			</ul>
		{{end}}
	</li>
{{end}}
