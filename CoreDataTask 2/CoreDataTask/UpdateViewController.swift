//
//  UpdateViewController.swift
//  CoreDataTask
//
//  Created by Leena on 3/28/18.
//  Copyright © 2018 Leena. All rights reserved.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    var user: [NSManagedObject] = []
    var ID: Int = 0
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       ID = user[0].value(forKey: "userid") as! Int
        //print(ID)
        txtUserName.text = user[0].value(forKey: "username") as? String
         txtEmail.text = user[0].value(forKey: "email") as? String
         txtMobile.text = user[0].value(forKey: "mobile") as? String
        // Do any additional setup after loading the view.
    }
    func UpdateRecord() {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        let predicate = NSPredicate(format: "username == '\(user[0].value(forKey: "username") as! String)'")
      //  ID = user[0].value(forKey: "userid") as! Int
        fetchRequest.predicate = predicate
        do{
            let data = try context.fetch(fetchRequest)
            print(data.count)
            if data.count == 1
            {
                 print("Enter")
                let objUpdate = data[0] as! NSManagedObject
                print(data[0])
               // objUpdate.setValue(user[0].value(forKey: "userid") as! Int, forKeyPath: "userid")
              //  objUpdate.setValue(txtUserName, forKey: "username")
                objUpdate.setValue(txtEmail.text, forKey: "email")
                objUpdate.setValue(txtMobile.text, forKey: "mobile")
                do{
                   print("saveD")
                    try context.save()
                    showAlert(withTitleMessageAndAction: "Success", message: "Record Updated Successfully", action: true)
                }catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                    }
            }
        }catch {
            print(error)
        }
    }

 
    func showAlert(withTitleMessageAndAction title:String, message:String , action: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        if action {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action : UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
        } else{
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
   
    @IBAction func btnUpdate(_ sender: Any) {
        UpdateRecord()
    }
    func fetchRecord()
    {
        
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        do{
            user = try context.fetch(fetchRequest) as! [NSManagedObject]
        }catch{
            print("error")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchRecord()
    }
}
