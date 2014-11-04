.import QtQuick.LocalStorage 2.0 as SQL//数据库连接模块
//storage.js
// 首先创建一个helper方法连接数据库
function getDatabase() {
    return SQL.LocalStorage.openDatabaseSync("mykuaidi2", "1.0", "postinfo", 10000);

}


// 程序打开时，初始化表
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    // 如果setting表不存在，则创建一个
                    // 如果表存在，则跳过此步
                    tx.executeSql('CREATE TABLE IF NOT EXISTS kuaidi(id integer primary key AutoIncrement,postid TEXT,name TEXT);');

                });
}

// 插入数据
function setKuaidi(postid, wuliutype) {
    console.log("asdasd"+postid+","+wuliutype)
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO kuaidi(postid,name) VALUES (?,?);', [postid,wuliutype]);
        //console.log(rs.rowsAffected)
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}

// 清除数据
function clearKuaidi(id) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('delete from  kuaidi where id =?;',[id]);
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    //防止删除不了
    //var name = getKuaidiInfo(id);
    //clearByname(name);
    return res;
}

//根据name删除
function clearByname(name) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('delete from  kuaidi where name =?;',[name]);
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}
// 获取查询列表
function getKuaidi() {
    var db = getDatabase();
    var res="";
    listModel.clear()
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM kuaidi;');
        if (rs.rows.length > 0) {
            for(var i = 0; i < rs.rows.length; i++){
                listModel.append({
                                     "id":rs.rows.item(i).id,
                                     "postid":rs.rows.item(i).postid,
                                     "name":dictnames(rs.rows.item(i).name)
                                 }
                                 )
            }
        } else {
            listModel.append({
                                 "id":"0",
                                 "postid":"",
                                 "name":"暂无历史记录"
                             }
                             )
        }
    });
}

// 获取单条查询记录
function getKuaidiInfo(id) {
    var db = getDatabase();
    var name="";
    var postid="";
    var res="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM kuaidi where id =?;',[id]);
        if (rs.rows.length > 0) {
            postid = rs.rows.item(0).postid;
            name = rs.rows.item(0).name;
            load(name,postid);

        } else {
            res = "查询出错了，(⊙o⊙)…";
            delbutton.enabled = false;

        }
    });
//    listdetailModel.append({
//                               "res":res
//                           });
}

// 判断是否已经存在
function isExist(postid) {
    var db = getDatabase();
    var res="true";
    db.transaction(function(tx) {
        var rs = tx.executeSql("SELECT * FROM kuaidi where postid =?",[postid]);
        if (rs.rowsAffected > 0) {
            //真特么恶心，删掉之后再查询竟然还有一行，然后里面也没东西，只能这么搞了
            try{
                console.log("shi fou shan chu le:"+rs.rows.item(0).postid);
                res = "true";
            }catch (e){
                res = "false";
            }
        } else {
            res = "false";
        }

    });


    return res;
}





//不能导入，只能重新复制一遍了,囧
function load(type,postid) {

    listdetailModel.clear();
    console.log("type:"+type+",postid:"+postid);
    var xhr = new XMLHttpRequest();
    var url="http://www.kuaidi100.com/query?type="+type+"&postid="+postid
    xhr.open("GET",url,true);
    xhr.onreadystatechange = function()
    {
        if ( xhr.readyState == xhr.DONE)
        {
            if ( xhr.status == 200)
            {
                var jsonObject = eval('(' + xhr.responseText + ')');
                //var jsonObject = xhr.responseText;
                 loaded(jsonObject);

            }
        }
    }
    xhr.send();
}



function loaded(jsonObject)
{
    var alltext = "";
    if(jsonObject.status != "200" ){
        listdetailModel.append({
                                   "res":"错误代码："+jsonObject.status+"<br>"+jsonObject.message
                               });
        alltext = "错误代码："+jsonObject.status+"<br>"+jsonObject.message;
    }
    else{
        for ( var process in jsonObject.data   )
        {
//            //最近物流黄色标注
//            if( process ==0 ){
//                alltext += "<font color=\"yellow\">"+jsonObject.data[process].time+"</font>"+"<br>"+"<font color=\"yellow\">"+jsonObject.data[process].context+"</font>"+"<br>"
//            }
//            else{
//                alltext += jsonObject.data[process].time+"<br>"+jsonObject.data[process].context+"<br>"
//            }
            //最近物流黄色标注
            if( process == 0 ){
                    listdetailModel.append({
                                         "sort":process,
                                         "time" : "<font color=\"yellow\">"+jsonObject.data[process].time+"</font>",
                                         "context" : "<font color=\"yellow\">"+jsonObject.data[process].context+"</font>"


                                     });
                    alltext += "<font color=\"yellow\">"+jsonObject.data[process].time+"</font>"+"<br>"+"<font color=\"yellow\">"+jsonObject.data[process].context+"</font>"+"<br>"
                }else{
                    listdetailModel.append({
                                 "sort":process,
                                 "time" : jsonObject.data[process].time,
                                 "context" : jsonObject.data[process].context


                             });
                    alltext += jsonObject.data[process].time+"<br>"+jsonObject.data[process].context+"<br>"
                }
        }
//        listdetailModel.append({
//                                   "res":alltext
//                               });

    }
    console.log("refresh_alltext:"+alltext);
    return alltext;
}

//快递字典
function dictnames(name){

    var postnames={
         "shentong":"申通",
         "ems":"EMS",
        "shunfeng":"顺丰" ,
         "yuantong":"圆通",
        "zhongtong":"中通" ,
         "yunda":"韵达",
        "tiantian" :"天天",
         "huitongkuaidi":"汇通",
        "quanfengkuaidi" :"全峰",
         "debangwuliu":"德邦",
        "zhaijisong:":"宅急送"
    }
    try{
        return postnames[name];
    }
    catch(e){
        return "error"
    }

}
