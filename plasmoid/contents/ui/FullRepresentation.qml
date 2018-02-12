  import QtQuick 2.7
  import org.kde.plasma.core 2.0 as PlasmaCore
  import org.kde.plasma.components 2.0 as PlasmaComponents
  import org.kde.plasma.extras 2.0 as PlasmaExtras
  import QtQuick.Controls 1.4
  import QtQuick.Layouts 1.1 as Layout
  import QtQml 2.2
  import QtQml.Models 2.2
  //import QtQuick.Dialogs 1.3



Item { 

  id: fullRoot

    width: theme.defaultFont.pixelSize * 7.6
    height: ((theme.defaultFont.pixelSize * 1.5) * 20) + 10
  

    property var url:Qt.resolvedUrl(".");
    property var exec:url.substring(7,url.length);
    property string path;
    property string output;
    property var change_mode: "default"
    property var curr_mode;
    property var old_mode;
    property var display;
    property var xrandr_str;
    property var modeList;
    property var xrxDataSource: 'bash -c "'+exec+'parse-xrx-output.sh"'

    function loadColumn() {
      xrxData.connectedSources = 'bash -c "'+exec+'parse-xrx-output.sh"'
    }

    

    ListModel {
      id: modeModel 
    }
   
    Rectangle {

    id: displayRect
    color: theme.backgroundColor
    width: theme.defaultFont.pixelSize * 7.6
    height: ((theme.defaultFont.pixelSize * 1.5) * modeModel.count) + 10
    //anchors.fill: parent

    Component {

        id: modeDelegate
        Rectangle {
            color: theme.backgroundColor
            id: currentItem
            width: theme.defaultFont.pixelSize * 8
            height: theme.defaultFont.pixelSize * 1.5


            MouseArea {
              id: mouseArea
              hoverEnabled: true
              onEntered: currentItem.color = theme.highlightColor;
              onExited: currentItem.color = theme.backgroundColor;
              anchors.fill: parent
            }


            Column {
              
                Grid {
        
                  columns: 3
                  rows: 1
                  height: theme.defaultFont.pixelSize * 1.5
                  rightPadding: 20
                  leftPadding: 10
                

                  Text{ text: mode
                         //margins: 10
                         height: parent.height
                          verticalAlignment: Text.AlignVCenter
                          color: theme.textColor
                        }

                  Text { text: "  "} // cheater spacing in grid column
                        //font: theme.font.defaultFont }
                  Image {source: current == "current" ? "emblem-checked.svg" : "";
                         smooth: true
                        verticalAlignment: Text.AlignVCenter
                         height: parent.height *.75
                         width: height
                         } 
                    //fullRoot.height: displayRect.height;
                  }
             }
       
          Connections {
             target: mouseArea
             onClicked: doModeChange(mode);
             // this is here mainly to avoid more clutter
           } 

        }    
   }

    PlasmaCore.DataSource {
      id: xrxData
      engine: "executable"
      connectedSources: [xrxDataSource]        //connectedSources = [];

      onNewData: {
        var modes = data.stdout;
        var modeList = modes.split("\n");
        console.log(modes)
        for (var i = 0, len = modeList.length; i < len; i++ ) {
          var line = modeList[i]
          if (line == "") {continue;}
          var lineData = line.split(" ");
          var line_output = lineData[0];
          display = line_output;
          var line_mode = lineData[1];
          var line_current = lineData[2];
          if (line_current == "current") {old_mode = line_mode;}

          modeModel.append({output:line_output, mode:line_mode, current:line_current});
          disconnectSource(xrxDataSource);
        } // end for
      } // end onNewData
    } // end DataSource

    ListView {
        anchors.fill: parent
        model: modeModel 
        delegate: modeDelegate
        focus: true
      }
}

  PlasmaCore.DataSource {
    id: doXrandr
    engine: "executable"
    connectedSources: []

    onNewData: {
      var tmpOutput = data.stdout;
      console.log("Changed");
      disconnectSource(xrandr_str);
    }
  }

  function doModeChange(mode) {
      console.log(display, mode);
      console.log(old_mode);
      // execute the change
      var xrandr_str = "xrandr --output " + display + " --mode " + mode ;
      doXrandr.connectedSources = xrandr_str;
      // cause the ListView to refresh
      modeModel.clear();
      xrxData.connectedSources = xrxDataSource;
      console.log(xrandr_str)
      
    }
 }


  


