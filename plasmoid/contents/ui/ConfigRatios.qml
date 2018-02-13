import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import org.kde.kquickcontrols 2.0



Item {

	

	property alias cfg_r1610: r1610.checked
	property alias cfg_r169:  r169.checked
	property alias cfg_r54:   r54.checked
	property alias cfg_r43:   r43.checked
	property alias cfg_r32:   r32.checked
	property alias cfg_rodd:  rodd.checked

	GridLayout {
		columns: 2
		
		//width: 500
		//Layout.fillWidth: true

		 	CheckBox {
		 		id: r1610
		 		
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
		}

		Label {
			width: 200
			horizontalAlignment: Text.AlignRight
			//anchors.fill: parent
			text: "Rare/Unusual"
			height: theme.defaultFont.pixelSize
		}

}
	}
