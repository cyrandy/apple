<?php
echo "i";
$xaxis = '';
$obj1 = '';
$obj2 = '';
date_default_timezone_set("Asia/Taipei");

/*
$now = time()-86400;

for($i = 0;$i < 20; $i++ )
{
	$xaxis .= '"'.(date('H:i:s', $now+$i*3600)).'",';
	$obj1 .= rand(1,100).',';
	$obj2 .= rand(20,30).',';
}
*/
$xaxis = '"08:30:00","09:30:00","10:30:00","11:30:00","12:30:00","13:30:00","14:30:00","15:30:00","16:30:00","17:30:00","18:30:00","19:30:00","20:30:00","21:30:00","22:30:00","23:30:00","00:30:00","01:30:00","02:30:00","03:30:00"';

$obj1 = '20,25,25,28,21,24,27,29,21,20,18,24,25,24,23,23,27,26,30,27,25';
$obj2 = '4,50,3,8,20,17,10,30,28,15,21,0,1,3,20,25,32,35,4,3,2';

?>
<!doctype html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JustFans</title>
		<link rel="stylesheet" type="text/css" href="stylesheets/default.css" />
		<link rel="stylesheet" type="text/css" href="stylesheets/component.css" />
		<script src="js/modernizr.custom.js"></script>
		<link rel="stylesheet" href="stylesheets/style.css">
		<link href='http://fonts.googleapis.com/css?family=Tinos:400,700,700italic|Gochi+Hand|Love+Ya+Like+A+Sister|Open+Sans:400,700' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" href="stylesheets/slides.css">


		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js"></script>	

		<!-- // <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
	  	<script src="jquery.slides.min.js"></script>
	  	<script src="slides.js"></script>
		<script src="js/chart.js"></script>
		<meta name = "viewport" content = "initial-scale = 1, user-scalable = no">
		<style>
			canvas{
			}
		</style>

	</head>
	<body>
		<nav class="main-nav">
			<div class="logo">
				<h1>JustFans</h1>
			</div>
			<ul>
				<li><a href="" >About & Contact</a></li>
				<li><a href=""><span class="highlight strong">Get Fans!</span></a></li>
				<li><a href="">About</a></li>

			</ul>
		</nav>
		<div class="content">
			<canvas id="canvas" height="450" width="600"></canvas>


			<script>

				var lineChartData = {
					labels : [ <?php  echo $xaxis;?>],
					datasets : [
						{
							fillColor : "#F1C40F",
							strokeColor : "#F39C12",
							pointColor : "#F39C12",
							pointStrokeColor : "#fff",
							data : [<?php echo $obj1; ?>]
						},
						{
							fillColor : "rgba(26,188,156,0.5)",
							strokeColor : "rgba(22,160,130,1)",
							pointColor : "rgba(22,160,130,1)",
							pointStrokeColor : "#fff",
							data : [<?php echo $obj2;?>]
						}
					]
					
				}

			var myLine = new Chart(document.getElementById("canvas").getContext("2d")).Line(lineChartData);
			
			</script>
		</div>
	</body>
</html>
