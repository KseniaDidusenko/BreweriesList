//
//  ViewController.swift
//  BreweriesList
//
//  Created by Ksenia on 3/12/20.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    BreweryService().receiveBreweries { result in
      switch result {
      case .success(let user):
        print("user")
      case .failure(let error):
        print(error.localizedDescription)
      }
    }

    BreweryService().receiveBreweryByName(name: "modern times") { result in
      switch result {
      case .success(let user):
        print(user)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
