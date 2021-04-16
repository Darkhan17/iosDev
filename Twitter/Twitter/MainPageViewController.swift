//
//  MainPageViewController.swift
//  Twitter
//
//  Created by Khamitov Darkhan on 4/12/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class MainPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    var currentUser: User?
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var tweets : [Tweet] = []
    var filterTweets : [Tweet] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomViewCell
        cell.content.text = tweets[indexPath.row].content
        cell.author.text = tweets[indexPath.row].author
        cell.hashtag.text = tweets[indexPath.row].hashtag
        cell.date.text = tweets[indexPath.row].date
        return cell
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           // When there is no text, filteredData is the same as the original data
           // When user has entered text into the search box
           // Use the filter method to iterate over all items in the data array
           // For each item, return true if the item should be included and false if the
           // item should NOT be included
        print(searchText)
            filterTweets = searchText.isEmpty ? tweets : tweets.filter { (item: Tweet) -> Bool in
               // If dataItem matches the searchText, return true to include it
            return item.hashtag?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
           }
           tableView.reloadData()
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = Auth.auth().currentUser
        // Do any additional setup after loading the view.
        let parent = Database.database().reference().child("tweets")
        parent.observe(.value){[weak self](snapshot) in
            self?.tweets.removeAll()
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    let tweet = Tweet(snapshot:snap)
                    self?.tweets.append(tweet)
                }
            }
            self?.tweets.reverse()
            self?.tableView.reloadData()
            self?.filterTweets = self!.tweets
        }
    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: {(contextualAction, view, boolValue) in let alert = UIAlertController(title: "Edit message", message: "Enter a text", preferredStyle: .alert)
            alert.addTextField{(textField) in
                textField.text = self.tweets[indexPath.row].content
            }
            alert.addTextField{(textField) in
                textField.text = self.tweets[indexPath.row].hashtag
            }
            
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: {[weak alert](_) in
                let content = alert?.textFields![0]
                let hashtag = alert?.textFields![1]
                let ref = Database.database().reference()
                let userRef = ref.child("tweets")
                let querRef = userRef.queryOrdered(byChild: "content").queryEqual(toValue: self.tweets[indexPath.row].content)
                querRef.observeSingleEvent(of: .value, with: {(snapshot) in
                    for snap in snapshot.children{
                        let userSnap = snap as! DataSnapshot
                        let uid = userSnap.key
                        ref.child("tweets/\(uid)/content").setValue(content?.text)
                        ref.child("tweets/\(uid)/date").setValue("ddd")
                        ref.child("tweets/\(uid)/hashtag").setValue(hashtag?.text)
                    }
                })
                self.tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {[weak alert ](_)in alert?.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        })
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {
            (contextualAction, view, boolValue) in
            let ref = Database.database().reference()
            let usersRef = ref.child("tweets")
            let queryRef = usersRef.queryOrdered(byChild: "content").queryEqual(toValue: self.tweets[indexPath.row].content)
            queryRef.observeSingleEvent(of : .value, with: {(snapshot) in
                for snap in snapshot.children{
                    let userSnapshot = snap as! DataSnapshot
                    let uid = userSnapshot.key
                    ref.child("tweets/\(uid)").removeValue()
                }
            })
            self.tweets.remove(at: indexPath.row)
            self.tableView.reloadData()
        })
        let swiperAction = UISwipeActionsConfiguration(actions: [editAction,deleteAction])
        return swiperAction
    }
    
    
    @IBAction func composePressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New tweet", message: "Enter a text", preferredStyle: .alert)
        
        alert.addTextField{(textfield) in textfield.placeholder = "What's up"}
        alert.addTextField{(textfield) in textfield.placeholder = "Hashtag"}
        alert.addAction(UIAlertAction(title: "Tweet", style: .default, handler: {
            [weak alert](_) in
            let textField = alert?.textFields![0]
            let textField2 = alert?.textFields![1]
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: date)
            let tweet = Tweet((textField?.text)!,(self.currentUser?.email)!, result, (textField2?.text)!)
            Database.database().reference().child("tweets").child(self.currentUser!.uid).setValue(tweet.dict)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {[](_) in
             
        }))
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
