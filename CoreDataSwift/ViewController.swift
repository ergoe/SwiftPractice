//
//  ViewController.swift
//  CoreDataSwift
//
//  Created by Eric Goeckritz on 8/15/14.
//  Copyright (c) 2014 Eric Goeckritz. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSave(sender: AnyObject) {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate);
        var context:NSManagedObjectContext = appDel.managedObjectContext!;
        
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject;
        
        newUser.setValue(txtUsername.text, forKey: "username");
        newUser.setValue(txtPassword.text, forKey: "password");
        context.save(nil)
        
        println(newUser);
        println("Object Saved");
        
    }
    
    @IBAction func btnLoad(sender: AnyObject) {
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate);
        var context:NSManagedObjectContext = appDel.managedObjectContext!;
        
        var request = NSFetchRequest(entityName: "Users");
        request.returnsObjectsAsFaults = false;
        
        //adding predicate
        request.predicate = NSPredicate(format: "username = %@", txtUsername.text);
        
        var results:NSArray = context.executeFetchRequest(request, error: nil);
        
        if (results.count > 0) {
            for res in results {
                txtUsername.text = res.valueForKey("username") as String
                txtPassword.text = res.valueForKey("password") as String
            }
        } else {
            println("0 Results Returned... Potential Error")
        }
    }
    
   
    


}

