/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages/search.js" as JS
Page {
    id: searchPage
    property string searchString
  //  property bool keepSearchFieldFocus:true
    PageHeader {
        id:header
        title: "找美食"
    }
    Item {
        id:searchItem
        y:header.height
        width: 540
        height: 960-header.height
        Component.onCompleted: {
            progress.visible=false
        }
            SearchField {
                id: searchField
                //width: parent.width
                width:540
                Binding {
                    target: searchPage
                    property: "searchString"
                    value: searchField.text
                }
                EnterKey.onClicked: {
                    JS.searchfood(searchField.text)
                    parent.focus=true
                    }
                }

        Row {
            id:progress
            y:header.height+150
            spacing: Theme.paddingLarge
            anchors.horizontalCenter: parent.horizontalCenter

            BusyIndicator {
                running: true
                size: BusyIndicatorSize.Large
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        ListModel {
            id:searchModel
        }

Item{
    width: 540
    height: 960-header.height
    y:header.height
        SilicaListView {
            y:header.height
            id:view
            PushUpMenu{
                MenuItem{
                    text:"返回顶部"
                    onClicked: view.scrollToTop()
                }
            }
            anchors.fill:parent
            model : searchModel
            clip: true
           // currentIndex: -1 // otherwise currentItem will steal focus
            delegate:
                BackgroundItem{
                id:showlist
                height: 320
                    Image{
                        id:foodpic
                        fillMode: Image.Stretch;
                        width:  implicitWidth
                        height: 300
                        source: img
                    }
                    Text {
                        id:foodname
                        wrapMode: Text.WordWrap
                        x: foodpic.width
                        width: searchPage.width-foodpic.width
                        height: foodpic.height
                        text: "<br/>"+name+"<br/><br/>"
                        color: view.highlighted ? Theme.highlightColor : Theme.primaryColor

                    }
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("FoodDetail.qml"),{id:id})
                    }
            }


            VerticalScrollDecorator {}
//            Component.onCompleted: {
//                if (keepSearchFieldFocus) {
//                    searchField.forceActiveFocus()
//                }
//                keepSearchFieldFocus = false
//            }

            }
        }
    }
}
