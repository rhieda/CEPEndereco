//
//  ViewController.swift
//  LocationByAddress
//
//  Created by Rafael  Hieda on 2/6/18.
//  Copyright © 2018 Rafael Hieda. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol EnviaLocalizacaoDelegate {
    func enviaLocalizacao(_ localizacao:Localizacao)
}

class ViewController: UIViewController, RetornaLocalizacaoDelegate, UITextFieldDelegate, MKMapViewDelegate{

    @IBOutlet var mapa: MKMapView!
    @IBOutlet weak var textField: UITextField!
    
    fileprivate var _location:Localizacao!
    fileprivate var localizacaoDelegate = LocalizacaoDelegate()
    var enviaLocDelegate: EnviaLocalizacaoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapa.delegate = self
        localizacaoDelegate.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        textField.delegate = self
        
    }
    @IBAction func CEPChangedTF(_ sender: UITextField) {
        EnderecoAPI().EnderecoPorCEP((sender.text)!, sucesso: { (location) in
            self._location = location
            self.localizacaoDelegate.preencherCoordernadas(self._location)
        }) { (error) in
            print(error)
            self.presentAlertView(error.localizedDescription)
        }

    }
    @IBAction func centralizaMapaTF(_ sender: Any) {
        guard let coord = _location?.coordinate else { return }
            self.centralizaMapa()
            self.criarAnnotation()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retornaLocalizacao(_ loc: CLLocation) {
        _location.localizacao = loc
        _location.fillCoordinates()
        print(self._location.localizacao?.coordinate.latitude)
        print(self._location.localizacao?.coordinate.longitude)
        centralizaMapa()
    }
    
    func centralizaMapa() -> Void {
        let regionRadius: CLLocationDistance = 100
        if let coordenada = _location.localizacao?.coordinate {
            let coordernadaRegion = MKCoordinateRegionMakeWithDistance(coordenada, regionRadius, regionRadius)
            
            mapa.setRegion(coordernadaRegion, animated: true)
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func criarAnnotation() {
        if let loc = _location.localizacao {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
//            mapa.addAnnotation(annotation)
            mapa.addAnnotation(_location)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsSegue" {
            if let nextVC = segue.destination as? DetailsTableViewController {
//                nextVC.localizacao = self._location
                self.enviaLocDelegate = nextVC
                enviaLocDelegate?.enviaLocalizacao(self._location)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotationLoc = self._location else {return nil}
        let identifier = "marker"
        var view:MKMarkerAnnotationView
        if let dequeuedView = mapa.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView  {
            dequeuedView.annotation = annotationLoc
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotationLoc, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func presentAlertView(_ message:String)  {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK!", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

