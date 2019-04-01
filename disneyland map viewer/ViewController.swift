//
//  ViewController.swift
//  disneyland map viewer
//
//  Created by jae kaplan on 3/31/19.
//  Copyright © 2019 jae kaplan. All rights reserved.
//

import UIKit
import MapKit

class JKMapDelegate: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let overlay = overlay as? MKTileOverlay else { fatalError() }
        
        return MKTileOverlayRenderer(tileOverlay: overlay)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let disneylandCoordinates = CLLocationCoordinate2DMake(33.812029,-117.919006)
        
        let tileVersion = 58
        let tileOverlay = MKTileOverlay(urlTemplate: "https://cdn6.parksmedia.wdprapps.disney.com/media/maps/prod/disneyland/\(tileVersion)/{z}/{x}/{y}.jpg")
        tileOverlay.minimumZ = 14
        tileOverlay.maximumZ = 20
        tileOverlay.canReplaceMapContent = true
        tileOverlay.tileSize = CGSize(width: 512, height: 512)
        
        let mapDelegate = JKMapDelegate()
        
        mapView.delegate = mapDelegate
        
        // Define a region for our map view
        var mapRegion = MKCoordinateRegion()
        
        let mapRegionSpan = 0.02
        mapRegion.center = disneylandCoordinates
        mapRegion.span.latitudeDelta = mapRegionSpan
        mapRegion.span.longitudeDelta = mapRegionSpan
        
        mapView.setRegion(mapRegion, animated: true)
        
        mapView.isRotateEnabled = false
        
        mapView.addOverlay(tileOverlay, level: .aboveLabels)
    }


}

