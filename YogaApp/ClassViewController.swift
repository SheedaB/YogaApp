//
//  ClassViewController.swift
//  YogaApp
//
//  Created by Rasheda Babatunde on 9/28/16.
//  Copyright © 2016 Rasheda Babatunde. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var classLabel: UILabel!
    
    //var textData:String = ""
    
    var selectedClass: Class?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Once the view loads, use the String value stored in textData to
        // to set the view's label text as proof that we actually got the
        // data passed to us from the other view controller.
        //textLabel.text = textData
        
        classLabel.text = selectedClass?.name
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
