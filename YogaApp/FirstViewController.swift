//
//  FirstViewController.swift
//  YogaApp
//
//  Created by Rasheda Babatunde on 9/28/16.
//  Copyright © 2016 Rasheda Babatunde. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let backendless = Backendless.sharedInstance()!
    
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0 ? true: false
    }

//    let myData =  [
//        
//        "Fit Lane Small Group Training",
//        "Fit Lane/Wall Combo Small Group",
//        ]
    
    var myData = [Class]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSlideMenuButtonToNav()
        
        
        
//BackendlessManager.sharedInstance.saveTestData()
        
        
        let testClass1 = Class()
            
        testClass1.name = "Yoga in the Park"
        testClass1.classDescription = "Join us in the beautiful park at Lakeside for a Free, all levels outdoor yoga class with our talented Yoga Teachers from Urban Vybe (weather permitting). Donations are optional & will be accepted to support a local charity."
        testClass1.instructorName = "Jennifer"
        
        myData.append(testClass1)
        
        let testClass2 = Class()
        
        testClass2.name = "Deep Release - Yin Yoga"
        testClass2.classDescription = "our toes will soon be within your grasp…trust us…this stuff works! Release tension from deep within your muscles and connective tissues, and increase flexibility and joint mobility with this long holding Yin Yoga practice. Obtain a quiet stillness and learn how to stretch your mind and your body with conscious breathing, self-awareness, and meditation"
        testClass2.instructorName = "John"
        
        myData.append(testClass2)
        
        
    }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // From UITableViewDataSource protocol.
        func numberOfSections(in tableView: UITableView) -> Int {
            
            // We only have one section in our table view.
            return 1
        }
        
        // From UITableViewDataSource protocol.
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            // The number of rows we want for out table view is directly related to
            // the number of data entries we have in our data array.
            return myData.count
            
        }
        
        // From UITableViewDataSource protocol.
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // This will try to reuse a cell if one can be found. If not, a new cell will be created.
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as UITableViewCell
            
            // Find out what index or row we're building for and use that to fetch the corresponding data.
            let row = (indexPath as NSIndexPath).row
            
            cell.textLabel?.text = myData[row].name
            
            // Finally, return the cell so it can be placed into the table view.
            return cell
        }
    // From UITableViewDelegate protocol.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("User selected section: \((indexPath as NSIndexPath).section), row: \((indexPath as NSIndexPath).row)")
        
        // The user has tapped or selected a row in our table view - manually fire our
        // named Segue.
        performSegue(withIdentifier: "mySegue", sender: tableView)
    }
    // We can override this method in UIViewController if we want to perform some
    // logic before a Segue actually fires off.
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "mySegue" {
            
            print("Preparing for mySegue!")
            
            // Ask the table view what row is currenlty selected.
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            
            print("User selected section: \((indexPath as NSIndexPath).section), row: \((indexPath as NSIndexPath).row)")
            
            let classVC = segue.destination as! ClassViewController
            
            // Pass some data to the next View Controller by setting one or more of
            // its properties.
            //classVC.textData = myData[(indexPath as NSIndexPath).row].name!
            
            classVC.selectedClass = myData[(indexPath as NSIndexPath).row]
        }
    }
    
//        @IBAction func logoutBtn(_ sender: UIButton) {
//        
//        print( "logoutBtn called!" )
//        
//        BackendlessManager.sharedInstance.logoutUser(
//            
//            completion: {
//                self.performSegue(withIdentifier: "gotoLoginFromMenu", sender: sender)
//            },
//            
//            error: { message in
//                print("User failed to log out: \(message)")
//        })
//    }
}
