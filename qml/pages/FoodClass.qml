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
import "foodclass.js" as JS
import Sailfish.Silica 1.0
Page{
    id:showfoodclass
    property int operationType: PageStackAction.Animated
    property string cookclass:"0"
    PageHeader {
        id:header
        title: "食谱分类"
    }
    Item {
        id:root
        y:100
        width: 540
        height: 960-header.height
        Component.onCompleted: {
            JS.loadclass(cookclass);
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
        ListModel {
            id:foodclassModel
        }


        SilicaGridView {
            id: gridView
            model: foodclassModel
            anchors.fill: parent
            currentIndex: -1
            cellWidth: gridView.width / 3
            cellHeight: cellWidth

//            PullDownMenu {
//                MenuItem {
//                    text: "Switch to list"
//                    onClicked: {
//                        keepSearchFieldFocus = searchField.activeFocus
//                        activeView = "list"
//                    }
//                }
//            }

            delegate: BackgroundItem {
                id: rectangle
                width: gridView.cellWidth
                height: gridView.cellHeight
                GridView.onAdd: AddAnimation {
                    target: rectangle
                }
                GridView.onRemove: RemoveAnimation {
                    target: rectangle
                }

                OpacityRampEffect {
                    sourceItem: label
                    offset: 0.5
                }
            Label{
                id: label
                x: Theme.paddingMedium; y: Theme.paddingLarge
                width: parent.width - 30
                textFormat: Text.StyledText
                color: gridView.highlighted ? Theme.highlightColor : Theme.primaryColor

                text: "<br/>"+name
                font {
                    pixelSize: Theme.fontSizeSmall
                    family: Theme.fontFamilyHeading
                }

            }

            onClicked :{
               cookclass == "0"?pageStack.push(Qt.resolvedUrl("FoodClass.qml"),{cookclass:id}):pageStack.push(Qt.resolvedUrl("FoodList.qml"),{listid:id})
            }

            }

            VerticalScrollDecorator {}

        }
    }
}
