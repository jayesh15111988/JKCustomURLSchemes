//
//  AppDelegate.swift
//  JKCustomURLSchemes
//
//  Created by Jayesh Kawli Backup on 5/2/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    // MARK: Method for demonstrating use of custom URL schemes.
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let urlComponents = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        if let items = urlComponents?.queryItems {
            //jkcustomurlschemes://?backgroundColor=red&title=Custom URLs
            if (url.scheme == "jkcustomurlschemes") {
                var color: UIColor? = UIColor.blackColor()
                var vcTitle = "Unknown"
                
                if let _ = items.first, propertyValue = items.first?.value {
                    if (propertyValue == "red") {
                        color = UIColor.redColor()
                    } else if (propertyValue == "green") {
                        color = UIColor.greenColor()
                    }
                }
                
                if items.count > 1 {
                    let nextItem = items[1]
                    if let value = nextItem.value {
                        vcTitle = value
                    }
                }
                
                if (color != nil) {
                    self.dismiss()
                    self.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                    let vc = UIViewController()
                    vc.view.backgroundColor = color
                    vc.title = vcTitle
                    let navController = UINavigationController(rootViewController: vc)
                    let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(dismiss))
                    vc.navigationItem.leftBarButtonItem = barButtonItem
                    self.window?.rootViewController?.presentViewController(navController, animated: true, completion: nil)
                    return true
                }
            }
        } else {
            // URL entered through Safari for example is : jkcustomurlschemes://[Any arbitrary host]
            print("URL Scheme is \(url.scheme)")
            if let host = url.host {
                print("URL Host is \(host)")
                let alertController = UIAlertController(title: "Custom URL Schemes", message: "Scheme is \(url.scheme) and \(host)", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                    
                }
                alertController.addAction(OKAction)
                
                self.window?.rootViewController?.presentViewController(alertController, animated: true) {
                
                }
            }
        }
        
        return false
    }
    
    func dismiss() {
        self.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

