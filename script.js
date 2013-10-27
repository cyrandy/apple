function allowDrop(ev)
{
    ev.preventDefault();
}

function drag(ev)
{
    if(ev.target.nodeName == "IMG") {
        ev.dataTransfer.setData("url", ev.target.src);
        ev.dataTransfer.setData("alt", ev.target.alt);
        ev.dataTransfer.setData("text", ev.target.id);
        ev.dataTransfer.setData("type", 'img');
        console.log("Drag a image");
    } else if(ev.target.nodeName == "A") {
        ev.dataTransfer.setData("href", ev.target.href);
        ev.dataTransfer.setData("text", ev.target.innerText);
        ev.dataTransfer.setData("type", 'a');
        console.log("Drag a link");
    } else {
        console.log("what are you dragging? quark quark");
    }
}

function drop(ev)
{
    ev.preventDefault();
    console.log("drop to: "+ev.target.id);
    var type = ev.dataTransfer.getData("type");
    if (type == "a") {
        console.log("link: "+ev.dataTransfer.getData("href"));
        chrome.runtime.sendMessage({
            method: "setInfo", 
            key: ev.target.id, 
            url: ev.dataTransfer.getData("href"),
            descri: ev.dataTransfer.getData("text"),
            image:""}, 
            function(response) {
                console.log(response.data);
        });

    } else if (type == "img") {
        console.log("img: "+ev.dataTransfer.getData("url"));
        chrome.runtime.sendMessage({
            method: "setInfo",
            key: ev.target.id,
            url: "",
            descri: ev.dataTransfer.getData("alt"),
            image: ev.dataTransfer.getData("url")},
            function(response) {
                console.log(response.data);    
        });
    }

}

function getTagList(tagID)
{
    chrome.extension.sendRequest({method: "getImg", key: tagID}, function(response) {
        console.log(response.data);
    });

}

function createTag(n)
{
        var height = '50';
        var tag = document.createElement('div');
        tag.id = n;
        tag.style.width = '100px';
        tag.style.height = height+'px';
        tag.style.border = '1px';
        tag.style.borderColor = '#99FF99';
        tag.style.borderStyle = 'solid';
        tag.style.position = 'fixed';
        tag.style.right = '0';
        tag.style.top = height*n+'px';
        tag.style.backgroundColor = '#99FF99';
        tag.style.zIndex = '1000';
        tag.textContent = n;

        tag.addEventListener('drop', drop, false);
        tag.addEventListener('dragover', allowDrop, false);
        tag.addEventListener('click', getTagList(n), false);

        var arrow = document.createElement('div');
        arrow.className = 'wtf';
        arrow.style.position = 'fixed';
        arrow.style.right = '100px';
        arrow.style.top = height*n+'px';
        arrow.style.zIndex = '1000000000';
        
        var b = document.body;
        b.appendChild(tag);
        b.appendChild(arrow);
        console.log(arrow);     
        console.log("Add Node: "+n+".");        
        return tag;
}

function createAddTag()
{
        var height = '50';
        var tag = document.createElement('div');
        tag.id = 'adder';
        tag.style.width = '100px';
        tag.style.height = height+'px';
        tag.style.border = '1px';
        tag.style.borderColor = '#FF3333';
        tag.style.borderStyle = 'solid';
        tag.style.position = 'fixed';
        tag.style.right = '0';
        tag.style.top = height*n+'px';
        tag.style.backgroundColor = '#FF3333';
        tag.style.zIndex = '1000';
        tag.textContent = '+';

        var b = document.body;
        b.appendChild(tag);
        return tag;
}


//switch draggable property of every links on!
var links = document.querySelectorAll('a');
for(var index in links)
{ 
    if (typeof links[index] === 'object') {
        links[index].draggable = true;
        links[index].addEventListener('dragstart', drag, false);
    }
}

//create the tag could be used to add new tag by clicking it
var n = 0;
var tags = [];
var adder = createAddTag();
adder.addEventListener('click', function(){createTag(++n);}, false);


//add two tag for example
n++;
tags.push(createTag(n));

n++;
tags.push(createTag(n));
