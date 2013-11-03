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
		<title>Line Chart</title>
		<script src="js/chart.js"></script>
		<meta name = "viewport" content = "initial-scale = 1, user-scalable = no">
		<style>
			canvas{
			}
		</style>
	</head>
	<body>
		<canvas id="canvas" height="450" width="600"></canvas>


	<script>

		var lineChartData = {
			labels : [ <?php  echo $xaxis;?>],
			datasets : [
				{
					fillColor : "rgba(220,220,220,0.5)",
					strokeColor : "rgba(220,220,220,1)",
					pointColor : "rgba(220,220,220,1)",
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
	</body>
</html>
