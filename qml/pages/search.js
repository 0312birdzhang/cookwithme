
//搜索
function searchfood(name) {
    progress.visible=true;
    searchModel.clear();
    var xhr = new XMLHttpRequest();
    var url="http://api.yi18.net/cook/search?keyword="+name
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
         header.title="无结果"
//        searchModel.append({
//                             "id":"0",
//                             "name":"木有找到哦",
//                             "img":""
//                         });
    }
    else{

        for ( var i in jsonObject.yi18   )
        {
                    searchModel.append({
                                         "id":jsonObject.yi18[i].id,
                                         "name":jsonObject.yi18[i].name,
                                         "img":"http://www.yi18.net/"+jsonObject.yi18[i].img

                             });

        }

    }
    progress.visible=false
}


