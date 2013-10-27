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
}
function getTagID(key)
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
	StorageArea.get(List, function(obj)
	{
		console.log(obj[key].Image);
	});
	
}


setInfo("Tag2","http://www.google.com.tw","Amazing","/images/2.jpg");
setInfo("Tag1","http://tw.yahoo.com","wonderful.","/images/1.jpg");

getTagID("Tag1");
getUrl("Tag1");
getDescription("Tag1");
getImg("Tag1");
getTagID("Tag2");
