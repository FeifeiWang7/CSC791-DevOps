## Blue-Green Deployment
<img src="pics/0.png"/>

Minimize downtime - The blue-green deployment approach ensures that there are two identical production environments. At any time one of them is live. When developers prepare a new release of the software, they do the final stage of testing in one environment. Once it works, developers switch the router so that all incoming requests go to that environment - the other one is idle.

Rollback - If anything goes wrong, just switch the router back to the other environment. 
 
### Complete git/hook setup
<img src="pics/1.png"/>
### Create blue/green infrastructure
<img src="pics/2.png"/>
<img src="pics/3.png"/>
<img src="pics/4.png"/>
### Demonstrate /switch route
<img src="pics/5.png"/>
### Demonstrate migration of data on switch
<img src="pics/5.png"/>
### Demonstrate mirroring
<img src="pics/6.png"/>
