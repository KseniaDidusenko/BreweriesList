//
//  BreweryCell.swift
//  BreweriesList
//
//  Created by Ksenia on 3/15/20.
//

import UIKit

class BreweryCell: UITableViewCell {

  // MARK: - Public properties

  var webCompletion: EmptyClosure?
  var mapCompletion: EmptyClosure?

  // MARK: - Outlets

  @IBOutlet private weak var breweryName: UILabel!
  @IBOutlet private weak var phoneNumberLabel: UILabel!
  @IBOutlet private weak var countryNameLabel: UILabel!
  @IBOutlet private weak var stateLabel: UILabel!
  @IBOutlet private weak var cityLabel: UILabel!
  @IBOutlet private weak var streetLabel: UILabel!
  @IBOutlet private weak var showOnMapButton: UIButton!
  @IBOutlet private weak var websiteButton: UIButton!

  // MARK: - Private properties

  private var websiteUrl: URL?

  // MARK: - Actions

  @IBAction private func websiteButtonTapped(_ sender: UIButton) {
    self.webCompletion?()
  }

  @IBAction private func showOnMapButtonTapped(_ sender: UIButton) {
    self.mapCompletion?()
  }

  // MARK: - Public API

  func setupCell(_ brewery: BreweryModel) {
    setupLabel(breweryName, baseText: "", text: brewery.name)
    setupLabel(phoneNumberLabel, baseText: "Phone: ", text: brewery.phone)
    setupWebButton(websiteButton, baseText: "Website: ", text: brewery.websiteUrl)
    setupLabel(countryNameLabel, baseText: "Country: ", text: brewery.country)
    setupLabel(stateLabel, baseText: "State: ", text: brewery.state)
    setupLabel(cityLabel, baseText: "City: ", text: brewery.city)
    setupLabel(streetLabel, baseText: "Street: ", text: brewery.street)
    if brewery.latitude?.isEmpty ?? false || brewery.longitude?.isEmpty ?? false {
      showOnMapButton.isHidden = true
    }
  }

  // MARK: - Private API

  private func setupLabel(_ label: UILabel?, baseText: String, text: String?) {
    let baseTitle = NSMutableAttributedString(
      string: baseText,
      attributes: [.foregroundColor: UIColor.textLightGray])
    if let text = text, !text.isEmpty {
      let linkTitle = NSAttributedString(
        string: text,
        attributes: [.foregroundColor: UIColor.textDarktGray])
      baseTitle.append(linkTitle)
      label?.attributedText = baseTitle
    } else {
      label?.isHidden = true
    }
  }

  private func setupWebButton(_ button: UIButton?, baseText: String, text: String?) {
    let baseTitle = NSMutableAttributedString(
      string: baseText,
      attributes: [.foregroundColor: UIColor.textLightGray])
    if let text = text, !text.isEmpty {
      let linkTitle = NSAttributedString(
        string: text,
        attributes: [
          .foregroundColor: UIColor.textDarktGray,
          .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
      baseTitle.append(linkTitle)
      button?.setAttributedTitle(baseTitle, for: .normal)
    } else {
      button?.isHidden = true
    }
  }
}
