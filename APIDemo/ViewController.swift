//
//  ViewController.swift
//  APIDemo
//
//  Created by Parrot on 2019-03-03.
//  Copyright © 2019 Parrot. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WatchConnectivity


class ViewController: UIViewController, WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {

    }

    func sessionDidDeactivate(_ session: WCSession) {

    }


    var datalist:[String : Any]?
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var errorchecking: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let URL = "https://httpbin.org/get"
        let URL = "https://randomuser.me/api/"
        
        Alamofire.request(URL).responseJSON {
            
            response in
            
            // TODO: Put your code in here
            // ------------------------------------------
            // 1. Convert the API response to a JSON object
            
            // -- check for errors
            let apiData = response.result.value
            if (apiData == nil) {
                self.print("Error when getting API data")
                return
            }
            // -- if no errors, then keep going
            
            self.print(apiData)
            
            
            // 2. Parse out the data you need (sunrise / sunset time)
            
            // example2 - parse an array of dictionaries
            
            // 2a. Convert the response to a JSON object
            let jsonResponse = JSON(apiData)
            
            self.print(jsonResponse)
            
            self.datalist = [
                "firstname":  jsonResponse["results"][0]["name"]["first"].stringValue,
                "lastname":  jsonResponse["results"][0]["name"]["last"].stringValue
            ]
            
//            // 2b. Get the array out of the JSON object
//            var responseArray = jsonResponse.arrayValue
//
//            // 2c. Get the 3rd item in the array
//            // item #3 = position 2
//            var item = responseArray[2];
//            self.print(item)
//
//            // Output the "title" of the item in position #2
//            self.outputLabel.text = item["title"].stringValue
//
////            // 2b. Get a key from the JSON object
////            let origin = jsonResponse["origin"]
////            let host = jsonResponse["headers"]["Host"]
////
////            // 2c. Output the value to screen
////            print("Your IP Address: \(origin)")
////            print("Host: \(host)")
////
////            // 3. Show the data in the user interface
////            self.outputLabel.text = "IP Address: \(origin)"
        }
    
        
        if (WCSession.isSupported()) {
            errorchecking.text = ("Yes it is!")
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else{
            errorchecking.text = ("Phone can not connect to the watch")
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //button on main phone screen
    @IBAction func print(_ sender: Any) {
        
        //if session is suppported then sendthe data to phone
        if (WCSession.default.isReachable) {
            // construct the message you want to send
            // the message is in dictionary
//            let message =
//                ["message": "Hello",
//                 "email": "jj@gmail.com"
//            ]
            errorchecking.text = "mesage sent"
            // send the message to the watch
            WCSession.default.sendMessage(datalist!, replyHandler: nil)
        }
        else{
            errorchecking.text = "cannnot send the data to watch"
        }
        
        //some pictures on phone

    }
    
   


}

