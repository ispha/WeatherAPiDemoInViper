//
//  CitiesFetcher.swift
//  MusalaTask
//
//  Created by Ahmed Hosny Sayed on 6/19/21.
//  Copyright © 2021 ispha. All rights reserved.
//

import Foundation
import Alamofire

protocol CitiesFetcherType {
    func fetchCity(cityWOEID : String ,completion: @escaping (City?) -> Void)
}

class CitiesFetcher: CitiesFetcherType {
    
    func fetchCity(cityWOEID: String, completion: @escaping (City?) -> Void) {
        AF.request( Environment.rootURLString + cityWOEID).responseData(completionHandler:{ [weak self] (response) in
            switch response.result{
            case .failure(let error):
                print("Failure case: \(error)")
                completion(nil)
            case .success(let value):
                
                
                do {
                    let json = try? JSONSerialization.jsonObject(with: value) as? [String: Any]
                    print("response data second token api› =\(String(describing: json))")
                    if response.response?.statusCode == 200
                    {
                        let decodedModel = try JSONDecoder().decode(CityModel.self, from: value)
                        completion(self!.mapCitiy(decodedModel))
                    }
                    else
                    {
                        print("status code \(String(describing: response.response?.statusCode)) not 200 case")
                        completion(nil)
                    }
                    
                }catch let error {
                    print("Error happend: \(error)")
                }
                
            }
        })
        
    }
    private func mapCitiy(_ city: CityModel) -> City {
        let result = City(consolidatedWeather: city.consolidatedWeather, title: city.title)
        return result
    }
}
