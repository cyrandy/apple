<?php

$to = $_GET['to'];
$obj = $_GET['obj'];
$owner = $_GET['owner'];

date_default_timezone_set("Asia/Taipei");
$fp = fopen('DB', 'w+');
fputs($fp, time().','.$obj.','.$owner);
fclose($fp);
header('Location: '.$to);


