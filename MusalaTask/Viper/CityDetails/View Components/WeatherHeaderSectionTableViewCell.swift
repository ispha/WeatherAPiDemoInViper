//
//  MenuSectionTableViewCell.swift
//  MusalaTask
//
//  Created by Ahmed Hosny Sayed on 6/19/21.
//  Copyright © 2021 ispha. All rights reserved.
//

import UIKit

class WeatherHeaderSectionTableViewCell: UITableViewHeaderFooterView {
    
    // MAR: - outlets
    @IBOutlet weak var outeltOfBtn: DesignableButton!
    @IBOutlet weak var outletOfLbl: UILabel!
    @IBOutlet weak var outletOfImgV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    open class func identifier() -> String {
        return String(describing:   WeatherHeaderSectionTableViewCell.self)
    }
    
    
}
