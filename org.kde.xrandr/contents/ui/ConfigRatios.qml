import QtQuick 2.7
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1 as Layout



Item {

	property var url:Qt.resolvedUrl(".");
	property var exec:url.substring(7,url.length);
	property string path;
	property var xrxDataSource: 'bash -c "'+exec+'parse-xrx-output.sh"'
	property var display;
	property var xrandr_str;
	property var modeList;
	property var modeCount: 0

	property alias cfg_r1610: r1610.checked
	property alias cfg_r169:  r169.checked
	property alias cfg_r54:   r54.checked
	property alias cfg_r43:   r43.checked
	property alias cfg_r32:   r32.checked
	property alias cfg_rodd:  rodd.checked



	Layout.GridLayout {
		columns: 2
		
		//width: 500
		//Layout.fillWidth: true

		 	CheckBox {
		 		id: r1610
		 		onClicked: {
		 			plasmoid.configuration[r1610] = !plasmoid.configuration[r1610];
		 			countUpdate();
		 		}
		 		
		 	}

			Label {
				width: 200
				horizontalAlignment: Qt.AlignRight
			//	anchors.fill: parent
				text: "16:10"
				height: theme.defaultFont.pixelSize

			}

			
		

			CheckBox {
				id: r169
				onClicked: {
					plasmoid.configuration[r169] = !plasmoid.configuration[r169];
					countUpdate();
				}

			}
	
		Label {
			width: 200
			horizontalAlignment: Text.AlignRight
			//anchors.fill: parent
			text: "16:9"
			height: theme.defaultFont.pixelSize
		}
	

		CheckBox {
			id: r54
			onClicked: {
				plasmoid.configuration[r54] = !plasmoid.configuration[r54];
				countUpdate();
			}

		}

		Label {
			width: 200
			horizontalAlignment: Text.AlignRight
			//anchors.fill: parent
			height: theme.defaultFont.pixelSize
			text: "5:4"
		}



		CheckBox {
			id: r43
			onClicked: {
				plasmoid.configuration[r43] = !plasmoid.configuration[r43];
				countUpdate();
			}
		}

		Label {
			width: 200
			horizontalAlignment: Text.AlignRight
			//anchors.fill: parent
			text: "4:3"
			height: theme.defaultFont.pixelSize
		}



		CheckBox {
			id: r32
			onClicked: {
				plasmoid.configuration[r32] = !plasmoid.configuration[r32];
				countUpdate();
			}
		}


		Label {
			width: 200
			horizontalAlignment: Text.AlignRight
			//anchors.fill: parent
			text: "3:2"
			height: theme.defaultFont.pixelSize
		}



		CheckBox {
			id: rodd
			onClicked: {
				plasmoid.configuration[rodd] = !plasmoid.configuration[rodd];
				countUpdate();
			}
		}

		Label {
			width: 200
			horizontalAlignment: Text.AlignRight
			//anchors.fill: parent
			text: "Rare/Unusual"
			height: theme.defaultFont.pixelSize
		}
	}

	

	   PlasmaCore.DataSource {
	    id: xrxData
	    engine: "executable"
	  connectedSources: [xrxDataSource]        //connectedSources = [];

	  onNewData: {
	  	modeCount = 0;
	    var modes = data.stdout;
	    var modeList = modes.split("\n");
	    //console.log(modes)
	    for (var i = 0, len = modeList.length; i < len; i++ ) {
	      var line = modeList[i]
	      if (line == "") {continue;}
	      var lineData = line.split(" ");
	      var line_output = lineData[0];
	      display = line_output;
	      var line_mode = lineData[1];
	      if (line_mode.indexOf("i") > 0) {continue;}
	      var line_current = lineData[2];
	      //if (line_current == "current") {old_mode = line_mode;}

	      var modeXY = line_mode.split("x");
	      var ratio = (modeXY[0] / modeXY[1]);
	      ratio = Math.round(ratio * 1000) / 1000;
	      
	      switch(ratio.toString()) {
	        case "1.778":
	          var format = "cfg_r169";
	          break;
	        case "1.6":
	          var format = "cfg_r1610";
	          break;
	        case "1.25":
	          var format = "cfg_r54";
	          break;
	        case "1.333":
	          var format = "cfg_r43";
	          break;
	        case "1.5":
	          var format = "cfg_r32";
	          break;
	        default:
	        var format = "cfg_rodd";
	      }

	      if (eval(format) == true) {
	        //console.log("Flag " + format);
	        modeCount = modeCount + 1;
	       // modeModel.append({output:line_output, mode:line_mode, current:line_current});
	      }

	      console.log(line_mode, ratio, format);

	     
	    } // end for
	    disconnectSource(xrxDataSource);
	    console.log(modeCount)
	    plasmoid.configuration.modeCount = modeCount;
	    //displayRect.height = ((theme.defaultFont.pixelSize * 1.5) * modeModel.count) + 10;
	  } // end onNewData
	} // end DataSource

	function countUpdate() {
		xrxData.connectedSources = xrxDataSource;
	}

}
