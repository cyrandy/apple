<?php
echo "i";
$xaxis = '';
$obj1 = '';
$obj2 = '';
date_default_timezone_set("Asia/Taipei");


$now = time()-86400;

for($i = 0;$i < 20; $i++ )
{
	$xaxis .= '"'.(date('H:i:s', $now+$i*3600)).'",';
	$obj1 .= rand(1,100).',';
	$obj2 .= rand(20,30).',';
}

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
					fillColor : "rgba(151,187,205,0.5)",
					strokeColor : "rgba(151,187,205,1)",
					pointColor : "rgba(151,187,205,1)",
					pointStrokeColor : "#fff",
					data : [<?php echo $obj2;?>]
				}
			]
			
		}

	var myLine = new Chart(document.getElementById("canvas").getContext("2d")).Line(lineChartData);
	
	</script>
	</body>
</html>
