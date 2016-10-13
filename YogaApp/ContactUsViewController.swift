//
//  ContactUsViewController.swift
//  YogaApp
//
//  Created by Rasheda Babatunde on 9/28/16.
//  Copyright © 2016 Rasheda Babatunde. All rights reserved.
//

import UIKit
import MessageUI
import MapKit


class ContactUsViewController: BaseViewController, MFMailComposeViewControllerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            addSlideMenuButtonToNav()
        
        let location = CLLocationCoordinate2D(latitude: 32.937128,longitude: -97.104311)
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Zen Central!"
        annotation.subtitle = "Get Yogi With Me"
        
        mapView.addAnnotation(annotation)
}
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        
    @IBAction func callPhoneNumber(_ sender: AnyObject) {
        
        if let url = URL(string: "tel://9292571341") {
            
            let alertController = UIAlertController(title: "Place Call",
                                                    message: "Do you wish to call (929) 257-1341 now?",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            let callAction = UIAlertAction(title: "Call", style: .default) { action in
                
                UIApplication.shared.openURL(url)
            }
            
            alertController.addAction(callAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            print("Failed to convert phone number to NSURL")
        }
    }
    /*@IBAction func createEmail(_ sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients(["support@procorefitness.net"])
            mailComposerVC.setSubject("My Subject...")
            mailComposerVC.setMessageBody("Here's my email! Blah Blah Blah.", isHTML: false)
            
            self.present(mailComposerVC, animated: true, completion: nil)
            
        } else {
            
            let alertController = UIAlertController(title: "Could Not Send Email",
                                                    message: "Your device is not configured to send e-mail. Please check e-mail configuration and try again.",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            let configureAction = UIAlertAction(title: "Configure", style: .default) { action in
                
                // Send the user to the device's Settings app.
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(appSettings)
                }
            }
            
            alertController.addAction(configureAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func gotoWebsite(_ sender: UIButton) {
            
            if let url = URL(string: "http://www.procorefitness.net/") {
                UIApplication.shared.openURL(url)
            }
    }

        // Implemented from MFMailComposeViewControllerDelegate...
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            controller.dismiss(animated: true, completion: nil)
        }*/
        
}
