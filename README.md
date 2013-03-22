PivotalDemo
===========

PivotalDemo

I'm again using the same vmnet8 network as for the CD demo. I tried to not rely on this network but have not tested it on others.
Script for setting the vmnet8 net work at the end of this text

Open a shell on your mac and give your mac an additional IP
sudo ifconfig vmnet8 192.168.100.16 alias
The 192.168.100.0 network is the one the demo depends on.

Add the following hosts to your /etc/hosts on your mac:
192.168.100.130	server1
192.168.100.131	server2
192.168.100.1	server0 gemfirehost3 sqlfirehost


startup the mcf vm.

open another shell on your mac
create the ssh tunnel form your mac to the mcf vm:
sudo ssh -L 80:172.16.227.92:80 vcap@172.16.227.92
Make sure you have eth0:1 on 192.168.100.0 network
like:
eth0:1    Link encap:Ethernet  HWaddr 00:0c:29:fc:af:38  
          inet addr:192.168.100.92  Bcast:192.168.100.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
Check you /etc/hosts
if it does not contain hosts server1 and 2 do:
sudo sh -c 'cat addhosts.sh >> /etc/hosts'
Verify that mcf has the correct time!!!

start the VMs: vFabricController (first, this is also the nfs server (shares /opt/vfabric)) and Work1-3

ssh vfabric@server0
/opt/vfabric/hadoop/bin/start-dfs.sh 
/opt/vfabric/hadoop/bin/start-mapred.sh 
ssh server1 'source /opt/vfabric/setenv.sh; /opt/vfabric/datafabric/bin/startLocator.sh'
ssh server1 'source /opt/vfabric/setenv.sh; /opt/vfabric/datafabric/bin/startCache.sh'
ssh server2 'source /opt/vfabric/setenv.sh; /opt/vfabric/datafabric/bin/startLocator.sh'
ssh server2 'source /opt/vfabric/setenv.sh; /opt/vfabric/datafabric/bin/startCache.sh'
ssh server1 'source /opt/vfabric/setenv.sh; /opt/vfabric/products/gemfire701/bin/gfsh -e "connect --locator=localhost[44441]" -e "start pulse"'

start the pivotal web app on either a local tcsever or in mcf and point your browser to
http://localhost:8080/pivotal/mvc/start?app=www.yourcustomer.com

Click on Analytics to start the map red job.
Click on "Your App" to send your current location to the backend and show the customer website.



 









