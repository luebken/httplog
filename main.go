package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
)

func handle(w http.ResponseWriter, r *http.Request) {
	resp := fmt.Sprintf("%+v\n", r)
	log.Println(resp)
	io.WriteString(w, resp)
}

func main() {
	http.HandleFunc("/", handle)
	log.Println("Starting httplog server at 127.0.0.1:8000")
	http.ListenAndServe(":8000", nil)
}
