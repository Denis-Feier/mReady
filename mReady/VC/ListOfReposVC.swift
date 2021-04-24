//
//  ViewController.swift
//  mReady
//
//  Created by Denis Feier on 24.04.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListOfReposVC: UIViewController {

    @IBOutlet weak var listOfRepo: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var pageLable: UILabel!
    
    var currentPage: Int = 1
    var spinner: SpinnerViewController? = SpinnerViewController()
    
    var repos: [GithubRepo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listOfRepo.delegate = self
        listOfRepo.dataSource = self
        nextBtn.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        prevBtn.addTarget(self, action: #selector(prevTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setButtons()
        getRepoFromApi()
    }
    
    @objc fileprivate func nextTapped() {
        currentPage += 1
        setButtons()
        setPageLabel()
        getRepoFromApi(page: currentPage)
    }
    
    fileprivate func setButtons() {
        setNextBtn()
        setPrevBtn()
    }
    
    fileprivate func setNextBtn() {
        if currentPage == 100 {
            nextBtn.isHidden = true
        } else {
            nextBtn.isHidden = false
        }
    }
    
    fileprivate func setPrevBtn() {
        if currentPage == 1 {
            prevBtn.isHidden = true
        } else {
            prevBtn.isHidden = false
        }
    }
    
    @objc fileprivate func prevTapped() {
        currentPage -= 1
        setButtons()
        setPageLabel()
        getRepoFromApi(page: currentPage)
    }
    
    fileprivate func setPageLabel() {
        pageLable.text = "Page \(currentPage)"
    }
    
    
    fileprivate func showSpinner() {
        if let s = spinner {
            SpinnerViewController.showSpinnerView(vc: self, spinner: s)
        }
    }
    
    fileprivate func dismissSpinner() {
        if let s = spinner {
            SpinnerViewController.removeSpinnerView(spinner: s)
        }
    }
    
    fileprivate func getRepoFromApi(page: Int = 1) {

        showSpinner()
        
        let path = "https://api.github.com/search/repositories?q=language:Swift+language:objective-c&sort=stars&page=\(page)&per_page=10"
        
        AF.request(path).responseJSON {response in
            self.dismissSpinner()
            switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    self.repos = []
                    for element in json["items"].arrayValue {
                        self.repos.append(GithubRepo(json: element))
                    }
                    DispatchQueue.main.async {
                        self.listOfRepo.reloadData()
                    }
                case .failure(let err):
                    print(err)
            }
        }
        
    }
    
}

extension ListOfReposVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitHubRepoTableViewCell") as! GitHubRepoTableViewCell
        
        let repo = repos[indexPath.item]
        
        cell.repoName.text = repo.name
        cell.repoStars.text = "\(repo.stargazers_count)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repos[indexPath.item]
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "DetailsRepoVC") as! DetailsRepoVC
        
        controller.repo = repo
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
}
