/* Learned from JesseXu */
var http = require('http');
var httpProxy = require('http-proxy');
var exec = require('child_process').exec; 
var request = require("request");
var redis = require('redis')

var GREEN = 'http://127.0.0.1:5060';
var BLUE = 'http://127.0.0.1:9090';
var greenclient = redis.createClient(6380, '127.0.0.1', {})
var blueclient = redis.createClient(6379, '127.0.0.1', {})

var TARGET = BLUE;
var mirror=true; //change to false or true for migrating or mirror ... 
var infrastructure =
{
	setup: function () 
	{
		var options = {};
        var proxy = httpProxy.createProxyServer(options);
		console.log("reaches here1");
		var server = http.createServer(function (req, res) 
		{
			console.log("reaches here2");
			proxy.web(req, res, {target: TARGET}, function(err)
			{
				console.log(err);
			});
			console.log("reaches here3")
			if(req.url === '/switch')
			{
				if(TARGET === GREEN)
				{
					console.log("reaches green here")
					TARGET = BLUE
	            	server = http.createServer(function (req, res) 
					{
	               		proxy.web(req, res, {target: BLUE});
	           		});
					console.log("Switch to blue " + BLUE);
					if((mirror === false) && (TARGET === BLUE))
					{
						greenclient.llen("myimg", function(error, num)
						{
							console.log("Start migrating to blue ... copying " + num + " data")
							greenclient.lrange("myimg", 0, -1, function(err, items)
							{
								items.forEach(function(item)
								{
									blueclient.lpush("myimg", item);
								})
							})
						})
					}
				}
				else if (TARGET === BLUE)
				{
					console.log("reaches blue here")
					TARGET = GREEN
					server = http.createServer(function (req, res) 
					{
						proxy.web(req, res, {target: TARGET});
					});
					console.log("Switch to green " + GREEN);
					if((mirror === false) && (TARGET === GREEN))
					{
						blueclient.llen("myimg", function(error, num)
						{
							console.log("Start migrating to green ... copying " + num + " data")
							blueclient.lrange("myimg", 0, -1, function(err, items)
							{
								items.forEach(function(item)
								{
									greenclient.lpush("myimg", item);
								})
							})
						})
					}
				}
			}
			if(mirror)
			{
				if(TARGET === GREEN)
				{
					greenclient.lrange("myimg", 0, -1, function(err, items)
					{
						items.forEach(function(item)
						{
							blueclient.lpush('myimg',item);
						})
					})
				}
				else if(TARGET === BLUE)
				{
					blueclient.lrange("myimg", 0, -1, function(err, items)
					{
						items.forEach(function(item)
						{
							greenclient.lpush('myimg',item);
						})
					})
				}
			}
        });
		server.listen(8282);
        exec('forever start -w --watchDirectory ../green-www ../green-www/main.js 5060');
        console.log("green slice");
        exec('forever start -w --watchDirectory ../blue-www ../blue-www/main.js 9090');
        console.log("blue slice");
	},
////////
    teardown: function () 
	{
        exec('forever stopall', function () { console.log("infrastructure shutdown"); process.exit(); });
    },
}
infrastructure.setup();
process.on('exit', function () { infrastructure.teardown(); });
process.on('SIGINT', function () { infrastructure.teardown(); });
process.on('uncaughtException', function (err) { console.log(err); infrastructure.teardown(); });