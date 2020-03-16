//
//  MapViewController.swift
//  BreweriesList
//
//  Created by Ksenia on 3/16/20.
//

import MapKit
import UIKit

class MapViewController: UIViewController {

  // MARK: - Public properties

  var brewery: BreweryModel?

  // MARK: - Outlets

  @IBOutlet private weak var mapView: MKMapView!

  // MARK: - Private properties

  // MARK: - View controller view's lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    addPinOnMap()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    prepareNavigationController()
  }
  // MARK: - Navigation

  // MARK: - Actions

  // MARK: - Public API

  // MARK: - Private API

  private func prepareNavigationController() {
    self.navigationController?.navigationBar.tintColor = .black
    let titleLabel = UILabel()
    titleLabel.font = UIFont(name: "IowanOldStyleBT-Roman", size: 20)
    titleLabel.text = "Location"
    navigationItem.titleView = titleLabel
    let cancelButton = UIBarButtonItem.init(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    self.navigationItem.leftBarButtonItem = cancelButton
  }

  @objc func cancelButtonTapped() {
    self.dismiss(animated: true, completion: nil)
  }

  private func addPinOnMap() {
    guard let latitude = brewery?.latitude, let latitudeCoordinates = Double(latitude) else { return }
    guard let longitude = brewery?.longitude, let longitudeCoordinates = Double(longitude) else { return }
    let coordinates = CLLocationCoordinate2D(latitude: latitudeCoordinates, longitude: longitudeCoordinates)
    let annotation = MKPointAnnotation()
    annotation.coordinate = coordinates
    annotation.title = brewery?.name ?? ""
    annotation.subtitle = brewery?.street ?? ""
    mapView.addAnnotation(annotation)
    let region = MKCoordinateRegion.init(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
    mapView.setRegion(region, animated: true)
  }
}
