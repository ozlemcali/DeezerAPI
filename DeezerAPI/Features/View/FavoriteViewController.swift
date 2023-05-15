//
//  FavoriteViewController.swift
//  DeezerAPI
//
//  Created by ozlem on 15.05.2023.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    
    @IBOutlet var tableView: UITableView!
    var nameArray = [String]()
    var durationArray = [String]()
    var idArray = [UUID]()
    var imageArray = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getData()
    }
    
    func configure(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "newData"), object: nil)
    }
    
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        /*
        let point = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            let index = indexPath.row
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSongs")
            fetchRequest.predicate = NSPredicate(format: "id = %@", idArray[index].uuidString)
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    if let result = results.first as? NSManagedObject {
                        context.delete(result)
                        try context.save()
                        
                        nameArray.remove(at: index)
                        durationArray.remove(at: index)
                        idArray.remove(at: index)
                        imageArray.remove(at: index)
                        
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Error deleting favorite song:", error)
            }*/
        
        let index = sender.tag
            
            if index < idArray.count {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSongs")
                fetchRequest.predicate = NSPredicate(format: "id = %@", idArray[index].uuidString)
                
                do {
                    let results = try context.fetch(fetchRequest)
                    if results.count > 0 {
                        if let result = results.first as? NSManagedObject {
                            context.delete(result)
                            try context.save()
                            
                            nameArray.remove(at: index)
                            durationArray.remove(at: index)
                            idArray.remove(at: index)
                            imageArray.remove(at: index)
                            
                            self.tableView.reloadData()
                        }
                    }
                } catch {
                    print("Error deleting favorite song:", error)
                }
            }
        }
        
        
    
    
    
    
    @objc func getData() {
        imageArray.removeAll(keepingCapacity: false)
        nameArray.removeAll(keepingCapacity: false)
        idArray.removeAll(keepingCapacity: false)
        durationArray.removeAll(keepingCapacity: false)
      
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSongs")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArray.append(name)
                    }
                    if let duration = result.value(forKey: "time") as? String {
                        self.durationArray.append(duration)
                    }
                    
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    if let imageData = result.value(forKey: "image") as? Data,
                       let image = UIImage(data: imageData) {
                        self.imageArray.append(image)
                    }
                }
                
                self.tableView.reloadData()
            }
            
        } catch {
            print("error")
        }
        
    }
}

extension FavoriteViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! FavoriteViewCell
    
        if indexPath.row < nameArray.count {
            cell.favoriteSongName.text = nameArray[indexPath.row]
        }
        if indexPath.row < durationArray.count {
            cell.favoriteSongTime.text = durationArray[indexPath.row]
        }
        if indexPath.row < imageArray.count {
            cell.favoriteSongImage.image = imageArray[indexPath.row]
        }
        
        return cell
        
    }
}

extension FavoriteViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
