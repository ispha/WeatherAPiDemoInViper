//
//  CityDetailsrouter.swift
//  MusalaTask
//
//  Created by ispha on 20/06/2021.
//  Copyright © 2021 ispha. All rights reserved.
//

import UIKit
protocol CityDetailsRoutingLogic {
    func navigateToScreen()
}

class CityDetailsRouter: NSObject, CityDetailsRoutingLogic {
    weak var viewController: CityDetailsViewController?
    func navigateToScreen() {
        /*  viewController?.performSegue(withIdentifier: Constants.showCountryDetailsSegueIdentifier.rawValue, sender: nil)
         */
    }
}
