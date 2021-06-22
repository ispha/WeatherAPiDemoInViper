//
//  CitiesListInteractor.swift
//  MusalaTask
//
//  Created by Ahmed Hosny Sayed on 6/19/21.
//  Copyright © 2021 ispha. All rights reserved.

import Alamofire

protocol CitiesListBusinessLogic {
    func fetchCities()
}

class CitiesListInteractor: CitiesListBusinessLogic {
    var presenter: CitiesListPresentationLogic?
    var countriesFetcher: CitiesFetcherType?
    
    func fetchCities() {
        if Storage.fileExists(Constants.CitiesOffline.rawValue, in: .documents){
            let citiesArr : [CityModel] = Storage.retrieve(Constants.CitiesOffline.rawValue , from: .documents, as: [CityModel].self)
            self.presenter?.passCities(cities:citiesArr)
        }
    }
}
