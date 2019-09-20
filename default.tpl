<!doctype html>
<html>
<head> 
	<title>{{.Title}} | {{.SiteTitle}}</title>
	<link rel="stylesheet" type="text/css" href="{{.Prefix}}/style.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat&display=swap">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="utf-8"> 
</head> 
<body>
	<div id="menu">
{{if eq .Site "garbe.ca"}}
		<a class="thisSite" href="//garbe.ca/">home</a>
{{else}}
		<a href="//garbe.ca/">home</a>
{{end}}
{{if eq .Site "beec.ca"}}
		<a class="thisSite" href="//beec.ca/">bees</a>
{{else}}
		<a href="//beec.ca/">bees</a>
{{end}}
{{if eq .Site "sta.li"}}
		<a class="thisSite" href="//sta.li/">stali</a>
{{else}}
		<a href="//sta.li/">stali</a>
{{end}}
	</div>
	<div id="header">{{.SiteTitle}}</div>

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
		<li><a href="{{.Prefix}}/{{.Path}}" class="thisPath">{{.Name}}</a>
		{{else}}
		<li><a href="{{.Prefix}}/{{.Path}}" class="thisPage">{{.Name}}</a>
		{{end}}
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
