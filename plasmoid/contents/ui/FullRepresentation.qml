import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
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


  

  ListView {

    ListModel {id: modeModel}

    delegate: Row {
      Label {
       width: 150
       height: 30
       text: "modeModel.mode"
     }

    }

  PlasmaCore.DataSource {
   id: xrxData
   engine: "executable"
     connectedSources: ['bash -c "'+exec+'parse-xrx-output.sh"']        //connectedSources = [];

     onNewData: {
       modes = data.stdout;
       modeList = modes.split("\n");
       console.log(modes)
       for (var i = 0, len = modeList.length; i < len; i++ ) {
         var line = modeList[i]
         addToModeModel(line);
       } // end for


     } // end onNewData

     function addToModeModel(entry) {
       modeModel.append({"mode": entry});
     }

     } // end DataSource

} // end Item

}