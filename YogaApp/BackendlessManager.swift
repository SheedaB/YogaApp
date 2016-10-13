//
//  AppDelegate.swift
//  YogaApp
//
//  Created by Rasheda Babatunde on 9/28/16.
//  Copyright © 2016 Rasheda Babatunde. All rights reserved.
//

import Foundation

// The BackendlessManager class is a Singleton that wraps up all the 
// state and functionality related to Backendless.

class BackendlessManager {
    
    // This gives access to the one and only instance.
    static let sharedInstance = BackendlessManager()
    
    // This prevents others from using the default '()' initializer for this class.
    private init() {}
    
    
    let backendless = Backendless.sharedInstance()!
    
    let VERSION_NUM = "v1"
    
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Replace these with YOUR App's ID and Secret Key from YOUR Backendless Dashboard!
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    let APP_ID = "3B9B8036-E494-18F1-FFA1-AB9B585F7700"
    let SECRET_KEY = "366CA41D-C32C-19BB-FF39-A82CAA199200"
    

    
    func initApp() {
    
        // First, init Backendless!
        backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        backendless.userService.setStayLoggedIn(true)
    }
    
    func isUserLoggedIn() -> Bool {
        
        let isValidUser = backendless.userService.isValidUserToken()
        
        if isValidUser != nil && isValidUser != 0 {
            return true
        } else {
            return false
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping () -> (), error: @escaping (String) -> ()) {
    
        let user: BackendlessUser = BackendlessUser()
        user.email = email as NSString!
        user.password = password as NSString!
        
        backendless.userService.registering( user,
                                              
            response: { (user: BackendlessUser?) -> Void in
            
                print("User was registered: \(user?.objectId)")
                completion()
            },
          
            error: { (fault: Fault?) -> Void in
                print("User failed to register: \(fault)")
                error((fault?.message)!)
            }
        )
    }
    
    func loginUser(email: String, password: String, completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        backendless.userService.login( email, password: password,
                                        
            response: { (user: BackendlessUser?) -> Void in
                print("User logged in: \(user!.objectId)")
                completion()
            },
            
            error: { (fault: Fault?) -> Void in
                print("User failed to login: \(fault)")
                error((fault?.message)!)
            })
    }
    
    func logoutUser(completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        // First, check if the user is actually logged in.
        if isUserLoggedIn() {
            
            // If they are currently logged in - go ahead and log them out!
            
            backendless.userService.logout( { (user: Any!) -> Void in
                    print("User logged out!")
                    completion()
                },
                                            
                error: { (fault: Fault?) -> Void in
                    print("User failed to log out: \(fault)")
                    error((fault?.message)!)
                })
            
        } else {
            
            print("User is already logged out!");
            completion()
        }
    }
    
    
    
    
    func saveTestData() {
        
        let testClass = Class()
        
        testClass.name = "Fit Lane Small Group Training"
        testClass.classDescription = "Descrption goes here!"
        testClass.instructorName = "Jennifer"
        testClass.instructorPhotoUrl = "URL here"
        testClass.classDate = Date()
        
        backendless.data.save( testClass,
                               
           response: { (entity: Any?) -> Void in
            
            let theClass = entity as! Class
            
            print("Class: \(theClass.objectId!), name: \(theClass.name), photoUrl: \"\(theClass.instructorPhotoUrl!)\", rating: \"\(theClass.classDescription)\"")
            },
                               
           error: { (fault: Fault?) -> Void in
            print("Class failed to save: \(fault)")
            }
        )
    }
    
//    func loadTestData() {
//        
//        let dataStore = backendless.persistenceService.of(Class.ofClass())
//        
//        dataStore?.find(
//            
//            { (meals: BackendlessCollection?) -> Void in
//                
//                print("Find attempt on all Meals has completed without error!")
//                print("Number of Meals found = \((Class?.classDescription)!)")
//                
//                for testClass in (Class?.classDescription)! {
//                    
//                    let Class = theClass as! Class
//                    
//                    print("Class: \(theClass.objectId!), name: \(theClass.name), photoUrl: \"\(theClass.instructorPhotoUrl!)\", rating: \"\(theClass.classDescription)\"")
//
//                }
//            },
//            
//            error: { (fault: Fault?) -> Void in
//                print("Meals were not fetched: \(fault)")
//            }
//        )
//    }
 
    
    
}
