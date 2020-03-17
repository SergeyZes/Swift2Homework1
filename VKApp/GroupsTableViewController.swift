//
//  GroupsTableViewController.swift
//  VKApp
//
//  Created by Сергей Зесли on 20.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class GroupsTableViewController: UITableViewController {
    var allGroups: Results<RealmGroup>?
    var token: NotificationToken?
    
    private var groups = [GroupFire]()
    private let ref = Database.database().reference(withPath: "groups")
    var userId: Int = 0;
    


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 74
        tableView.tableFooterView = UIView()
                
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userId = appDelegate.userId
        
        ref.observe(.value) { snapshot in
            var groups = [GroupFire]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let group = GroupFire(snapshot: snapshot) {
                    if group.userId == self.userId {
                        groups.append(group)
                    }
                }
            }
            self.groups = groups
            self.tableView.reloadData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getGroups()
    }
    
    func readGroupssFromDB() {
        guard let realm = try? Realm() else {
            return
        }
        
        allGroups = realm.objects(RealmGroup.self).sorted(byKeyPath: "name")
        
        token = allGroups?.observe({[weak self] changes in
            guard let tableView = self?.tableView else {return}
              
            switch changes {
                
            case .initial(_):
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.deleteRows(at: deletions.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.insertRows(at: insertions.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.reloadRows(at: modifications.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                tableView.endUpdates()
            case .error(_):
                break
            @unknown default:
                break
            }
        })

        
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
                    for item in ig {
                        let name = item.name ?? "anonimous"
                        let group = GroupFire(userId: self.userId, name: name)
                        let groupRef = self.ref.child("\(self.userId)_\(name)")
                        groupRef.setValue(group.toAnyObject())
                    
                    }
                    print("Группы сохранены в Firebase")

                    
//                    do {
//                       let realm = try Realm()
//
//                       try realm.write {
//                           realm.delete(realm.objects(RealmGroup.self))
//                           for item in ig {
//                                let rg = RealmGroup()
//                                rg.id = item.id ?? 0
//                                rg.name = item.name
//                                rg.descriptionField = item.descriptionField
//                                rg.screenName = item.screenName
//                                rg.photo100 = item.photo100
//                                rg.photo200 = item.photo200
//                                rg.photo50 = item.photo50
//
//
//                                realm.add(rg)
//
//                           }
//                       }
//                       print("Группы сохранены в Realm")
//                       self.readGroupssFromDB()
//
//                    } catch {
//                        print(error)
//                    }

                }
                
                
                
            }.resume()
            
        }

     
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return allGroups?.count ?? 0
        return groups.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupTableCell", for: indexPath) as! GroupTableViewCell
        
        let group = groups[indexPath.row]

        cell.groupLabel.text = group.name
        //cell.groupLabel.text = allGroups?[indexPath.row].name ?? "anonymous"
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
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    
    @IBAction func addGroup(_ sender: UIBarButtonItem) {
            let alertController = UIAlertController(title: "Введите группу", message: nil, preferredStyle: .alert)
            alertController.addTextField { (field) in
                
            }
            let confirmAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] action in
                guard let name = alertController.textFields?[0].text else {return}
                self?.addGroup(name: name)
            }
            alertController.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true)
        }
        
func addGroup(name: String){
    let group = GroupFire(userId: self.userId, name: name)
    let groupRef = self.ref.child("\(self.userId)_\(name)")
    groupRef.setValue(group.toAnyObject())

}

    
    
}
