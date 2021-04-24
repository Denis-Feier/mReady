//
//  DetailsRepoVC.swift
//  mReady
//
//  Created by Denis Feier on 24.04.2021.
//

import UIKit
import WebKit

class DetailsRepoVC: UIViewController {

    @IBOutlet weak var forks: UILabel!
    @IBOutlet weak var whatchers: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var readmeWebView: WKWebView!
    
    var repo: GithubRepo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forks.text = "\(repo.forks)"
        whatchers.text = "\(repo.watchers)"
        user.text = "\(repo.owner.login)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let url = URL(string: getReadme()) {
            readmeWebView.load(URLRequest(url: url))
        }
        
    }
    
    fileprivate func getReadme() -> String {
        return "https://github.com/\(repo.full_name)/blob/\(repo.default_branch)/README.md"
    }
    
}
