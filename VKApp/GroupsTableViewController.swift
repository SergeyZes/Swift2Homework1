//
//  GroupsTableViewController.swift
//  VKApp
//
//  Created by Сергей Зесли on 20.01.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 74
        tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
     
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return VkDataBase.shared().myGroups.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupTableCell", for: indexPath) as! GroupTableViewCell

        cell.groupLabel.text = VkDataBase.shared().myGroups[indexPath.row].name
        cell.groupImage.image = VkDataBase.shared().myGroups[indexPath.row].image

        return cell
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        let vc = unwindSegue.source as! AllGroupsTableViewController
        
        if let ip = vc.tableView.indexPathForSelectedRow {
            let group = vc.groups[ip.row]
                        
            VkDataBase.shared().myGroups.append(group)
            tableView.reloadData()
        }
        
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
        if editingStyle == .delete {
            VkDataBase.shared().myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
        if segue.identifier == "allGroupsSegue" {
            let vc = segue.destination as! AllGroupsTableViewController
            vc.groups = [Group]()
            
            outerloop: for group in VkDataBase.shared().allGroups {
                for gp in VkDataBase.shared().myGroups {
                    if gp.id == group.id {
                        continue outerloop
                    }
                }
                vc.groups.append(group)
            }
        }
        
    }
    

}
