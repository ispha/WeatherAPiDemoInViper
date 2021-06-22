//
//  WeatherDetailsTableViewCell.swift
//  MusalaTask
//
//  Created by ispha on 21/06/2021.
//  Copyright © 2021 ispha. All rights reserved.
//

import UIKit

class WeatherDetailsTableViewCell: UITableViewCell {

    // MARK: - outlets
    @IBOutlet weak var minTempVal: UILabel!
    @IBOutlet weak var maxTempVal: UILabel!
    @IBOutlet weak var theTempVal: UILabel!
    
    @IBOutlet weak var windSpeedVal: UILabel!
    @IBOutlet weak var windDirectionVal: UILabel!
    @IBOutlet weak var airPresureVal: UILabel!
    
    @IBOutlet weak var humidilityVal: UILabel!
    @IBOutlet weak var visibilityVal: UILabel!
    @IBOutlet weak var predictablityVal: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    open class func identifier()-> String
    {
        return String(describing: WeatherDetailsTableViewCell.self)
    }
}
