//
//  CitiesListRouter.swift
//  MusalaTask
//
//  Created by Ahmed Hosny Sayed on 6/19/21.
//  Copyright © 2021 ispha. All rights reserved.

import UIKit

protocol CitiesListRoutingLogic {
    func navigateToCityDetailsScreen()
}

class CitiesListRouter: NSObject, CitiesListRoutingLogic {
    
    weak var viewController: CitiesListViewController?
    
    func navigateToCityDetailsScreen() {
        viewController?.performSegue(withIdentifier: Constants.showCountryDetailsSegueIdentifier.rawValue, sender: nil)
    }
}
