
var List = {};

function setInfo(tagid,url,description,image)
{
	var dataObj = new dataInfo();
	dataObj.TagID = tagid;
	dataObj.Url = url;
	dataObj.Description = description;
	dataObj.Image = image;
	List[dataObj.TagID] = dataObj;
	chrome.storage.local.set(List);
	return "save success.";
}
/*function getTagID(key)
{
	chrome.storage.local.get(List, function(obj)
	{
		console.log(obj[key].TagID);
	});
}
function getUrl(key)
{
	chrome.storage.local.get(List, function(obj)
	{
		console.log(obj[key].Url);
	});
}
function getDescription(key)
{
	chrome.storage.local.get(List, function(obj)
	{
		console.log(obj[key].Description);
	});
}

function getImg(key)
{
	chrome.storage.local.get(List, function(obj)
	{
		console.log(obj[key].Image);
	});
}*/


//setInfo(1,"http://www.google.com.tw","Amazing","/images/2.jpg");
//setInfo(2,"http://tw.yahoo.com","wonderful.","/images/1.jpg");
/*
getTagID("Tag1");
getUrl("Tag1");
getDescription("Tag1");
getImg("Tag1");
getTagID("Tag2");

*/

chrome.runtime.onMessage.addListener(function(msg, sender, sendResponse) {
	if (msg.method == "setInfo")
		sendResponse({data: setInfo(msg.key,msg.url,msg.descri,msg.image)});
	else if (msg.method == "getTagID")
		sendResponse({data: List[msg.key].TagID});
	else if(msg.method == "getUrl")
		sendResponse({data: List[msg.key].Url});
	else if(msg.method == "getDescription")
		sendResponse({data: List[msg.key].Description});
	else if(msg.method == "getImg")
		sendResponse({data: List[msg.key].Image});
    else
		sendResponse({}); // snub them.
});
