<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>A Pivotal Demo</title>
</head>

<body>


	<div id="pivotal"></div>
	<div id="menu">
		<h1 style="color: #417c2b; position: absolute; left: 20px; top: 210px" id="app"
			onclick="startApp()">Your App</h1>

		<h2 style="color: #417c2b; position: absolute; left: 20px; top: 260px" id="mm">Management
			and Monitoring</h2>
		<h3 style="position: absolute; left: 20px; top: 300px" id="pulse" onclick="window.open('http://server1:8080/pulse', 'pulse');">Pulse</h3>
		<h3 style="position: absolute; left: 20px; top: 340px" id="jt" onclick="window.open('http://server0:50030', 'jobtracker');">JobTracker</h3>
		<h3 style="position: absolute; left: 20px; top: 380px" id="nn" onclick="window.open('http://server0:50070', 'namenode');">NameNode</h3>
		<h3 style="position: absolute; left: 20px; top: 420px" id="tt" onclick="window.open('http://server0:50060', 'tasktracker');">TaskTracker</h3>
		<h3 style="position: absolute; left: 20px; top: 460px" id="sba" onclick="window.open('../batch/home', 'batch');">Spring
			Batch Admin</h3>

		<h2 style="color: #417c2b; position: absolute; left: 400px; top: 260px" id="analytics" onclick="window.open('startjob', 'startjob');">Analytics</h2>
		<h3 style="position: absolute; left: 400px; top: 300px" id="realtime" onclick="window.open('analytics/realtime', 'realtime');">Realtime Locations</h3>
		<h3 style="position: absolute; left: 400px; top: 340px" id="lasthour" onclick="window.open('analytics/lasthour', 'lasthour');">Last Hour</h3>
		<h3 style="position: absolute; left: 400px; top: 380px" id="lastday" onclick="window.open('analytics/lastday', 'lastday');">Last Day</h3>
		<h3 style="position: absolute; left: 400px; top: 420px" id="lastweek" onclick="window.open('analytics/lastweek', 'lastweek');">Last Week</h3>
		<h3 style="position: absolute; left: 400px; top: 460px" id="all"  onclick="window.open('analytics/all', 'all');">All Locations</h3>
	
	</div>
	<script>
		var w, h;

		function initialize() {
			var id = document.getElementById("pivotal");
			w = window.innerWidth;
			h = window.innerHeight;

			var bgimg = new Image();
			bgimg.src = "../openres/pivotal.png";
			bgimg.setAttribute("id", "pimg");
			id.appendChild(bgimg);

			bgimg.setAttribute("style",
					"position:absolute; top:0px; left:0px; width: "
							+ window.innerWidth + "px; height: "
							+ window.innerHeight + "px;");

		}
		initialize();

		function onGeoSuccess(position) {
			latitude= position.coords.latitude;
			longitude= position.coords.longitude;
			var url= "location?latitude="+latitude+"&longitude="+longitude;
			console.log("sending Location to url: " + url+ " "+location);
			
			if (window.XMLHttpRequest) {
				try {
					req = new XMLHttpRequest();
				} catch (e) {
					req = false;
				}
				// branch for IE/Windows ActiveX version
			} else {
				if (window.ActiveXObject) {
					try {
						req = new ActiveXObject("Msxml2.XMLHTTP");
					} catch (e) {
						try {
							req = new ActiveXObject("Microsoft.XMLHTTP");
						} catch (e) {
							req = false;
						}
					}
				}
			}
			if (req) {
				req.onreadystatechange = locationSent;
				req.open("GET",url, true);
				req.send("");
			} else {
				alert("req== false");
			}
		}

		// onError Callback receives a PositionError object
		//
		function onGeoError(error) {
		}

		function locationSent() {
		}
		
		function startApp() {
			navigator.geolocation.getCurrentPosition(onGeoSuccess, onGeoError);
			var app = '<c:out value="${app}"/>';
			window.open('http://'+app, 'app');
		}
	</script>

</body>

</html>
