//
//  GroupsTableViewController.swift
//  VKApp
//
//  Created by Сергей Зесли on 20.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    var allGroups = [ItemGroups]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 74
        tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getGroups()
    }
    
    func getGroups() {
            var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems = [
               URLQueryItem(name: "v", value: "5.103"),
               URLQueryItem(name: "access_token", value: Session.instance.token),
               URLQueryItem(name: "fields", value: "city,country,place,description"),
               URLQueryItem(name: "extended", value: "1")
            ]
            
            URLSession.shared.dataTask(with: urlConstructor.url!) { (data, response, error) in
                guard let data = data else {
                    return
                }
                
              
                guard let groups = try? JSONDecoder().decode(RootGroups.self, from: data) else  {
                    return
                }
                
                guard let ig = groups.response?.items else {
                    return
                }
                
                
                DispatchQueue.main.async {
                    self.allGroups = ig
                    self.tableView.reloadData()
                    
                    do {
                       let realm = try Realm()
                   
                       try realm.write {
                           realm.delete(realm.objects(RealmGroup.self))
                           for item in ig {
                                let rg = RealmGroup()
                                rg.id = item.id ?? 0
                                rg.name = item.name
                                rg.descriptionField = item.descriptionField
                                rg.screenName = item.screenName
                                rg.photo100 = item.photo100
                                rg.photo200 = item.photo200
                                rg.photo50 = item.photo50

                            
                                realm.add(rg)
                               
                           }
                       }
                       print("Группы сохранены в Realm")
                                                                 
                    } catch {
                        print(error)
                    }
                    
                }
                
                
                
            }.resume()
            
        }

     
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allGroups.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupTableCell", for: indexPath) as! GroupTableViewCell

        cell.groupLabel.text = allGroups[indexPath.row].name
        cell.groupImage.image = #imageLiteral(resourceName: "groups")

        return cell
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        let vc = unwindSegue.source as! AllGroupsTableViewController
        
//        if let ip = vc.tableView.indexPathForSelectedRow {
//            let group = vc.groups[ip.row]
//
//            VkDataBase.shared().myGroups.append(group)
//            tableView.reloadData()
//        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            VkDataBase.shared().myGroups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "allGroupsSegue" {
//            let vc = segue.destination as! AllGroupsTableViewController
//            vc.groups = [Group]()
//
//            outerloop: for group in VkDataBase.shared().allGroups {
//                for gp in VkDataBase.shared().myGroups {
//                    if gp.id == group.id {
//                        continue outerloop
//                    }
//                }
//                vc.groups.append(group)
//            }
//        }
        
    }
    

}
