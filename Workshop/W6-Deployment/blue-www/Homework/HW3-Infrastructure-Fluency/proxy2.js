var redis = require('redis')
var multer  = require('multer')
var express = require('express')
var fs      = require('fs')
var app = express()
var server = app.listen(3000, function() {
	var host = server.address().address
	var port = server.address().port
	console.log('Example app listening at http://%s:%s', host, port)
})
var client = redis.createClient(6379, '127.0.0.1', {})
client.set("key", "value");
client.get("key", function(err,value){console.log(value)});
///////////// WEB ROUTES

// Add hook to make it easier to get all visited URLS.
app.use(function(req, res, next) 
{
	console.log(req.method, req.url);

	// ... INSERT HERE.
	client.lpush("mylist",req.url)

	next(); // Passing the request to the next handler in the stack.
});

app.get('/', function(req,res){
	res.send('hello world')
})

app.get('/set', function(req,res){
	client.set("key","this message will self-destruct in 10 seconds")
	client.expire("key",10)
})
app.get('/get', function(req,res){
	res.send(client.get("key", function(err,value){console.log(value)}));
})
app.get('/recent', function(req,res){
	client.ltrim("mylist",0,4)
	var url_send = ""
	var urls=client.lrange("mylist",0,4,function(error,items){
		items.forEach(function(item){
			url_send=url_send+"\n\t"+item.toString()
		})
		res.send(url_send)
	})
});
app.post('/upload',[ multer({ dest: './uploads/'}), function(req, res){
    console.log(req.body) // form fields
    console.log(req.files) // form files

    if( req.files.image )
    {
 	   fs.readFile( req.files.image.path, function (err, data) {
 	  		if (err) throw err;
 	  		var img = new Buffer(data).toString('base64');
 	  		console.log(img);
			client.lpush("myimg", img)
 		});
 	}

    res.status(204).end() //what is 204?
}]);

app.get('/meow', function(req, res) {
 	{
		var imagedata
		res.writeHead(200, {'content-type':'text/html'});
		var imgs=client.lrange("myimg",0,0,function(error,items){
			items.forEach(function(item){
				imagedata=item
				client.lpop("myimg")
    			res.write("<h1>\n<img src='data:my_pic.jpg;base64,"+imagedata+"'/>");
			})
 			res.end();
		})
	}
})

function proxy(req,res){
	client.lpush("myPages",req.url)
	client.rpoplpush("sitesList","leftLists",function(error,item){
		res.redirect("http://localhost:"+item+req.url);
	});
	client.rpoplpush("leftLists","sitesList")
}
app.get('/',function(req,res){
	proxy(req,res)
})
