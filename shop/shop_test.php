<?php
include 'shop.php';

$shop = new Shop();
$shop->findShop('Y2655018685');
$shop->showItems();

