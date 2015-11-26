# httplog
Simple Docker container (12.21 MB) that logs http requests to stdout and the http response.

## usage

* `make`
* `docker build -t luebken/httplog`
* `docker run --rm -p 8000:8000 luebken/httplog`