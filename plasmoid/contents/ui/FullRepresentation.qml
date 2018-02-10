  import QtQuick 2.7
  import org.kde.plasma.core 2.0 as PlasmaCore
  import org.kde.plasma.components 2.0 as PlasmaComponents
  import org.kde.plasma.extras 2.0 as PlasmaExtras
  import QtQuick.Controls 1.4
  import QtQuick.Layouts 1.1 as Layout
  import QtQml 2.2
  import QtQml.Models 2.2


Item{

    property var url:Qt.resolvedUrl(".");
    property var exec:url.substring(7,url.length);
    property string path;
    property string output;

    ListModel {
      id: modeModel 
    }
   
    Rectangle {
    width: theme.defaultFont.pixelSize * 7.6
    height: ((theme.defaultFont.pixelSize * 1.5) * modeModel.count) + 10

    Component {
        id: modeDelegate
        Rectangle {
            id: currentItem
            width: theme.defaultFont.pixelSize * 7.6
            height: theme.defaultFont.pixelSize * 1.5


            MouseArea {
              hoverEnabled: true
              onEntered: currentItem.color = theme.highlightColor;
              onExited: currentItem.color = theme.backgroundColor;
              //width: 150
              //height: theme.defaultFont.pixelSize * 1.5
              anchors.fill: parent
              onClicked: console.log(output, mode);
            }

            Column {
                
                
                //Text { text: '<b>Output:</b> ' + output }
                Grid {
                  //anchors.fill: parent
                  columns: 2
                  rows: 1
                  padding: 5
                  //verticalAlignment: Qt.alignVCenter


                  Text{ text: mode

                        rightPadding: 10
                        //position: PlasmaCore.CenterPositioned
                      }
                        //font: theme.font.defaultFont }
                  Image {source: current == "current" ? "emblem-checked.svg" : "";
                         

                         //height: theme.defaultFont.pixelSize * 1.5
                         //width: theme.defaultFont.pizelSize * 3.0
                         sourceSize.height: theme.defaultFont.pixelSize 
                         //fillMode: preserveAspectFit
                         }  

              

             }
        }
    }
  }

    function doResChange(mode) {
      console.log(mode);
    }

    PlasmaCore.DataSource {
      id: xrxData
      engine: "executable"
      connectedSources: ['bash -c "'+exec+'parse-xrx-output.sh"']        //connectedSources = [];

      onNewData: {
        var modes = data.stdout;
        var modeList = modes.split("\n");
        console.log(modes)
        for (var i = 0, len = modeList.length; i < len; i++ ) {
          var line = modeList[i]
          if (line == "") {continue;}
          var lineData = line.split(" ");
          var line_output = lineData[0];
          output = line_output;
          var line_mode = lineData[1];
          var line_current = lineData[2];

          modeModel.append({output:line_output, mode:line_mode, current:line_current});
        } // end for
      } // end onNewData
    } // end DataSource


    ListView {
        anchors.fill: parent
        model: modeModel 
        delegate: modeDelegate
        //highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true

          
    }
}
}
