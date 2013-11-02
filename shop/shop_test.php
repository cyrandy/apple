<?php
include 'shop.php';

/*
public method:
	findShop(uid) //get all items of the shopper
	showItems() //show the items fetched
*/

$shop = new Shop();
$shop->findShop('Y2655018685');
$shop->showItems();



