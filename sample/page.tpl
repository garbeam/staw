<!doctype html>
<html>
<head> 
	<title>{{.Title}} | {{.SiteTitle}}</title>
	<link rel="stylesheet" type="text/css" href="/style.css">
	<link href="https://fonts.googleapis.com/css?family=Montserrat:400,600&display=swap" rel="stylesheet">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="utf-8"> 
</head> 
<body>
	<div id="menu">
{{if eq .Site "example.com"}}
		<a class="thisSite" href="//example.com/">Home</a>
{{else}}
		<a href="//example.com/">Home</a>
{{end}}
{{if eq .Site "other.example.com"}}
		<a class="thisSite" href="//other.example.com/">Other</a>
{{else}}
		<a href="//other.example.com/">Other</a>
{{end}}
	</div>
	<div id="header"><span class="siteTitle">{{.SiteTitle}}</span></div>

	<div id="content">
	{{if .Items}}
	<div id="nav">
		<ul>
			{{range .Items}}
			{{template "submenu" .}}
			{{end}}
			<li><a href="" class="empty"></a></li>
		</ul>
	</div>
	{{end}}
	<div id="main">
	{{.HtmlContent}}
	</div>

	</div>
</body>
</html>

{{/* recursive (sub-)menu */}}
{{define "submenu"}}
	{{if .Sel}}
		{{if .Items}}
		<li><a href="/{{.Path}}" class="thisPath">{{.Name}}</a>
		{{else}}
		<li><a href="/{{.Path}}" class="thisPage">{{.Name}}</a>
		{{end}}
	{{else}}
	<li><a href="/{{.Path}}" class="normal">{{.Name}}</a>
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
