//
//  ViewController.swift
//  LocationByAddress
//
//  Created by Rafael  Hieda on 2/6/18.
//  Copyright © 2018 Rafael Hieda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var _location:Localizacao!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func CEPChangedTF(_ sender: UITextField) {
        EnderecoAPI().EnderecoPorCEP((sender.text)!, sucesso: { (location) in
            self._location = location
        }) { (error) in
            print(error)
        }

    }
    
    func preencherCoordernadas() -> Void {
        
        if let loc:Localizacao = self.location {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString("\(loc.rua), \(loc.uf), Brazil") { (placemarks, error) in
                
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

