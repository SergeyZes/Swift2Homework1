//
//  PhotosTableViewController.swift
//  VKApp
//
//  Created by Сергей Зесли on 27.02.2020.
//  Copyright © 2020 Сергей Зесли. All rights reserved.
//

import UIKit
import RealmSwift

class PhotosTableViewController: UITableViewController {
    var photos = [Photo]()
    var photos3 = [Photo]()
    var allPhotos: Results<RealmPhoto>?
    var token: NotificationToken?

    func readPhotosFromDB() {
        photos3 = []
        guard let realm = try? Realm() else {
            return
        }
        
        allPhotos = realm.objects(RealmPhoto.self).sorted(byKeyPath: "text")
        
        token = allPhotos?.observe({[weak self] changes in
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

        
//        photos3 = groups.map({ (realmPhoto) -> Photo in
//
//            let photo = Photo(id: realmPhoto.id, text: realmPhoto.text, img: UIImage(data: realmPhoto.picture) ?? #imageLiteral(resourceName: "friends"))
//            return photo
//
//        })
//        tableView.reloadData()

        
    }

    
    
    func getPhotoes() {
            var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems = [
               URLQueryItem(name: "v", value: "5.103"),
               URLQueryItem(name: "access_token", value: Session.instance.token),
               URLQueryItem(name: "extended", value: "1")
            ]
        
        
         do {
            let realm = try Realm()
        
            try realm.write {
                realm.delete(realm.objects(RealmPhoto.self))
            }
            print("Фото удалены из Realm")
                                                      
         } catch {
             print(error)
         }

        
        URLSession.shared.dataTask(with: urlConstructor.url!) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            var photos2 : RootPhotos?
            
            do {
                 photos2 = try JSONDecoder().decode(RootPhotos.self, from: data)
                
            } catch {
                print(error)
                return
            }
            
            guard let photosItems = photos2?.response?.items else {
                return
            }
            
            
            
            print("photosItems.count = \(photosItems)")
            
            DispatchQueue.main.async {
                self.photos = []
                
//                do {
//                    let realm = try Realm()
//                    realm.delete(realm.objects(RealmPhoto.self))
//
//                } catch {
//                    return
//                }
                
                photosItems.forEach { (item) in
                    
                    let idd = item.id ?? 0
                    self.photos.append(Photo(id: idd, text: item.text ?? "", img: #imageLiteral(resourceName: "groups")))
                    
                    guard let urls = item.sizes?.last?.url, let url = URL(string: urls) else {
                       return
                    }
                    
                    URLSession.shared.dataTask(with: url) { data, response, error in
                        guard
                            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                            let data = data, error == nil,
                            let image = UIImage(data: data)
                            else { return }
                        DispatchQueue.main.async() {
                            if let firPh = self.photos.first(where: { (phot) -> Bool in
                                return phot.id == idd
                            }) {
                                firPh.img = image
                                 do {
                                    let realm = try Realm()
                                
                                    try realm.write {
                                        let photo = RealmPhoto()
                                        photo.id = firPh.id
                                        photo.text = firPh.text
                                        photo.picture = image.pngData() ?? Data()
                                        realm.add(photo)
                                        print("Фотография была \(photo.text) добавлена в базу данных Realm")
                                    }
                                    
                                                                              
                                } catch {
                                     print(error)
                                }
                                
                                //self.readPhotosFromDB()
                                
                                
                            }
                                
                        }
                            
                            //self.image = image
                        
                    }.resume()
                    
                    
                }
                //self.tableView.reloadData()
            }
            
            
            
            //print("JSON = \(json)")
        }.resume()

            

        }
    

    override func viewWillAppear(_ animated: Bool) {
        print("willAppear 0000")
        getPhotoes()
        readPhotosFromDB()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        print("didload 00000")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allPhotos?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCelIdentifire", for: indexPath) as! PhotoTableViewCell

        let img: UIImage
        
        if let picture = allPhotos?[indexPath.row].picture {
            img = UIImage(data: picture) ?? #imageLiteral(resourceName: "friends")
        } else {
            img = #imageLiteral(resourceName: "friends")
        }
            
        
        
        cell.img.image = img
        
        let cnt = allPhotos?.count ?? 0
        
        if cnt > indexPath.row {
            cell.caption.text = allPhotos?[indexPath.row].text ?? "anonymous"
        } else {
            cell.caption.text = "anonymous"
        }
        
        

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = indexPath.row
            
            guard row < allPhotos?.count ?? 0 else { return }
            do {
                 let realm = try Realm()
                
                if let group = allPhotos?[row] {
                    try realm.write({
                        realm.delete(group)
                    })
                }

             } catch {
                 print(error)
             }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
