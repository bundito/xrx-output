import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQml 2.2




Item {

  //property string path;
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
    connectedSources: []
    //connectedSources: ['/home/bundito/projects/xrx-output/plasmoid/contents/ui/parse-xrx-output.sh']
    onNewData: {
      var modes = data.stdout;
      var modeList = modes.split("\n");
      var mode = modeList[0];
      console.log(mode);
      main.text = mode
    }
  }

 ListModel {
     id: modeModel
     modeList.foreach: line {
         var bits = line.split(" ");
         var ouptput = bits[0];
         var rez = bits[1];
         var current = bits[2];

         ListModel.append({"output": output, "rez": rez, "current": current})
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
s
