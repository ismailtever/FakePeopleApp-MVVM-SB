//
//  ViewController.swift
//  fake-people
//
//  Created by Ismail Tever on 21.03.2023.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
//    private var userTableViewModel: UserTableViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var user = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitViews()
//        Webservice().loadJsonData()
//      Webservice().tableView?.reloadData()
//      getData()
//      tableView.reloadData()
        loadJsonData()
    }
    
//    func getData() {
//        let url = URL(string: "https://reqres.in/api/users?page=2")
//
//        Webservice().urlSessionIndirme(url: url!) { kisiler in
//            if let kisiler = kisiler {
//                self.userTableViewModel = UserTableViewModel(userList: kisiler)
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }
    private func setInitViews() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func loadJsonData() {
        AF
            .request("https://reqres.in/api/users?page=2")
            .response { response in
//                print("\(response)")
//                print("\(response.value)")

                let json = try? JSONDecoder().decode(UserList.self, from: response.data!)
                self.user = json!.data
//                self.tableView.reloadData()

                DispatchQueue.main.async {
                    self.tableView.reloadData()

                }
        }
    }

}
extension ViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return user.count
//            return userTableViewModel == nil ? 0 : self.userTableViewModel.numberOfRowsInSection()
        }
    }
extension ViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserCell
//            let userViewModel = self.userTableViewModel.userAtIndexPath(indexPath.row)
//            cell.nameLabel.text = userViewModel.first_name
//            cell.surnameLabel.text = userViewModel.last_name

            if user.count > 0 {
                do{
                    let userData = user[indexPath.row]
                    cell.userImage.layer.cornerRadius = CGRectGetWidth(cell.userImage.frame)/4.0

                    cell.userImage.layer.borderWidth=1.0
                    cell.userImage.layer.masksToBounds = false
                    cell.userImage.clipsToBounds = true
                    cell.userImage.image = try UIImage(data: Data(contentsOf: URL(string: userData.avatar)!))
                    cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
                    cell.nameLabel.text = userData.first_name
                    cell.surnameLabel.font = UIFont.boldSystemFont(ofSize: 16)
                    cell.surnameLabel.text = userData.last_name
                    cell.emailLabel.text = userData.email
                }catch{
                    print(error)
                }
            }
            return cell
        }
    }
