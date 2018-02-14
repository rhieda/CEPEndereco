//
//  Localizacao.swift
//  LocationByAddress
//
//  Created by Rafael  Hieda on 2/6/18.
//  Copyright © 2018 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class Localizacao: NSObject, MKAnnotation {
    
    
    var rua = ""
    var bairro = ""
    var uf = ""
    var localidade = ""
    var localizacao:CLLocation? = CLLocation()
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D

    init(_ EnderecoDict: Dictionary<String,String>) {
        rua = EnderecoDict["logradouro"] as String!
        bairro = EnderecoDict["bairro"] as String!
        uf = EnderecoDict["uf"] as String!
        localidade = EnderecoDict["localidade"] as String!
        coordinate = CLLocationCoordinate2D()
        

    }
    func fillCoordinates() {
        if let c = localizacao?.coordinate {
            coordinate = (localizacao?.coordinate)!
            title = "\(rua), \(bairro), \(uf)"
            subtitle = "lat: \(coordinate.latitude.description), long: \(coordinate.longitude.description)"
        }
    }
}
