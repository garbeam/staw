// See LICENSE file for copyright and license details.
package main

import (
	"bufio"
	"flag"
	"io"
	"io/ioutil"
	"log"
	"os"
	"strings"
	"text/template"

	"github.com/gomarkdown/markdown"
)

type Args struct {
	siteDir string
	srcPath string
	dstPath string
	tpl     string
	page    Page
}

type Nav struct {
	Path   string
	Name   string
	Sel    bool
	Items  []Nav
}

type Page struct {
	Site        string
	SiteTitle   string
	Title       string
	HtmlContent string
	Items       []Nav
}

func copyFile(src, dst string) {
	in, err := os.Open(src)
	dieOnError(err)
	defer in.Close()
	out, err := os.Create(dst)
	dieOnError(err)
	defer out.Close()
	_, err = io.Copy(out, in)
	dieOnError(err)
	dieOnError(out.Close())
}

func dieIfEmpty(s *string, msg string) {
	if *s == "" {
		log.Fatal(msg)
	}
}

func dieOnError(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func getTitle(src string) string {
	in, err := os.Open(src)
	dieOnError(err)
	defer in.Close()
	reader := bufio.NewReader(in)
	title, err := reader.ReadString('\n')
	dieOnError(err)
	return strings.TrimRight(title, "\n")
}

func isMdFile(f os.FileInfo) bool {
	return strings.HasSuffix(f.Name(), ".md")
}

func mkDstPath(dstPath string, f os.FileInfo) string {
	var dst, tmp string
	if f == nil {
		tmp = "index" // no index.md in directory case
	} else {
		tmp = strings.TrimSuffix(f.Name(), ".md")
	}
	if tmp != "index" {
		dst = dstPath + "/" + tmp
		os.Mkdir(dst, os.ModePerm)
		dst += "/index.html"
	} else {
		dst = dstPath + "/index.html"
	}
	return dst
}

func mkNav(cwd, path, nbsp string, walk []string) []Nav {
	files, err := ioutil.ReadDir(cwd)
	dieOnError(err)
	var nav []Nav
	for _, f := range files {
		sel := len(walk) > 0 && f.Name() == walk[0]
		if f.IsDir() {
			nav = mkNavNode(nav, cwd, path, nbsp, walk, sel, f)
		} else if isMdFile(f) {
			nav = mkNavLeaf(nav, cwd, path, nbsp, sel, f)
		}
	}
	return nav
}

func mkNavLeaf(nav []Nav, cwd, path, nbsp string, sel bool, f os.FileInfo) []Nav {
	title := getTitle(cwd + "/" + f.Name())
	tmp := strings.TrimSuffix(f.Name(), ".md")
	if tmp == "index" {
		// prepend
		return append([]Nav{Nav{path, nbsp + title, sel, nil}}, nav...)
	} else {
		return append(nav, Nav{path + tmp + "/", nbsp + title, sel, nil})
	}
}

func mkNavNode(nav []Nav, cwd, path, nbsp string, walk []string, sel bool, f os.FileInfo) []Nav {
	n := Nav{path + f.Name() + "/", nbsp + f.Name() + "/", sel, nil}
	if sel {
		n.Items = mkNav(cwd+"/"+f.Name(), path+f.Name()+"/", nbsp + "&nbsp;&nbsp;", walk[1:])
	}
	return append(nav, n)
}

func processMdFile(a Args, walk []string, f os.FileInfo) {
	if f != nil {
		walk = append(walk, f.Name())
		a.page.Title = getTitle(a.srcPath)
		dat, err := ioutil.ReadFile(a.srcPath)
		dieOnError(err)
		a.page.HtmlContent = string(markdown.ToHTML(dat, nil, nil))
	} else if len(walk) > 0 {
		a.page.Title = walk[len(walk)-1] + "/"
	}
	a.page.Items = mkNav(a.siteDir, "", "", walk)
	t, err := template.ParseFiles(a.tpl)
	dieOnError(err)
	dst := mkDstPath(a.dstPath, f)
	out, err := os.Create(dst)
	dieOnError(err)
	defer out.Close()
	dieOnError(t.Execute(out, a.page))
}

func processPath(a Args, walk []string) {
	os.Mkdir(a.dstPath, os.ModePerm)
	files, err := ioutil.ReadDir(a.srcPath)
	dieOnError(err)
	noIndexMd := true
	for _, f := range files {
		b := a
		b.srcPath = a.srcPath + "/" + f.Name()
		if f.IsDir() {
			b.dstPath = a.dstPath + "/" + f.Name()
			processPath(b, append(walk, f.Name()))
		} else {
			if f.Name() == "index.md" {
				noIndexMd = false
			}
			if isMdFile(f) {
				processMdFile(b, walk, f)
			} else {
				copyFile(b.srcPath, b.dstPath+"/"+f.Name())
			}
		}
	}
	if noIndexMd {
		processMdFile(a, walk, nil)
	}
}

func main() {
	tpl := flag.String("tpl", "page.tpl", "template file to be used (required)")
	src := flag.String("in", "", "input site directory (required)")
	dst := flag.String("out", "", "output site directory (required)")
	title := flag.String("t", "", "site title of the site (required)")
	flag.Parse()
	dieIfEmpty(tpl, "no template given")
	dieIfEmpty(title, "no site title given")
	dieIfEmpty(src, "no site input directory given")
	dieIfEmpty(dst, "no output directory given")
	site, err := os.Stat(*src)
	dieOnError(err)
	processPath(Args{*src, *src, *dst, *tpl, Page{site.Name(), *title, "", "", nil}}, []string{})
}
