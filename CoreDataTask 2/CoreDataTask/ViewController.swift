//
//  ViewController.swift
//  CoreDataTask
//
//  Created by Leena on 3/28/18.
//  Copyright © 2018 Leena. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UINavigationControllerDelegate {
  
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPwd: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    var countID : Int = 0
    var RegUser: [NSManagedObject] = []
    
    @IBAction func btnLogin(_ sender: Any) {

//        let loginvc:UIViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
//      self.navigationController?.pushViewController(loginvc, animated: true)
          performSegue(withIdentifier: "LoginSegue", sender: self)
   
    }
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return  appDelegate.persistentContainer.viewContext
    }
    func SaveRecord() {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Register", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        countID = countID + 1
        newUser.setValue(txtUserName.text, forKey: "username")
        newUser.setValue(txtPassword.text, forKey: "password")
        newUser.setValue(txtEmail.text, forKey: "email")
        newUser.setValue(txtMobile.text, forKey: "mobile")
        newUser.setValue(countID, forKey: "userid")
        print(countID)
        do{
            try context.save()
           // RegUser.append(newUser)
         //    showAlert(withTitleMessageAndAction: "Suceessful!", message: "Registration Sucessfully Done!." ,action: true)
             performSegue(withIdentifier: "LoginSegue", sender: self)
//            print("hello")
        }catch {
            print("Error : Failed")
        }
        
    }
    
    @IBAction func btmSubmit(_ sender: Any) {
        // Checking Registration form is filled completely
//        let alertController = UIAlertController(title: "Enter Details", message: "Please Enter User Name", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default)
//       alertController.addAction(okAction)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
        if (txtUserName.text == "") {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter valid User Name." ,action: false)
        }
        if (txtPassword.text == "") {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter valid Password.", action: false)
        }
        if (txtConfirmPwd.text == "") {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter valid ConfirmPassword.", action: false)
        }
        if (txtPassword.text != txtConfirmPwd.text) {
            showAlert(withTitleMessageAndAction: "Alert!", message: "ConfirmPassword does not match.", action: false)
        }
        if (txtEmail.text == "" ) {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter Email iD.", action: false)
        }
        if !check(forValidEmail: txtEmail) {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter valid Email id.", action: false)
        }
        if (txtMobile.text == "") {
            showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter Mobile No.", action: false)
        }
        SaveRecord()
//       performSegue(withIdentifier: "LoginSegue", sender: self)
      
//        let loginvc: LoginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.navigationController?.pushViewController(loginvc, animated: true)
    }
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    let destvc = segue.destination as! LoginViewController
//    }
    func check(forValidEmail textfield: UITextField) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        print(emailTest.evaluate(with: textfield.text!))
        return emailTest.evaluate(with: textfield.text!)
    }
    @IBAction func btnCancel(_ sender: Any) {
        txtUserName.text = nil
        txtPassword.text = nil
        txtConfirmPwd.text = nil
        txtEmail.text = nil
        txtMobile.text = nil
    }
    func showAlert(withTitleMessageAndAction title:String, message:String , action: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        if action {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action : UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
        } else{
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
           
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnDisplay(_ sender: Any) {
          performSegue(withIdentifier: "ShowSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

