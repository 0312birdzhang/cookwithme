
//食谱列表
function loadclass(id) {
    //foodclassModel.clear();
    var xhr = new XMLHttpRequest();
    var url="http://api.yi18.net/cook/cookclass?id="+id
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
        header.title="查询出错"
//        foodclassModel.append({
//                                 "id":"0",
//                                 "cookclass":"0",
//                                 "name":"查询出错"
//                             });
    }
    else{

        for ( var i in jsonObject.yi18   )
        {
            foodclassModel.append({
                                     "id":jsonObject.yi18[i].id,
                                     "name":jsonObject.yi18[i].name,
                                     "cookclass":jsonObject.yi18[i].cookclass

                                 });

        }

    }
    progress.visible=false
}


