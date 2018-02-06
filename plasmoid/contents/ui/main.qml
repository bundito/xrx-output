import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    //property Component compactRepr: CompactRepresentation {}
    //property Component fullRepr: FullRepresentation {}


    PlasmaCore.DataSource {
      id: xrxData
      engine: "executable"
      connectedSources: ['ui/parse-xrx-output.sh']
      onNewData: {
        var xrx = data.stdout
      }
    }

    Plasmoid.compactRepresentation : CompactRepresentation {}
    Plasmoid.fullRepresentation : FullRepresentation {}
    Plasmoid.preferredRepresentation: Plasmoid.FullRepresentation



}


//}
