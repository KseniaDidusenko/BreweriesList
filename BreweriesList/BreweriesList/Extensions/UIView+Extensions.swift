//
//  UIView+Extensions.swift
//  BreweriesList
//
//  Created by Ksenia on 3/15/20.
//

import UIKit

extension UIView {

  @IBInspectable var cornerRadius: CGFloat {
    set {
      layer.cornerRadius = newValue
      clipsToBounds = newValue > 0
    }
    get { return layer.cornerRadius }
  }

  @IBInspectable var borderWidth: CGFloat {
    set { layer.borderWidth = newValue }
    get { return layer.borderWidth }
  }

  @IBInspectable var borderColor: UIColor? {
    set { layer.borderColor = newValue?.cgColor }
    get { return layer.borderColor.map { UIColor(cgColor: $0) } }
  }
}
