
var List = {};

function setInfo(tagid,url,description,image)
{
    var dataObj = new dataInfo();
    dataObj.TagID = tagid || 0;
    dataObj.Url = url || "";
    dataObj.Description = description || "";
    dataObj.Image = image || "";
    List[dataObj.TagID] = dataObj;
    chrome.storage.local.set(List);
    return "save success.";
}

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
