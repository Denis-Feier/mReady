//
//  GithubRepo.swift
//  mReady
//
//  Created by Denis Feier on 24.04.2021.
//

import Foundation
import SwiftyJSON

class GithubRepo {
    
    var name: String
    var full_name: String
    var html_url: String
    var description: String
    var open_issues: Int
    var default_branch: String
    var forks: Int
    var watchers: Int
    var stargazers_count: Int
    var owner: OwnerRepo
    
    init(name: String, full_name: String, html_url: String, description: String, open_issues: Int, default_branch: String, forks: Int, watchers: Int, owner: OwnerRepo, stargazers_count: Int) {
        self.name = name
        self.full_name = full_name
        self.html_url = html_url
        self.description = description
        self.open_issues = open_issues
        self.default_branch = default_branch
        self.forks = forks
        self.watchers = watchers
        self.owner = owner
        self.stargazers_count = stargazers_count
    }
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.full_name = json["full_name"].stringValue
        self.html_url = json["html_url"].stringValue
        self.description = json["description"].stringValue
        self.open_issues = json["open_issues"].intValue
        self.default_branch = json["default_branch"].stringValue
        self.forks = json["forks"].intValue
        self.watchers = json["watchers"].intValue
        self.owner = OwnerRepo(json: json["owner"])
        self.stargazers_count = json["stargazers_count"].intValue
    }
}
