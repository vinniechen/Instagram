//
//  HomeViewController.swift
//  Instagram
//
//  Created by Vinnie Chen on 3/31/17.
//  Copyright © 2017 Vinnie Chen. All rights reserved.
//

import UIKit
import Parse


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var feed: [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Query
        let query = PFQuery(className: "Post")
        query.order(byDescending: "_created_at")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.feed = posts
                self.tableView.reloadData()
                
            }
            else {
                print(error?.localizedDescription ?? "")
            }
        }
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    // Cell function
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        //Initialize caption and username labels from the post
        let post = feed[indexPath.row]
        cell.captionLabel.text = post["caption"] as! String?
        cell.usernameLabel.text = post["username"] as! String?
        print(post["username"] as! String?)
        //Retrieve photo data and update the cell's image with it
        let photo = post["media"] as! PFFile
        photo.getDataInBackground { (data: Data?, error: Error?) in
            if let data = data {
                cell.postImage.image = UIImage(data: data)
            }
            else {
                print(error?.localizedDescription ?? "")
            }
        }
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
