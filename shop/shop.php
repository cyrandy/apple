<?php

class Shop{
	private $hostPrefix;
	private	$objPrefix;
	private $query;
	private $items;
	private $itemRegex;
	function __construct()
	{
		$this->hostPrefix = 'http://query.yahooapis.com/v1/public/yql?';
		$this->objPrefix = 'http://tw.page.bid.yahoo.com/tw/auction/';
		$items = array();
		$this->itemRegex = '/[a-z][0-9]{8,}\?u\=Y[0-9]{9,}/';	
	}
	
	private function setQuery($url = null)
	{
	
		if($url == null) {
			echo 'set query first';
			return;
		}

		echo "[*] Set query for url> ".$url.PHP_EOL;
		$q['items'] = '*';
		$q['from'] = 'html';
		$q['url'] = $url; //'http://tw.user.bid.yahoo.com/tw/user/Y2655018685';

		$param['q'] = 'select '.$q['items'].' from '.$q['from'].' where url = '.'"'.$q['url'].'"';
		$param['q'] = str_replace('+', '%20', urlencode($param['q']));
		$param['format'] = 'json';
		$param['diagnostics'] = 'true';
		$url = '';

		foreach($param as $k => $v )
		{
			if($v != null) $url .=$k.'='.$v.'&';
		}
		$this->query = $this->hostPrefix.$url;
		echo "[*] Query> ".$this->query.PHP_EOL;
	}
	private function getContent()
	{
		$ch = curl_init();
		$agent = '"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) Applet/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30";';
		$options = array(
			CURLOPT_URL => $this->query,
			CURLOPT_HEADER => false,
			CURLOPT_USERAGENT => $agent,
			CURLOPT_POST => false,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_FOLLOWLOCATION => true
		);
		curl_setopt_array($ch, $options);
		echo "[*] Fetching...".PHP_EOL;
		$result = curl_exec($ch);
		curl_close($ch);
		return json_decode($result,true);
	}

	private function getItems($arr)
	{
		
		foreach($arr as $k => $v)
		{
			if (gettype($v) === 'array') {
				$this->getItems($v);	
			} else {
				if(preg_match($this->itemRegex, $v, $match)) {
					$oid = explode('?', $match[0]);
					$this->items[$oid[0]] = $this->objPrefix.$match[0];
					echo '[*] item> '.$this->items[$oid[0]].PHP_EOL;
				}
			}
		}
		return;
	}

	public function showItems()
	{
		print_r($this->items);
	}

	public function findShop($uid)
	{
		echo "UID> ".$uid.PHP_EOL;
		$url = 'http://tw.user.bid.yahoo.com/tw/user/'.$uid;
		$this->setQuery($url);
		$content = $this->getContent();
		$this->getItems($content);
	}
}
