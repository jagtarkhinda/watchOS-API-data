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
import WatchConnectivity

class PAGE1InterfaceController: WKInterfaceController,  WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // Play a "click" sound when you get the message
        WKInterfaceDevice().play(.click)
        
        // output a debug message to the terminal
        print("Got a message!")
        
        // update the message with a label
        self.personList = [
            message["firstname"] as! String,
            message["lastname"] as! String
        ]
        
       
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
    
    //outlet for page1 table
    @IBOutlet var tableView: WKInterfaceTable!
    
    
    // MARK: Data Source
    
    var personList = ["jagtar", "jsk@hmilcom","66.8","556.8","45343","youy","12234"]
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
            print("watch session")
        }
        
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
