//
//  ViewController.swift
//  Map
//
//  Created by Khamitov Darkhan on 3/21/21.
//

import UIKit
import MapKit
import CoreData


class ViewController: UIViewController, MKMapViewDelegate, ChangeLocation, deleteAnnotation {
    func delete(annotation: MKAnnotation) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<Location> = Location.fetchRequest()
        if let locations = try? context.fetch(fetchRequest){
            for pin in locations{
                context.delete(pin)
                
            }
        }
        myMap.removeAnnotation(annotation)
    }
    

    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
     let annotation = view.annotation
     let index = (self.myMap.annotations as NSArray).index(of: annotation!)
     print ("Annotation Index = \(index)")
    locationIndex = index
    }
    
    
    var locationTitle: String?
    var locationSubtitle: String?
    var locationIndex: Int?
    var annotation: MKAnnotation?
    var coordinate: CLLocationCoordinate2D?
    var locations : [Location] = []
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Annotation")
        annotationView.pinTintColor = .blue
        annotationView.isDraggable = true
        annotationView.animatesDrop = true
        annotationView.canShowCallout = true
        let btn = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = btn
        return annotationView
    }
    
    func change(annotation: MKAnnotation, title: String, subtitle: String) {
        myMap.removeAnnotation(annotation)
        let annotationNew = MKPointAnnotation()
        annotationNew.title = title
        annotationNew.subtitle = subtitle
        annotationNew.coordinate = annotation.coordinate
        myMap.addAnnotation(annotationNew)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let location = view.annotation as? MKPointAnnotation else {return}
        
        annotation = location
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    func saveAnnotation(annotation: MKAnnotation) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        
        guard let entity =  NSEntityDescription.entity(forEntityName: "Location", in: context)
        else{return}
        
        let mapObject = Location(entity: entity, insertInto: context)
        mapObject.title = annotation.title!!
        mapObject.subtitle = annotation.subtitle!!
        mapObject.latitude = annotation.coordinate.latitude
        mapObject.longitude = annotation.coordinate.longitude
        
        do{
            try context.save()
        } catch let error as NSError{
            print(error.localizedDescription)

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Location> = Location.fetchRequest()
        
        do {
            locations = try context.fetch(fetchRequest)
            for pin in locations{
                for annotation in myMap.annotations{
                    if (annotation.title == pin.title){
                        self.myMap.removeAnnotation(annotation)
                    }
                let currentAnnotation = MKPointAnnotation()
                currentAnnotation.title = pin.title
                currentAnnotation.subtitle = pin.subtitle
                currentAnnotation.coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
                myMap.addAnnotation(currentAnnotation)
                }
            }
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let destination = segue.destination as! DetailVC
            destination.myTitle = (annotation?.title)!
            destination.mySubtitle = (annotation?.subtitle)!
            destination.index = locationIndex
            destination.annotation = annotation
            destination.delegate = self
        }
        else if segue.identifier == "pins"{
            let destination = segue.destination as! PinsVC
            destination.pins = myMap.annotations
            destination.delegate = self
            destination.deleteDelegate = self
        }
    }
    
    var mapType: [Int: MKMapType] = [0 : .hybrid, 1: .standard, 2: .satellite]
    
    @IBOutlet weak var myMap: MKMapView!
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        myMap.mapType = mapType[sender.selectedSegmentIndex] ?? .standard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.mapType = .standard
        myMap.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func longTap(_ sender: UILongPressGestureRecognizer) {
        let touchPoint = sender.location(in: self.myMap)
        let coordinate = self.myMap.convert(touchPoint, toCoordinateFrom: self.myMap)
        
        
        let alertController = UIAlertController(title: "New Location", message: "Fill the fields", preferredStyle: .alert)
        alertController.addTextField{(textfield) in textfield.placeholder = "Location"
        }
        alertController.addTextField{(textfield) in textfield.placeholder = "Description"
        }
        let save = UIAlertAction(title: "Ok", style: .default){[weak self](alert) in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            
            
            let annotation = MKPointAnnotation()
            annotation.title = firstTextField.text
            annotation.subtitle = secondTextField.text
            annotation.coordinate = coordinate
            
            
            self?.myMap.addAnnotation(annotation)
            self?.saveAnnotation(annotation: annotation)
            self?.myMap?.selectAnnotation(annotation, animated: true)

        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        myMap.setRegion(MKCoordinateRegion(center: coordinate!, span: span), animated: true)
        navigationItem.title = locationTitle
    }
    
    @IBAction func leftPressed(_ sender: Any) {
        if (locationIndex!>0){
            locationIndex = locationIndex! - 1
            annotation = myMap.annotations[locationIndex!]
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            myMap.setRegion(MKCoordinateRegion(center: annotation!.coordinate, span: span), animated: true)
            navigationItem.title = (annotation?.title)!
        }
    }
    
    @IBAction func rightPressed(_ sender: Any) {
        if (locationIndex!+1<myMap.annotations.count){
            print(locationIndex!)
            locationIndex = locationIndex! + 1
            annotation = myMap.annotations[locationIndex!]
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            myMap.setRegion(MKCoordinateRegion(center: annotation!.coordinate, span: span), animated: true)
            navigationItem.title = (annotation?.title)!
        }
    }
    
}

