//
//  Page1InterfaceController.swift
//  APIDemo WatchKit Extension
//
//  Created by MacStudent on 2019-06-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire
import SwiftyJSON

class PAGE1InterfaceController: WKInterfaceController {
    
    //outlet for page1 table
    @IBOutlet var tableView: WKInterfaceTable!
    
    
    // MARK: Data Source
    
    var personList = ["jagtar", "jsk@hmilcom","66.8","556.8","45343","youy","12234"]
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        // 1. Tell watch how many rows you want
        // blue = name of table outlet
        // pink = name of your data source
        // yellow = id for your row
        self.tableView.setNumberOfRows(
            self.personList.count, withRowType:"myrow"
        )
        
        // 1. Tell watch what data goes in each row
        // blue = outlet for your label
        // pink = name of your data source
        // yellow = name of custom row controller
        for (index, country) in self.personList.enumerated() {
            let row = self.tableView.rowController(at: index) as! RowController
            row.outputLabel.setText(country)
        }
        
    }
    
}
