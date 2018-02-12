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

    width: theme.defaultFont.pixelSize * 7.6
    height: ((theme.defaultFont.pixelSize * 1.5) * modeModel.count) + 10
    //anchors.fill: parent

    Component {

        id: modeDelegate
        Rectangle {
            id: currentItem
            width: theme.defaultFont.pixelSize * 8
            height: theme.defaultFont.pixelSize * 1.5


            MouseArea {
              id: mouseArea
              hoverEnabled: true
              onEntered: currentItem.color = theme.highlightColor;
              onExited: currentItem.color = theme.backgroundColor;
              //width: 150
              //height: theme.defaultFont.pixelSize * 1.5
              anchors.fill: parent

              
              //onClicked: doResChange(mode)


            
            }


            Column {
                
                
                //Text { text: '<b>Output:</b> ' + output }
                Grid {
                  //anchors.fill: parent
                  columns: 3
                  rows: 1
                  height: theme.defaultFont.pixelSize * 1.5
                  rightPadding: 20
                  leftPadding: 10
                  //padding: 10
                  //verticalAlignment: Qt.alignVCenter


                  Text{ text: mode
                         //margins: 10
                         height: parent.height
                          verticalAlignment: Text.AlignVCenter
                          color: theme.font.color

                        //rightPadding: 10
                        //bottomPadding: theme.defaultFont.pixelSize * .25
                        //position: PlasmaCore.CenterPositioned
                      }

                    Text { text: "  "}
                        //font: theme.font.defaultFont }
                  Image {source: current == "current" ? "emblem-checked.svg" : "";
                         smooth: true
                        verticalAlignment: Text.AlignVCenter
                         //height: parent.height * .75
                         height: parent.height *.75
                         width: height

                         //sourceSize.height: theme.defaultFont.pixelSize 
                                                  } 
                    //fullRoot.height: displayRect.height;
              }
             
              

             }
       
          Connections {
             target: mouseArea
             onClicked: doModeChange(mode);

          } 

        }    
  
      

   }

  
   //Item {
   // xrxData.connectedSources: 'bash -c "'+exec+'parse-xrx-output.sh"';
  // }

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


    //Item {
    // xrxData.connectedSources: 'bash -c "'+exec+'parse-xrx-output.sh"';
    //}

    ListView {
        anchors.fill: parent
        model: modeModel 
        delegate: modeDelegate
        //highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true

      }

}
  PlasmaCore.DataSource {
    id: doXrandr
    engine: "executable"
    connectedSources: []

    onNewData: {
      console.log("Changed");
      disconnectSource(xrandr_str);
    }
  }

  function doModeChange(mode) {
      console.log(display, mode);
      console.log(old_mode);
     // genericDialog.open();
     // redDialog.text = mode;
      var xrandr_str = "xrandr --output " + display + " --mode " + mode ;
      doXrandr.connectedSources = xrandr_str;
      modeModel.clear();
      //xrxData.connectedSources = xrxDataSource;
      //xrxData.disconnectSource(xrxDataSource);
      xrxData.connectedSources = xrxDataSource;
      //modeModel.sync();

      //displayRect.destroy()
      //xrxData.connectedSources = ['bash -c "'+exec+'parse-xrx-output.sh"']
      //modeModel.sync();
     // doXrandr.connectedSources = "";
      //xrxData.connectedSources = "";
      console.log(xrandr_str)
      
    }

     //PlasmaComponents.QueryDialog {
     // id: genericDialog
     // message: "Keep this mode"?
     // acceptButtonText: "Keep"
     // rejectButtonText: "Reset"
     //}

      
 }


  


