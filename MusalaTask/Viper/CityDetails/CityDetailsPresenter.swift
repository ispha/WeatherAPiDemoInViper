//
//  CityDetailsPresenter.swift
//  MusalaTask
//
//  Created by ispha on 20/06/2021.
//  Copyright © 2021 ispha. All rights reserved.
//

import Foundation
protocol CityDetailsPresentationLogic {
    func passCity(city: City?)
}

class CityDetailsPresenter: CityDetailsPresentationLogic {
    
    weak var viewController: CityDetailsDisplayLogic?
    
    func passCity(city: City?) {
        viewController?.displayInfo(city: city)
    }
}
