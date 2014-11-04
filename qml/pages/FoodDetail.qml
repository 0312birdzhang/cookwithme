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
import "fooddetail.js" as JS
import Sailfish.Silica 1.0
Page{
    id:showfooddetail
    property int operationType: PageStackAction.Animated
    property var id
    property var name
    PageHeader {
        id:header
        title: name
    }
    Item {
        id:root
        width: 540
        height: 960-header.height
        y:100
        Component.onCompleted: {
            JS.loadfooddetail(id)

        }

        Row {
            id:progress
            spacing: Theme.paddingLarge
            anchors.horizontalCenter: parent.horizontalCenter

            BusyIndicator {
                running: true
                size: BusyIndicatorSize.Large
                anchors.verticalCenter: parent.verticalCenter
            }
        }

                ListModel {  id:fooddetailModel }

        ListView{
            anchors.fill: parent
            id:messageAero
            y:50
            model : fooddetailModel
            clip: true
//            PushUpMenu{
//                MenuItem {
//                    text: "返回顶部"
//                    onClicked:messageAero.scrollToTop()
//                }
//            }
            delegate:Column{
                Text{
                    clip:true
                    wrapMode: Text.WordWrap
                    width:500
                    x: Theme.paddingLarge
                    text:message
                    color: messageAero.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Image{
                    id:foodpic
                    fillMode: Image.PreserveAspectCrop;
                    width:  520
                    height: 960/2
                    source: img
                }

            }
        }
    }
}