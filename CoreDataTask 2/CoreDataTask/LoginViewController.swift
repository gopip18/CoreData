//
//  LoginViewController.swift
//  CoreDataTask
//
//  Created by Leena on 3/28/18.
//  Copyright © 2018 Leena. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UINavigationControllerDelegate {
//    var abcd = [String]()
//    var str = String()
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
     var RegList = NSArray()
    var ctrVariable : Int = 0
    
    func getContext() -> NSManagedObjectContext
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    // MARK: – Database operation Methods
    func GetDataFromDB()
    {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        let predicate = NSPredicate(format: "username =%@", txtUserName.text!, "password =%@", txtPassword.text!)
        fetchRequest.predicate = predicate
        do {
            RegList = try context.fetch(fetchRequest) as NSArray
           // print(RegList.count)
            if RegList.count > 0 {
              //  print(RegList.count)
                let objectentity = RegList.firstObject as! Register
                if ((txtUserName.text == objectentity.username) && (txtPassword?.text == objectentity.password))
                   
                    {
//                        print(objectentity.username as Any)
//                        print(objectentity.password as Any)
                  //      showAlert(withTitleMessageAndAction: "Alert", message: "Login Succesfully!!", action: true)
                     //   print("Before Logged IN")
//                        print("befor")
                          performSegue(withIdentifier: "DisplaySegue", sender: self)
//                        print("after")

//                        let newVC : DisplayViewController = self.storyboard?.instantiateViewController(withIdentifier: "DisplayViewController") as! DisplayViewController
//                        self.present(newVC, animated: true, completion: nil)
//                        print("Logged IN")
                    }
                    else
                    {
                        print(objectentity.username as Any)
                        print(objectentity.password as Any)
                        print("does not Match!!")
                        showAlert(withTitleMessageAndAction: "Alert", message: "UserName and Password does not match!!", action: false)
                    }
                }

            }catch let error as NSError{
                print("Could not Fetch, \(error)")
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

    @IBAction func btnLogin(_ sender: Any) {
        if (txtUserName.text == ""){
            showAlert(withTitleMessageAndAction: "Alert", message: "Please Enter UserName", action: false)
        }
        if (txtPassword.text == ""){
            showAlert(withTitleMessageAndAction: "Alert", message: "Please Enter Password", action: false)
        }
        GetDataFromDB()
    }
    
    @IBAction func btCancel(_ sender: Any) {
        txtUserName.text = ""
        txtPassword.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
       // GetDataFromDB()
        // Do any additional setup after loading the view.
    }
    
}
