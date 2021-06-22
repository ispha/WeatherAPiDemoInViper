//
//  CountryDetailsViewController.swift
//  MusalaTask
//
//  Created by Ahmed Hosny Sayed on 6/19/21.
//  Copyright © 2021 ispha. All rights reserved.
//

import UIKit
import Kingfisher
protocol CityDetailsDisplayLogic: AnyObject {
    func displayInfo(city: City?)
    func showHideLoadingView(setHidden:Bool)
}
class CityDetailsViewController: UIViewController {
    // MARK: outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    // MARK: variables
    let screenTitle = "Weather Days"
    var city: City!
    var cityWOEID : String?
    var interactor : CityDetailsBusinessLogic!
    var router : CityDetailsRoutingLogic!
    var selectedSection = -1
    
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
        let interactor = CityDetailsInteractor()
        let presenter = CityDetailsPresenter()
        let router = CityDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        interactor.countriesFetcher = CitiesFetcher()
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = screenTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doAnyAdditionalSetup()
    }
    func doAnyAdditionalSetup()
    {
        registerNibFiles()
        
        
        guard (cityWOEID != nil)
        else
        {
            print("City WOEID is not valid!")
            return
        }
        showHideLoadingView(setHidden: false)
        interactor.fetchCityDetails(cityWOEID: cityWOEID!)
       
        
    }
    func registerNibFiles() {
        tableView.register(UINib(nibName: WeatherHeaderSectionTableViewCell.identifier(), bundle: nil),
                                   forCellReuseIdentifier: WeatherHeaderSectionTableViewCell.identifier())
        tableView.register(UINib(nibName: WeatherHeaderSectionTableViewCell.identifier(), bundle: nil),
                                   forHeaderFooterViewReuseIdentifier: WeatherHeaderSectionTableViewCell.identifier())
        tableView.register(UINib(nibName: WeatherDetailsTableViewCell.identifier(), bundle: nil),
                                   forCellReuseIdentifier: WeatherDetailsTableViewCell.identifier())
      
    }
    
   @objc func actionOfBtnExpanfCollaps(sender: UIButton) {
       if selectedSection != -1 {
           let headerView = tableView.headerView(forSection:selectedSection) as! WeatherHeaderSectionTableViewCell
           let outeltofbtn =  headerView.outeltOfBtn
                                
        outeltofbtn?.backgroundColor =  .darkGray
          // headerView.backgroundColor = UIColor.white
           outeltofbtn?.backgroundColor =  UIColor.white
        outeltofbtn?.layer.borderColor =  UIColor.darkGray.cgColor
           UIView.animate(withDuration: 0.5) {
               outeltofbtn?.imageView?.transform = .identity
              // headerView.contentView.backgroundColor = UIColor.white
           }
       }
       selectedSection = selectedSection == sender.tag ? -1 : sender.tag
       tableView?.beginUpdates()
       tableView?.endUpdates()
       if selectedSection != -1 {
           let headerView =  tableView.headerView(forSection:selectedSection) as! WeatherHeaderSectionTableViewCell
           let outeltofbtn =  headerView.outeltOfBtn
        outeltofbtn?.backgroundColor =  UIColor.darkGray
       // headerView.contentView.backgroundColor = UIColor.lightGray
           outeltofbtn?.layer.borderColor =  UIColor.lightGray.cgColor
           UIView.animate(withDuration: 0.5) {
               outeltofbtn?.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
           }
       }
   }
    
}
extension CityDetailsViewController : CityDetailsDisplayLogic
{
    func displayInfo(city: City?) {
        
        print("😍Got the city 😍 \n \(String(describing: city))")
        self.city = city
        self.showHideLoadingView(setHidden: true)
        self.tableView.reloadData()
    }
    func showHideLoadingView(setHidden: Bool) {
        if setHidden
        {
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
        }
        else
        {
            indicatorView.isHidden = false
            indicatorView.startAnimating()
        }
        
    }
    
}
extension CityDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  HelperMethods.emptyTableView(tableView: tableView, dataCount: (city?.consolidatedWeather ??  []).count, dataCome: true, emptyTableViewMessage: "No weather states found!")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailsTableViewCell.identifier()) as! WeatherDetailsTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath.section == selectedSection ?  220 : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier:  WeatherHeaderSectionTableViewCell.identifier()) as! WeatherHeaderSectionTableViewCell
        cell.outletOfLbl.text = city.consolidatedWeather![section].weatherStateName ?? "---"
        cell.outeltOfBtn.addTarget(self, action: #selector(actionOfBtnExpanfCollaps(sender:)), for: .touchUpInside)
        cell.outletOfImgV.kf.setImage(with: URL(string: Environment.imgURLString.replacingOccurrences(of: "_abbr_", with: (city.consolidatedWeather?[section].weatherStateAbbr)!)))
        cell.outeltOfBtn.tag = section
        cell.outeltOfBtn.backgroundColor = selectedSection == section ? UIColor.lightGray : UIColor.white
        cell.backgroundColor = selectedSection == section ? UIColor.lightGray : UIColor.white
        cell.outeltOfBtn.layer.borderColor = selectedSection != section ? UIColor.lightGray.cgColor : UIColor.white.cgColor
        cell.outeltOfBtn.setImage(UIImage(named: selectedSection == section ? "ddlDown" : "ddlUp"), for: .normal)
        return  cell
     }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  60
    }
}

