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


Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("食谱大全")
            }
            Label {

            }

        }
        Item{
            id:foodlistitem
            x: Theme.paddingLarge
            y:100
            Image{
                width: 240
                height:320
                source:"../img/foodlist.png"
                MouseArea {
                          anchors.fill: parent
                          onClicked: {
                              pageStack.push(Qt.resolvedUrl("FoodList.qml"))
                          }
                      }
            }

        }
        Item{
            id:foodclassitem
            x: page.width/2+10
            y:100
            Image{
                width: 240
                height:320
                source:"../img/foodclass.png"
                MouseArea {
                          anchors.fill: parent
                          onClicked: {
                              pageStack.push(Qt.resolvedUrl("FoodClass.qml"))
                          }
                      }
            }

        }
        Item{
            id:searchItem
            x: Theme.paddingLarge
            y:500
           Image {
                width: 240
                height:320
                source:"../img/searchfood.png"
                MouseArea {
                          anchors.fill: parent
                          onClicked: {
                              pageStack.push(Qt.resolvedUrl("SearchFood.qml")
                                             )
                          }
                      }
            }

        }
        Item{
            id:fooddetailitem
           x: page.width/2+10
            y:500
           Image {
                width: 240
                height:320
                source:"../img/about.png"
                MouseArea {
                          anchors.fill: parent
                          onClicked: {
                              pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                          }
                      }
            }

        }

    }
}


