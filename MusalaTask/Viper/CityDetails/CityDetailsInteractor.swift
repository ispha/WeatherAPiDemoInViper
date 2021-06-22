//
//  CityDetailsInteractor.swift
//  MusalaTask
//
//  Created by ispha on 20/06/2021.
//  Copyright © 2021 ispha. All rights reserved.
//

import Alamofire

protocol CityDetailsBusinessLogic {
    func fetchCityDetails(cityWOEID:String)
}

class CityDetailsInteractor: CityDetailsBusinessLogic {
    var presenter: CityDetailsPresentationLogic?
    var countriesFetcher: CitiesFetcherType?
    
    func fetchCityDetails(cityWOEID:String) {
        countriesFetcher?.fetchCity(cityWOEID: cityWOEID, completion: { [weak self] city in
                self?.presenter?.passCity(city: city)
        })
    }
}
