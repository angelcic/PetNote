//
//  MapViewController.swift
//  PetNote
//
//  Created by iching chen on 2019/10/4.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: BaseViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var hospitals: [Hospital] = [] {
        didSet {
            setLandMarker(from: hospitals)
        }
    }
    
    var pnHospitals: [PNHospital] = []
    
    var markers: [GMSMarker] = []
    
//    let infoMarker = GMSMarker()
//    var geocoder = CLGeocoder()
    
    let getLocationTask = DispatchQueue(label: "getLocationTask")
    let createLandMarker = DispatchQueue(label: "createLandMarker")
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGMSCamera() 
    }
    
    // 設定起始畫面
    func setGMSCamera() {
//        let camera = GMSCameraPosition.camera(withLatitude: position.latitude, longitude: position.longitude, zoom: 16.0)
        let camera = GMSCameraPosition.camera(
            withLatitude: 23.7,
            longitude: 121,
            zoom: 7.3
        )
        mapView.camera = camera
//        mapView.isMyLocationEnabled = true // 開啟我的位置(藍色小點)
        mapView.delegate = self
    }
    
    func changeGMSCamera(latitude: Double, longitude: Double, zoom: Float = 16) {
        let camera = GMSCameraPosition.camera(
            withLatitude: latitude,
            longitude: longitude,
            zoom: zoom
        )
        mapView.camera = camera
    }
    
    // 查詢要顯示的醫院座標
    func setLandMarker(from hospitals: [Hospital]) {
                
        hospitals.forEach { hospital in
            let address = hospital.address
            group.enter()
            print("====== enter")
            getLocationTask.async(group: group, qos: .default) {
                StorageManager.shared.featchHospitals(address: address) {[weak self] result in
                    switch result {
                    case .success(let hospitals):
                        self?.pnHospitals.append(hospitals[0])
//                        self?.createMarker(pnHospital: hospitals[0])
//                        self?.createMarker(pnHospital: hospitals[0])
                        print("===(1)leave \(hospitals[0].name)")
                        self?.group.leave()
                    case .failure:
                        print("(2)")
                        self?.getLocationWithCoreLocation(hospital)
                    }
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let pnHospitals = self?.pnHospitals else { return }
            self?.createMarker(pnHospitals: pnHospitals)
        }
    }
    
    // 用地址查詢座標
    func getLocationWithCoreLocation(_ hospital: Hospital) {
        getLocation(address: hospital.address) {[weak self] result in
            switch result {
            case .success(let placeMark):
                guard
                    let location = placeMark.location?.coordinate
                else {
                    print("===(2)leave (location = nil)")
                    self?.group.leave()
                    return
                }
                
                let pnHospitalObject = StorageManager.shared.getPNHospital()
                
                pnHospitalObject.setupPNHospital(
                    address: hospital.address,
                    name: hospital.name,
                    phone: hospital.phone,
                    latitude: location.latitude,
                    longitude: location.longitude
                )
                
//                StorageManager.shared.saveAll()
                
                self?.pnHospitals.append(pnHospitalObject)
//                self?.createMarker(pnHospital: pnHospitalObject)
//                self?.createMarker(pnHospital: pnHospitalObject)
                print("===(2)leave \(pnHospitalObject.name)")
                self?.group.leave()
            case .failure(let error):
                print(error)
                print("===(2)leave (nil)")
                self?.group.leave()
                return
            }
        }
    }
    
    // 用 CoreLocation 把地址轉座標
    func getLocation(address: String,
                     completionHandler: @escaping (Result<CLPlacemark, Error>) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            
            if let error = error {
                
                completionHandler(Result.failure(error))
                
            }
            
            guard
                let placemarks = placemarks,
                let placemark = placemarks.first,
                let location = placemark.location
            else {                completionHandler(Result.failure(MapError.noPlacemarkReturn))
                return
            }
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print("Lat: \(lat), Lon: \(lon)")
            completionHandler(Result.success(placemark))
            
        }
    }
    
    func createMarker(pnHospital: PNHospital) -> GMSMarker {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(
            latitude: pnHospital.latitude,
            longitude: pnHospital.longitude
        )
        marker.title = pnHospital.name
//        marker.snippet = "AppWorksSchool"
        marker.map = mapView
        return marker
    }
    
    func createMarker(pnHospitals: [PNHospital]) {
        print("========= create")
        markers = []
        pnHospitals.forEach {
            let marker = createMarker(pnHospital: $0)
            markers.append(marker)
        }
        
        if markers.count > 0 {
            let position = markers[0].position
            changeGMSCamera(latitude: position.latitude,
                            longitude: position.longitude)
        }
    }
}

extension MapViewController: GMSMapViewDelegate {
    // 回傳點擊後要顯示的 View
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        // TODO: prepar markerInfo view
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        view.backgroundColor = .systemYellow
        let title = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: view.frame.size))
        title.text = marker.title
        view.addSubview(title)
        
        return view
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        // TODO: 依據選取的 marker 顯示資料
        
        return false
    }
}

enum MapError: Error {
    case noPlacemarkReturn
}
