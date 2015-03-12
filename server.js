var http = require('http');
var send = require('send');
var url = require('url');
var port = process.env.PORT || 3002;
var app = http.createServer(function(req, res){
  // send object
  var s = send(req, url.parse(req.url).pathname, {root: 'public'});
  // not found, then index
  s.on('error', function (err) {
    s.sendFile('public/index.html');
  });
  // file
  s.pipe(res);
}).listen(port);
console.info('[%s] Server is listening on port %d', (new Date()).toISOString(), port);