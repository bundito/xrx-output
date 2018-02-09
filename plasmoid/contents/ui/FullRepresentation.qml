import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQml 2.2




Item {


  property var modes: []
  property var modeList: []
  property var bits: []
  property var rez: ""
  property var output: ""
  property var current: ""
  
  property var url:Qt.resolvedUrl(".");
  property var exec:url.substring(7,url.length);
  property string path;
  //property string pathName;
  //property string modeList;
  //property string mode;

   //path : window.location.pathname;
   //pathName : path.substring(0, path.lastIndexOf('/') +1);

   Label {
    id: main
    text: "xRx"
    //text: data.stdout
    //height: 400
    //width: 400
  }

  PlasmaCore.DataSource {
    id: xrxData
    engine: "executable"

    connectedSources: ['bash -c "'+exec+'parse-xrx-output.sh"']
        //connectedSources = [];

        onNewData: {
          modes = data.stdout;
          modeList = modes.split("\n");
          console.log(modes)
        }


      }

      ListModel {
       id: modeModel

       Component.onCompleted: {
        for (var i = 0, len = modeList.length; i < len; i++ ) {
          var line = modeList[i]
          bits = line.split(" ");
          output = bits[0];
          rez = bits[1];
          current = bits[2];

          append(createListElement(output, rez, current));
        }
      }
    }

    function createListElement(o, r, c) {
     return {output: o, resolution: r, current: c};

   }

   ListView {
    width: 150
    model: modeModel 
    delegate: Row {
        Label {
          text: resolution
        }
      }

   }


   MouseArea {
    id: mouseArea
    anchors.fill: parent

    onClicked: {
      if (mouse.button == Qt.LeftButton) {
        plasmoid.expanded = !plasmoid.expanded;
      }
      var url=Qt.resolvedUrl(".");
      var exec=url.substring(7,url.length);
      xrxData.connectedSources = ['bash -c "'+exec+'parse-xrx-output.sh"'];
      xrxData.connectedSources = [];
    }
  }
}


