//
//  BreweryModel.swift
//  BreweriesList
//
//  Created by Ksenia on 3/14/20.
//

import Foundation

struct BreweryModel: Codable {
  var id: Int
  var name: String?
  var breweryType: String
  var street: String?
  var city: String?
  var state: String?
  var postalCode: String?
  var country: String?
  var longitude: String?
  var latitude: String?
  var phone: String?
  var websiteUrl: String?
  var updatedAt: String?

  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case breweryType = "brewery_type"
    case street = "street"
    case city = "city"
    case state = "state"
    case postalCode = "postal_code"
    case country = "country"
    case longitude = "longitude"
    case latitude = "latitude"
    case phone = "phone"
    case websiteUrl = "website_url"
    case updatedAt = "updated_at"
  }
}
