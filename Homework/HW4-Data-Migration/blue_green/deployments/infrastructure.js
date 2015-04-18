/* Learned from JesseXu*/
var http = require('http');
var httpProxy = require('http-proxy');
var exec = require('child_process').exec; 
var request = require("request");
var redis = require('redis')

var GREEN = 'http://127.0.0.1:' + process.argv[2];
var BLUE = 'http://127.0.0.1:' + process.argv[3];
var greenclient = redis.createClient(argv[4], '127.0.0.1', {})
var blueclient = redis.createClient(argv[5], '127.0.0.1', {})

var TARGET = BLUE;
var mirror=true; //change to false ... 

var infrastructure =
{
        setup: function () {
		blueclient.del("myimg"); //from Jesse
		greenclient.del("myimg");
		blueclient.del("switch");
		greenclient.del("switch");
        	var options = {};
        	var proxy = httpProxy.createProxyServer(options);
		var server = http.createServer(function (req, res) {
			proxy.web(req, res, {target: TARGET});
        	});
        	server.listen(8181);
		
        	exec('forever start -w --watchDirectory ../blue-www ../blue-www/main.js 9090');
        	console.log("blue slice");
        	exec('forever start -w --watchDirectory ../green-www ../green-www/main.js 5060');
        	console.log("green slice");

		function migrate(target){
			if(target==GREEN){
       		        	blueclient.llen("myimg",function(error,num){
        	        		console.log("Start migrating to Green ... Copying "+ num + " data")
                	        	if(num!=0){
                        			(blueclient.lrange("myimg",0,-1,function(err,items){
                            				if(err) throw err;
                            				items.forEach(function(item){
                                			greenclient.lpush('myimg',item);
                        				})
						}))
					}
				});
			}
			else{
                		greenclient.llen("myimg",function(error,num){
                    			console.log("Start migrating to Blue ... Copying " + num + " data")
                    			if(num!=0){
                        			(greenclient.lrange("myimg",0,-1,function(err,items){
                            				if(err) throw err;
                            				items.forEach(function(item){
                                				blueclient.lpush('myimg',item);
                            				})
                        			}))
                    			}
                		});
			}
		}
        	function trigger(){
			blueclient.get("switch",function(err,value){
				if(value=="1"){
					TARGET=GREEN;
                    			server = http.createServer(function (req, res) {
                        			proxy.web(req, res, {target: TARGET});
                    			});
					console.log("Switch to green "+GREEN);
					blueclient.del("switch");
					if(mirror==false) migrate(GREEN);
				}
			})
			greenclient.get("switch",function(err,value){
				if(value=="1"){
                    			TARGET=BLUE;
                    			server = http.createServer(function (req, res) {
                        			proxy.web(req, res, {target: TARGET});
                    			});
					console.log("Switch to blue "+BLUE);
					greenclient.del("switch");
					if(mirror==false) migrate(BLUE);
				}
			})
        	}
        	var init_green=0;
        	var init_blue=0;
        	blueclient.llen('myimg',function(err,num){
                	init_blue=num;
            	})
        	greenclient.llen('myimg',function(err,num){
                	init_green=num;
            	})
		blue_flag=0;
		green_flag=0;
		add=0;
        	function dup(){
            		blueclient.llen('myimg',function(err,num){
                    		if(num>init_blue){
                        		blue_flag=1;
                        		init_blue=num;
					add=num-init_blue;
                    		}
                	});
            	greenclient.llen('myimg',function(err,num){
			if(num>init_green){
                        	green_flag=1;
                        	init_green=num;
				add=num-init_green;
                    	}
                });
		if(blue_flag==1 && green_flag==0){
                	blueclient.lrange("myimg",0,add,function(err,items){
                    		console.log("in blue")
                    		if(err) throw err;
                    		items.forEach(function(item){
                        		greenclient.lpush('myimg',item);
					init_green++;
                    		})
                	})
			blue_flag=0;
		}
		if(green_flag==1 && blue_flag==0){
                	console.log("in green");
                	greenclient.lrange("myimg",0,add,function(err,items){
                    		if(err) throw err;
                    		items.forEach(function(item){
                        		blueclient.lpush('myimg',item);
					init_blue++;
                    		})
                	})
			green_flag=0;
            	}
        }
        var check= setInterval(trigger, 3*1000);
        if(mirror==true){
		var onChange=setInterval(dup,1*1000);
        }
    },
    teardown: function () {
        exec('forever stopall', function () {
            console.log("infrastructure shutdown");
            process.exit();
        });
    },
}

infrastructure.setup();
process.on('exit', function () {
    infrastructure.teardown();
});
process.on('SIGINT', function () {
    infrastructure.teardown();
});
process.on('uncaughtException', function (err) {
    console.log(err);
    infrastructure.teardown();
});
