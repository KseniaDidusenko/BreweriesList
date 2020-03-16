//
//  BreweriesViewController.swift
//  BreweriesList
//
//  Created by Ksenia on 3/15/20.
//

import UIKit

class BreweriesViewController: UIViewController {

  // MARK: - Public properties

  // MARK: - Outlets

  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var searchBar: UISearchBar!

  // MARK: - Private properties

  private var breweriesList = [BreweryModel]()
  private var searchResult = [BreweryModel]()
  private var cellSpacingHeight: CGFloat = 6
  private let searchController = UISearchController(searchResultsController: nil)
  private var searchActive: Bool = false

  // MARK: - View controller view's lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchBar()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    prepareNavigationController()
    navigationController?.navigationBar.barStyle = .black
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getBreweriesList()
  }
  // MARK: - Navigation

  // MARK: - Actions

  // MARK: - Public API

  // MARK: - Private API

  private func prepareNavigationController() {
    navigationItem.setRightBarButton(nil, animated: true)

    let titleLabel = UILabel()
    titleLabel.isUserInteractionEnabled.toggle()
    titleLabel.font = UIFont(name: "IowanOldStyleBT-Roman", size: 20)
    titleLabel.textColor = .white
    titleLabel.text = "Breweries"
    navigationItem.titleView = titleLabel
  }

  private func setupSearchBar() {
    if #available(iOS 13.0, *) {
      searchBar.searchTextField.backgroundColor = UIColor.white
    }
    definesPresentationContext = true
    extendedLayoutIncludesOpaqueBars = true
    searchBar.delegate = self
    searchBar.tintColor = .lightGray
  }

  private func getBreweriesList() {
    BreweryService().receiveBreweries { result in
      switch result {
      case .success(let breweries):
        print(breweries)
        self.breweriesList = breweries
        self.searchResult = self.breweriesList
        self.tableView.reloadData()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

  private func searchBreweryByName(name: String) {
    BreweryService().receiveBreweryByName(name: name) { result in
      switch result {
      case .success(let breweries):
        self.searchResult = breweries
        self.tableView.reloadData()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}

extension BreweriesViewController: UITableViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    searchBar.resignFirstResponder()
  }
}

extension BreweriesViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResult.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      as? BreweryCell else { return UITableViewCell() }
    cell.setupCell(searchResult[indexPath.row])
    return cell
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      return cellSpacingHeight
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let headerView = UIView()
      headerView.backgroundColor = UIColor.clear
      return headerView
  }
}

extension BreweriesViewController: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    searchBar.text = ""
    searchBar.resignFirstResponder()
    searchResult = breweriesList
    tableView.reloadData()
  }

  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    tableView.setContentOffset(.zero, animated: false)
    return true
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBreweryByName(name: searchBar.text ?? "")
    searchBar.showsCancelButton = true
  }
}
