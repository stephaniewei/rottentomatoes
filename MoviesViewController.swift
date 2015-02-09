//
//  MoviesViewController.swift
//  Rotten Tomatoes
//
//  Created by Stephanie Wei on 2/2/15.
//  Copyright (c) 2015 Stephanie Wei. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var networkErrorView: UIView!
    var movies: [NSDictionary]! = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        var url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=qb5zzducnbezekrybv3z627m")
        var request = NSURLRequest(URL: url!)
        SVProgressHUD.show()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                if let httpResponse = response as? NSHTTPURLResponse {
                    if (httpResponse.statusCode != 200) {
                        self.networkErrorView.hidden = false
                        NSLog("error")
                        return
                    }
                }
                
                var responseDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
                
                self.movies = responseDictionary["movies"] as [NSDictionary]
                self.tableView.reloadData()
            })
            dispatch_async(dispatch_get_main_queue(), {
                SVProgressHUD.dismiss()
                })
            })
        

        // Do any additional setup after loading the view.
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(delay: Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
        dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    // ??? What is index path?
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        
        var movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var url = movie.valueForKeyPath("posters.thumbnail") as String
        cell.posterView.setImageWithURL(NSURL(string: url))
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as MovieDetailViewController
        var indexPath = tableView.indexPathForCell(sender as UITableViewCell) as NSIndexPath!
        vc.movie = NSDictionary(dictionary: movies[indexPath.row])
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
