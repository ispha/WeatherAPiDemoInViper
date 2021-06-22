//
//  CitiesListPresenter.swift
//  MusalaTask
//
//  Created by Ahmed Hosny Sayed on 6/19/21.
//  Copyright © 2021 ispha. All rights reserved.

import UIKit

protocol CitiesListPresentationLogic {
    func passCities(cities: [CityModel])
}

class CitiesListPresenter: CitiesListPresentationLogic {
    
    weak var viewController: CitiesListDisplayLogic?
    
    func passCities(cities: [CityModel]) {
        viewController?.displayCities(cities:cities)
    }
}
