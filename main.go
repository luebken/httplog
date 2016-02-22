package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
)

func handle(w http.ResponseWriter, r *http.Request) {
	resp := fmt.Sprintf("%+v\n", r)
	log.Println(resp)
	io.WriteString(w, resp)
}

func main() {
	http.HandleFunc("/", handle)

	go func() {
		log.Println("Starting httplog server at 127.0.0.1:8000")
		log.Fatal(http.ListenAndServe(":8000", nil))
	}()

	// Handle SIGTERM.
	ch := make(chan os.Signal)
	signal.Notify(ch, syscall.SIGTERM)
	for {
		log.Printf("got signal '%v'. ignoring.\n", <-ch)
	}
}
