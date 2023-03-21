//
//  ViewController.swift
//  fake-people
//
//  Created by Ismail Tever on 21.03.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var user = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitViews()
        loadJsonData()
    }
    private func setInitViews() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func loadJsonData() {
        AF
            .request("https://reqres.in/api/users?page=2")
            .response { response in
                print("\(response)")
                print("\(response.value)")
                    
                let json = try? JSONDecoder().decode(UserList.self, from: response.data!)
                self.user = json!.data
                self.tableView.reloadData()
                
        }
    }

}
extension ViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return user.count
        }
    }
    extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserCell
            if user.count > 0 {
                do{
                    let userData = user[indexPath.row]
                    cell.userImage.image = try UIImage(data: Data(contentsOf: URL(string: userData.avatar)!))
                    cell.nameLabel.text = userData.first_name
                    cell.emailLabel.text = userData.email
                }catch{
                    print(error)
                }
            }
            return cell
        }
    }
