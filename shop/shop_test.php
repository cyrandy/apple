<?php
include 'Shop.class.php';

$shop = new Shop(1);
$shop->findShop('Y2655018685');
$shop->showItems();

?>

