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
    
    let getLocationTask = DispatchQueue(label: "getLocationTask")
    let createLandMarker = DispatchQueue(label: "createLandMarker")
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGMSCamera() 
    }
    
    // 設定起始畫面
    func setGMSCamera() {
        let camera = GMSCameraPosition.camera(
            withLatitude: 23.7,
            longitude: 121,
            zoom: 7.3
        )
        mapView.camera = camera
        // 顯示使用者位置按鈕
//        mapView.settings.myLocationButton = true
//        mapView.isMyLocationEnabled = true // 開啟我的位置(藍色小點)
        mapView.delegate = self
    }
    
    func changeGMSCamera(latitude: Double, longitude: Double, zoom: Float = 15) {
        let camera = GMSCameraPosition.camera(
            withLatitude: latitude,
            longitude: longitude,
            zoom: zoom
        )
        mapView.camera = camera
    }
    
    func setLandMarker(from hospitals: [Hospital]) {
        
        // 查詢要顯示的醫院座標
        hospitals.forEach { hospital in
            let address = hospital.address
            group.enter()
            getLocationTask.async(group: group, qos: .default) {
                // 查詢 core data 中是否已有儲存座標資訊
                StorageManager.shared.featchHospitals(address: address) {[weak self] result in
                    switch result {
                    case .success(let hospitals):
                        self?.pnHospitals.append(hospitals[0])
                        self?.group.leave()
                        
                    case .failure:
                        // 若無則透過 CoreLocation 查詢座標資訊
                        self?.getLocationWithCoreLocation(hospital)
                    }
                }
            }
        }
        
        // 將所有座標製作圖釘顯示在地圖上
        group.notify(queue: .main) { [weak self] in
            guard let pnHospitals = self?.pnHospitals else { return }
            self?.createMarker(pnHospitals: pnHospitals)
        }
    }
    
    // 處理地址轉座標回傳結果
    func getLocationWithCoreLocation(_ hospital: Hospital) {
        
        getLocation(address: hospital.address) {[weak self] result in
            switch result {
            case .success(let placeMark):
                guard
                    let location = placeMark.location?.coordinate
                else {
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
                
                StorageManager.shared.saveAll()
                
                self?.pnHospitals.append(pnHospitalObject)
                self?.group.leave()
                
            case .failure(let error):
                print(error)
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
                return
            }
            
            guard
                let placemarks = placemarks,
                let placemark = placemarks.first
            else {                completionHandler(Result.failure(MapError.noPlacemarkReturn))
                return
            }
            
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
        marker.snippet = pnHospital.address
        marker.map = mapView
        return marker
    }
    
    func createMarker(pnHospitals: [PNHospital]) {
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
        
        // prepar markerInfo view
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        view.backgroundColor = UIColor.pnBlueDark
        view.addCorner(cornerRadius: 3)
        
        let titleLabel = UILabel()
        titleLabel.text = marker.title
        titleLabel.textColor = .white
        
        let discribeLabel = UILabel()
        discribeLabel.text = "點擊規劃路線"
        discribeLabel.textColor = .white
        discribeLabel.font = discribeLabel.font.withSize(14)
        
        view.addSubview(titleLabel)
        view.addSubview(discribeLabel)
               
        view.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        discribeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: discribeLabel.topAnchor, constant: -3),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            discribeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            discribeLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        
        return view
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        let latitude = marker.position.latitude
        let longitude = marker.position.longitude
        
        // 跳轉至 google map
        if let url =
            URL(string: MapNavigation.google(
                latitude: latitude,
                longitude: longitude).url),
            UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        // 跳轉至 apple map
        } else if let url =
            URL(string: MapNavigation.apple(
                latitude: latitude,
                longitude: longitude).url),
            UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        } else {
            // 沒有可跳轉的地圖
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
}

enum MapError: Error {
    case noPlacemarkReturn
}

enum MapNavigation {
    case google(latitude: Double, longitude: Double)
    case apple(latitude: Double, longitude: Double)
    
    var url: String {
        switch self {
        case .google(let latitude, let longitude):
            return "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving"
        case .apple(let latitude, let longitude):
            return "http://maps.apple.com/?saddr=&daddr=\(latitude),\(longitude)"
        }
    }
}
