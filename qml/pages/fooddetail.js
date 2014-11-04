
//食谱详情
function loadfooddetail(id) {
    fooddetailModel.clear();
    var xhr = new XMLHttpRequest();
    var url="http://api.yi18.net/cook/show?id="+id
    console.log("URL:"+url);
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');

                loaded(jsonObject)
            }
        }
    }

    xhr.send();
}



function loaded(jsonObject)
{
    if(jsonObject.success.toString().indexOf("true")  == -1 ){
        showfooddetail.name="出错了";
        howfooddetail.id="0";
        root.visible=false
//        fooddetailModel.append({
//                    "img":"",
//                    "tag":"",
//                    "food":"",
//                    "message":""
//                               }
//                    );
    }
    else{
        showfooddetail.name=jsonObject.yi18.name;
        showfooddetail.id=jsonObject.yi18.id;
        fooddetailModel.append({
                                   "img":"http://www.yi18.net/"+jsonObject.yi18.img,
                                   "tag":jsonObject.yi18.tag,
                                   "food":jsonObject.yi18.food,
                                   "message":jsonObject.yi18.message
                               }
                               );


    }
    progress.visible=false
}


