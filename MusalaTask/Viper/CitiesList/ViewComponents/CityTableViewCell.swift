//
//  CountryTableViewCell.swift
//  MusalaTask
//
//  Created by Ahmed Hosny Sayed on 6/19/21.
//  Copyright © 2021 ispha. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    // MARK: - outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    
    // MARK: - variables
    var requestResponse: CityModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configure(_ data: CityModel) {
        requestResponse = data
        populateData()
    }
    
    fileprivate func populateData() {
        cityNameLabel.text = requestResponse.title
        // TBD: populating UIImage with svg flag image 
    }
    open class func identifier()-> String
    {
        return String(describing: CityTableViewCell.self)
    }
}
