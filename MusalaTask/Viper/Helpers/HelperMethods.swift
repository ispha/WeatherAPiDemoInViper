//
//  HelperMethods.swift
//  MusalaTask
//
//  Created by ispha on 22/06/2021.
//  Copyright © 2021 ispha. All rights reserved.
//

import UIKit
class HelperMethods
{
class func emptyTableView(tableView: UITableView, dataCount: Int, dataCome: Bool, emptyTableViewMessage: String) -> Int {
    if dataCome {
        if dataCount > 0 {
            tableView.backgroundView = nil
        } else {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: tableView.tableHeaderView != nil ? tableView.tableHeaderView?.frame.size.height ?? 0.0 + 100 :  (tableView.frame.size.height / 2 ) - 60 , width: tableView.bounds.size.width, height: 60))
            noDataLabel.text = emptyTableViewMessage
            noDataLabel.textColor = UIColor.darkGray
            noDataLabel.textAlignment = .center
            let view = UIView(frame: tableView.frame)
            view.addSubview(noDataLabel)
            tableView.backgroundView  = view
        }
        return dataCount
    }
    return 0
}
}
