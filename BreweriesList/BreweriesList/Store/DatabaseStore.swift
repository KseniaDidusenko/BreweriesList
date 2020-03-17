//
//  DatabaseStore.swift
//  BreweriesList
//
//  Created by Ksenia on 3/17/20.
//

import Foundation
import SQLite3

class DatabaseStore {

  let fileURL: URL?
  var db: OpaquePointer?
  var insertEntryStmt: OpaquePointer?
  var readEntryStmt: OpaquePointer?
  var updateEntryStmt: OpaquePointer?
  var deleteEntryStmt: OpaquePointer?

  init() {
    fileURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      .appendingPathComponent("BreweriesDatabase.sqlite")
    openDB()
    createTables()
  }

  func openDB() {
    guard let fileURL = fileURL else { return }
    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
      print("error opening database")
    }
  }

  func deleteDB(dbURL: URL) {
    do {
      try FileManager.default.removeItem(at: dbURL)
    } catch {
      print("error creating table")
    }
  }

  func createTables() {
    if sqlite3_exec(db,
                    "CREATE TABLE IF NOT EXISTS Breweries (id INTEGER PRIMARY KEY, name TEXT, street TEXT, city TEXT, state TEXT, country TEXT, longitude TEXT, latitude TEXT, phone TEXT, websiteUrl TEXT)",
                    nil,
                    nil,
                    nil) != SQLITE_OK {
      let errmsg = String(cString: sqlite3_errmsg(db))
      print("error creating table: \(errmsg)")
    }
  }

  func create(brewery: BreweryModel) {
    var stmt: OpaquePointer?

    let queryString = "INSERT INTO Breweries (id , name, street, city, state, country, longitude, latitude, phone, websiteUrl) VALUES (?,?,?,?,?,?,?,?,?,?)"

    guard sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK else {
      print("error preparing insert: \(String(cString: sqlite3_errmsg(db)))")
      return
    }
    if sqlite3_bind_int(stmt, 0, Int32(brewery.id)) != SQLITE_OK {
      print("failure binding name: \(String(cString: sqlite3_errmsg(db)))")
      return
    }
    if sqlite3_bind_text(stmt, 1, brewery.name, -1, nil) != SQLITE_OK {
      print("failure binding name: \(String(cString: sqlite3_errmsg(db)))")
      return
    }
    if sqlite3_bind_text(stmt, 2, brewery.street, -1, nil) != SQLITE_OK {
      print("failure binding name: \(String(cString: sqlite3_errmsg(db)))")
      return
    }
    if sqlite3_bind_text(stmt, 3, brewery.city, -1, nil) != SQLITE_OK {
      print("failure binding name: \(String(cString: sqlite3_errmsg(db)))")
      return
    }
    if sqlite3_bind_text(stmt, 4, brewery.state, -1, nil) != SQLITE_OK {
      print("failure binding name: \(String(cString: sqlite3_errmsg(db)))")
      return
    }
    if sqlite3_bind_text(stmt, 5, brewery.country, -1, nil) != SQLITE_OK {
      print("failure binding name: \(String(cString: sqlite3_errmsg(db)))")
      return
    }
    if sqlite3_bind_text(stmt, 6, brewery.longitude, -1, nil) != SQLITE_OK {
      print("failure binding name: \(String(cString: sqlite3_errmsg(db)))")
      return
    }
    if sqlite3_bind_text(stmt, 7, brewery.latitude, -1, nil) != SQLITE_OK {
      print("failure binding name: \(String(cString: sqlite3_errmsg(db)))")
      return
    }
    if sqlite3_bind_text(stmt, 8, brewery.phone, -1, nil) != SQLITE_OK {
      print("failure binding name: \(String(cString: sqlite3_errmsg(db)))")
      return
    }
    if sqlite3_bind_text(stmt, 9, brewery.websiteUrl, -1, nil) != SQLITE_OK {
      print("failure binding name: \(String(cString: sqlite3_errmsg(db)))")
      return
    }

    if sqlite3_step(stmt) != SQLITE_DONE {
      let errmsg = String(cString: sqlite3_errmsg(db))
      print("failure inserting hero: \(errmsg)")
      return
    }
  }

  func readValues(breweriesList: [BreweryModel]) -> [BreweryModel] {
    var breweriesData = breweriesList
    breweriesData.removeAll()
    let queryString = "SELECT * FROM Breweries"
    var stmt: OpaquePointer?
    if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
      let errmsg = String(cString: sqlite3_errmsg(db))
      print("error preparing insert: \(errmsg)")
      return [BreweryModel]()
    }
    while sqlite3_step(stmt) == SQLITE_ROW {
      let id = sqlite3_column_int(stmt, 0)
      let name = String(cString: sqlite3_column_text(stmt, 1))
      let street = String(cString: sqlite3_column_text(stmt, 2))
      let city = String(cString: sqlite3_column_text(stmt, 3))
      let state = String(cString: sqlite3_column_text(stmt, 4))
      let country = String(cString: sqlite3_column_text(stmt, 5))
      let longitude = String(cString: sqlite3_column_text(stmt, 6))
      let latitude = String(cString: sqlite3_column_text(stmt, 7))
      let phone = String(cString: sqlite3_column_text(stmt, 8))
      let websiteUrl = String(cString: sqlite3_column_text(stmt, 9))
      breweriesData.append(BreweryModel(id: Int(id),
                                        name: name,
                                        breweryType: "",
                                        street: street,
                                        city: city,
                                        state: state,
                                        postalCode: "",
                                        country: country,
                                        longitude: longitude,
                                        latitude: latitude,
                                        phone: phone,
                                        websiteUrl: websiteUrl,
                                        updatedAt: ""))
    }
    return breweriesData
  }
}
