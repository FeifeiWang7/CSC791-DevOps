var needle = require("needle");
var os   = require("os");

var config = {};
config.token = "9eb414058ee0d0e5bcb60e428cfb5e2e0ba3962599944d4dddebf1dabd47ef1d";

var headers =
					{
						'Content-Type':'application/json',
						Authorization: 'Bearer ' + config.token
					};

// Documentation for needle:
// https://github.com/tomas/needle

var client =
{
	listRegions: function( onResponse )
	{
		needle.get("https://api.digitalocean.com/v2/regions", {headers:headers}, onResponse)
	},

	listImages: function( onResponse)
	{
		needle.get("https://api.digitalocean.com/v2/images", {headers:headers}, onResponse)
	},

	createDroplet: function (dropletName, region, imageName, onResponse)
	{
		var data = 
		{
			"name": dropletName,
			"region":region,
			"size":"512mb",
			"image":imageName,
			// Id to ssh_key already associated with account.
			"ssh_keys":[625870],
			"backups":false,
			"ipv6":true,
			"user_data":null,
			"private_networking":null
		}
		console.log("Attempting to create: "+ JSON.stringify(data) );

		needle.post("https://api.digitalocean.com/v2/droplets", data, {headers:headers, json:true}, onResponse )
	},

	retrieveDroplet: function (dropletId,onResponse)
	{
		console.log("Attempting to retrieve: dropletId="+ JSON.stringify(dropletId) );
		needle.get("https://api.digitalocean.com/v2/droplets/"+dropletId, {headers:headers,json:true}, onResponse );
	},

	deleteDroplet: function(dropletId,onResponse){
		console.log("Attempting to delete: dropletId="+ JSON.stringify(dropletId) );
		needle.delete("https://api.digitalocean.com/v2/droplets/"+dropletId,null,{headers:headers,json:true}, onResponse )
	}
};

// #############################################
// #1 Print out a list of available regions
// Comment out when completed.
// https://developers.digitalocean.com/#list-all-regions
// use 'slug' property
client.listRegions(function(error, response)
{
	var data = response.body;
	// console.log( JSON.stringify(response.body) );
	console.log("1. ------------------------------------------" );
	for(var i=0; i<data.regions.length; i++)
	{
		var region =  data.regions[i];
		if(region.available) console.log(region.slug);
		else console.log("find an available region.");
	}
	console.log(response.headers);
});

// #############################################
// #2 Extend the client object to have a listImages method
// Comment out when completed.
// https://developers.digitalocean.com/#images
// - Print out a list of available system images, that are AVAILABLE in a specified region.
// - use 'slug' property
//client.listImages(function(error, response)
//{
//	var data = response.body;
//	console.log("2. -------------------------------------");
//	for(var i = 0; i < data.images.length; i ++)
//	{
//		var image = data.images[i];
//		if(image.public) console.log(image.slug);
//		else console.log("find an available image.");
//	}
//	console.log(response.headers);
//});

// #############################################
// #3 Create an droplet with the specified name, region, and image
// Comment out when completed. ONLY RUN ONCE!!!!!
// Write down/copy droplet id.
//id = 3793268
// var name = "fwang12"+os.hostname();
// var region = "nyc3"; // Fill one in from #1
// var image = "ubuntu-12-04-x64"; // Fill one in from #2
// client.createDroplet(name, region, image, function(err, resp, body)
// {
// 	// StatusCode 202 - Means server accepted request.
// 	if(!err && resp.statusCode == 202)
// 	{
// 		console.log( JSON.stringify( body, null, 3 ) );
// 	}
// });

// #############################################
// #4 Extend the client to retrieve information about a specified droplet.
// Comment out when done.
// https://developers.digitalocean.com/#retrieve-an-existing-droplet-by-id
// REMEMBER POST != GET
// Most importantly, print out IP address!
var dropletId = "3788359";
//client.retrieveDroplet(dropletID, function(err, resp, body)
//{
//	if(!err && resp.statusCode == 202)
//	{
//		console.log( JSON.stringify(body, null, 3));
//	}
//	console.log(resp.body.droplet.networks);
//});

// #############################################
// #5 In the command line, ping your server, make sure it is alive!
// ping xx.xx.xx.xx

// #############################################
// #6 Extend the client to DESTROY the specified droplet.
// Comment out when done.
// https://developers.digitalocean.com/#delete-a-droplet
// HINT, use the DELETE verb.
// HINT #2, needle.delete(url, data, options, callback), data needs passed as null.
// No response body will be sent back, but the response code will indicate success.
// Specifically, the response code will be a 204, which means that the action was successful with no returned body data.
// 	if(!err && resp.statusCode == 204)
// 	{
//			console.log("Deleted!");
// 	}
client.deleteDroplet(dropletId,function(err,resp,body)
{
	if(!err && resp.statusCode == 204)
	{
		console.log("Deleted!");
	}
})
// #############################################
// #7 In the command line, ping your server, make sure it is dead!
// ping xx.xx.xx.xx
// It could be possible that digitalocean reallocated your IP address to another server, so don't fret it is still pinging.
