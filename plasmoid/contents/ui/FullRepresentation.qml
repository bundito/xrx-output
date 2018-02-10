  import QtQuick 2.0
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

    ListModel {
      id: modeModel 
    }
   
    Rectangle {
    width: 180; height: 600

    Component {
        id: modeDelegate
        Item {
            width: 180
            height: 20
            Column {
                //Text { text: '<b>Output:</b> ' + output }
                Text { text: '<b>Mode:</b> ' + mode }
                //Text { text: '<b>Current:</b> ' + current }
            }
        }
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
          var lineData = line.split(" ");
          var line_output = lineData[0];
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