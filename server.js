var http = require('http');
var handleRequest = function(request, response) {
    response.writeHead(200);
    response.end("<h1> Deploy version is v2.0. Cloud Build in Action !!! </h1>");
}
var www = http.createServer(handleRequest);
www.listen(8000);