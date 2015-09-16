//
//  ViewController.swift
//  testCoreData
//
//  Created by アンディット ヘリスティヨ on 2015/09/16.
//  Copyright (c) 2015年 Digital Garage. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var logs = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let x : Double = 1.0
        let y : Double = 2.0
        let z : Double = 3.0
        
        saveData(x, y: y, z: z)
        saveData(x, y: y, z: z)
        
        fetchData()
        println(logs.count)
        println(logs.last)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func saveData(x:Double, y:Double, z:Double) {
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("Log", inManagedObjectContext: managedContext)
        let log = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        //3
        log.setValue(x, forKey: "x")
        log.setValue(y, forKey: "y")
        log.setValue(z, forKey: "z")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }  
        //5
        logs.append(log)
    }
    
    func fetchData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName: "Log")
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        if let results = fetchedResults {
            logs = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
}

