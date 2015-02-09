//
//  MovieDetailViewController.swift
//  Rotten Tomatoes
//
//  Created by Stephanie Wei on 2/5/15.
//  Copyright (c) 2015 Stephanie Wei. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: NSDictionary = NSDictionary()
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NSLog("Response: %@", movie)
        scrollView.contentSize = CGSizeMake(320, 1000)

        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["synopsis"] as? String
        
        var url = movie.valueForKeyPath("posters.thumbnail") as String
        url = url.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: NSStringCompareOptions.LiteralSearch, range: nil)
        posterView.setImageWithURL(NSURL(string: url))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
