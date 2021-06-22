//
//  CitiesListViewController.swift
//  REST API Usage
//  MusalaTask
//
//  Created by Ahmed Hosny Sayed on 6/19/21.
//  Copyright © 2021 ispha. All rights reserved.

import UIKit
import CoreLocation
import MapKit
protocol CitiesListDisplayLogic: AnyObject {
    func displayCities(cities: [CityModel])
}

class CitiesListViewController: UIViewController, CitiesListDisplayLogic, CLLocationManagerDelegate {
    
    // MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - variables
    
    var interactor: CitiesListBusinessLogic?
    var router: CitiesListRoutingLogic?
    
    private var  cityName = ""
    private var cityWOEID = ""
    weak var actionToEnable : UIAlertAction?
    
    let cellIdentifier = "CityTableViewCell"
    private var selectedCity: CityModel!
    private var citiesArray: [CityModel] = []
    private let cellXibName = "CityTableViewCell"
    private let screenTitle = "Choose country"
    var locationManager : CLLocationManager = CLLocationManager()
    var isLocationAccessDenied : Bool = false
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = CitiesListInteractor()
        let presenter = CitiesListPresenter()
        let router = CitiesListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.countriesFetcher = CitiesFetcher()
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doAnyAdditionalSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setValue("Cities", forKey: "title")
        
    }
    func doAnyAdditionalSetup()
    {
        setScreenTitle()
        configureTableView()
        interactor?.fetchCities()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//Kilometer
        locationManager.startUpdatingLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let showCountrySegueId = Constants.showCountryDetailsSegueIdentifier.rawValue
        if segue.identifier == showCountrySegueId {
            if segue.destination is CityDetailsViewController {
                ( segue.destination as! CityDetailsViewController).cityWOEID = "\(selectedCity.woeid!)"
            }
        }
    }
    
    // MARK: Private methods
    
    private func setScreenTitle() {
        title = screenTitle
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: cellXibName, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    // MARK: Public methods
    
    func displayCities(cities: [CityModel]) {
        self.citiesArray = cities
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: actions
    @IBAction func addNewWOEID(_ sender: Any) {
        enterCityInfo()
    }
    func enterCityInfo()
    {
        
        let alert = UIAlertController(title: "City Info!", message: "Plz input city name and WOEID", preferredStyle: UIAlertController.Style.alert )
        
        
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.placeholder = "city name"
            textField.addTarget(self, action: #selector(CitiesListViewController.textChanged(sender:)), for: .editingChanged)
        })
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            textField.placeholder = "city WOEID"
            textField.keyboardType = .numberPad
            textField.addTarget(self, action:#selector(CitiesListViewController.textChanged(sender:)), for: .editingChanged)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (_) -> Void in
            
        })
        
        let action = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { (_) -> Void in
            _ = alert.textFields!.first!
            self.citiesArray.append(CityModel(consolidatedWeather: nil, time: nil, sunRise: nil, sunSet: nil, timezoneName: nil, parent: nil, sources: nil, title: self.cityName, locationType: nil, woeid: Int(self.cityWOEID), lattLong: nil, timezone: nil))
            AppDelegate().syncDefaultCities(forceSync: true, defaultCities: self.citiesArray)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            //Do what you want with the textfield!
        })
        
        alert.addAction(cancel)
        alert.addAction(action)
        
        self.actionToEnable = action
        action.isEnabled = false
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func textChanged(sender:UITextField) {
        cityName = sender.placeholder == "city name" ? sender.text! : cityName
        cityWOEID = sender.placeholder == "city WOEID" ? sender.text! : cityWOEID
        self.actionToEnable?.isEnabled = (cityName != "" && cityWOEID != "")
    }
    
    
    
}

extension CitiesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                        for: indexPath) as? CityTableViewCell
        guard let cell = countryCell else { return UITableViewCell() }
        cell.configure(citiesArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = citiesArray[indexPath.row]
        router?.navigateToCityDetailsScreen()
    }
}


