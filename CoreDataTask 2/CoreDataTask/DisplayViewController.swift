//
//  DisplayViewController.swift
//  CoreDataTask
//
//  Created by Leena on 3/28/18.
//  Copyright © 2018 Leena. All rights reserved.
//

import UIKit
import CoreData

class DisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var RegList : [NSManagedObject] = []
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func fetchRecord()
    {
        
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        do{
            RegList = try context.fetch(fetchRequest) as! [NSManagedObject]
        }catch{
            print("error")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     fetchRecord()
        
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RegList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        let regis = RegList[indexPath.row]
        cell.lblUserName.text = regis.value(forKeyPath: "username") as? String
        cell.lblEmail.text = regis.value(forKeyPath: "email") as? String
        cell.lblMobile.text = regis.value(forKeyPath: "mobile") as? String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath, animated: true)
        let editUser: [NSManagedObject] = [RegList[indexPath.row] as NSManagedObject]
        let updateVC : UpdateViewController = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        updateVC.user = editUser
        
        self.navigationController?.pushViewController(updateVC, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let context = getContext()
            context.delete(RegList[indexPath.row] as NSManagedObject)
            do {
                 try context.save()
                fetchRecord()
                 tableView.reloadData()
            } catch {
                print(error)
            }
        }

    }
}
