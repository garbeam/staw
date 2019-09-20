package main

import (
	"flag"
	"log"
	"net/http"
)

func main() {
	port := flag.String("p", "8080", "port to serve on")
	dir := flag.String("d", ".", "directory")
	flag.Parse()

	http.Handle("/", http.FileServer(http.Dir(*dir)))

	log.Printf("Serving %s on HTTP port: %s\n", *dir, *port)
	log.Fatal(http.ListenAndServe(":"+*port, nil))
}
