//
//  LocalizacaoDelegate.swift
//  LocationByAddress
//
//  Created by Rafael  Hieda on 2/7/18.
//  Copyright © 2018 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreLocation

protocol RetornaLocalizacaoDelegate {
    func retornaLocalizacao(_ loc:CLLocation)
}

class LocalizacaoDelegate: NSObject {
    
    var delegate: RetornaLocalizacaoDelegate?
    func preencherCoordernadas(_ localizacao:Localizacao) -> Void {
        
        if let loc:Localizacao = localizacao {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString("\(loc.rua), \(loc.localidade),  \(loc.uf), Brazil") { (placemarks, error) in
                
                if let placemark = placemarks?.first {
                    let lat = placemark.location?.coordinate.latitude
                    let lon = placemark.location?.coordinate.longitude
                    
                    print("Lat: \(String(describing: lat)), Lon: \(String(describing: lon))")
                    self.delegate?.retornaLocalizacao(placemark.location!)
                } else {
                    print("Não foi possivel finalizar a busca de latitude e longitude")
                }
            }
        }
        
    }
}
