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
{{if eq .Site "example.com"}}
		<a class="thisSite" href="http://example.com/index.html">example.com</a>
{{else}}
		<a href="http://example.com/index.html">example.com</a>
{{end}}
{{if eq .Site "other.example.com"}}
		<a class="thisSite" href="http://other.example.com/index.html">other.example.com</a>
{{else}}
		<a href="http://other.example.com/index.html">other.example.com</a>
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
	&copy; 2019 some name
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
