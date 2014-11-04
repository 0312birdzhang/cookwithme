
//食谱列表
function loadfoodlist(pagenum,listid) {
    //foodlistModel.clear();
    var xhr = new XMLHttpRequest();
    var url="http://api.yi18.net/cook/list?page="+pagenum+"&limit=10"
    if(listid != "2333"){
        url += "&id="+listid
    }
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
    var count=0;
    if(jsonObject.success.toString().indexOf("true")  == -1 ){
        header.title="无结果"
    }
    else{

        for ( var i in jsonObject.yi18   )
        {
                    foodlistModel.append({
                                         "id":jsonObject.yi18[i].id,
                                         "name":jsonObject.yi18[i].name,
                                         "img":"http://www.yi18.net/"+jsonObject.yi18[i].img,
                                         "tag":jsonObject.yi18[i].tag,
                                         "food":jsonObject.yi18[i].food

                             });

            count +=1;
        }

    }
    progress.visible=false
    if(parseInt(count) >3){
        showfoodpage.display = true;
    }else if(parseInt(count)  ==0 ){
        showfoodpage.display = false;
         header.title="无结果"
    }
    else{
        showfoodpage.display = false;
    }
}


