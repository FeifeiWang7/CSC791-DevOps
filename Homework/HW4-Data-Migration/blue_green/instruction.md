## Deployments with Blue & Green Redis
Modified from Jesse Xu. Backup here to learn.

#### Set up Environment

Set up two redis instances for infrastructure.js to connect, and act as two real servers:
		
		src/redis-server --port 6379
		src/redis-server --port 6380
		
cd into the deployment folder and run:
		 
		sudo npm install -g forever
		npm install redis
		npm install

cd into <u>blue-www</u> folder and <u>green-www</u> folder and run 
		
		npm install redis
		npm install multer
		npm install
	
#### Git/hook setup

When there is a git push in the App folder to blue master or green master, the blue-www and green-www gets update. Check $ROOT/green.git/hooks/post-receive file.
	
#### Switch Route and Migration

Set the mirror switch to false in deployment/infrastructure.js.
	
Run infrastructure.js and visit http://localhost:8181, which should show the index of the blue server (by default the traffic will be routed to the blue server port:9090).

Visit http://localhost:8181/switch, which should redirect to http://localhost:8181 page, and the server should connect to the green server (port 5060). Refresh the page if cannot see the change of the content on index page. 

In the console, when switch server, the backend blue redis server (port 6379) should copy the current data to the green redis server (port 6380). 

		switch to green http://127.0.0.1:5060
		Migrating to Green Begin!! Copying 1 data
		switch to blue http://127.0.0.1:9090
		Migrating to Blue Begin!! Copying 1 data

#### Mirror Flag

Set the mirror switch to true in deployment/infrastructure.js.
				
Run infrastructure.js, and upload a picture

		curl -F "image=@./img/morning.jpg" localhost:8181/upload
		
By default, the picture is shown at the blue server(port 9090). But if you check the green server http://localhost:5060, the picture will also shown.

Note: when using the mirror feature, do not switch server, as it makes no sense.
