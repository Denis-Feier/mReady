//
//  ViewController.swift
//  mReady
//
//  Created by Denis Feier on 24.04.2021.
//

import UIKit
import Alamofire

class ListOfReposVC: UIViewController {

    @IBOutlet weak var listOfRepo: UITableView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var pageLable: UILabel!
    
    var currentPage: Int = 0
    var spinner: SpinnerViewController? = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextBtn.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        prevBtn.addTarget(self, action: #selector(prevTapped), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setButtons()
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
        if currentPage == 99 {
            nextBtn.isHidden = true
        } else {
            nextBtn.isHidden = false
        }
    }
    
    fileprivate func setPrevBtn() {
        if currentPage == 0 {
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
        pageLable.text = "Page \(currentPage + 1)"
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
    
    fileprivate func getRepoFromApi(page: Int = 0) {

        showSpinner()
        
        let path = "https://api.github.com/search/repositories?q=language:Swift+language:objective-c&sort=stars&page=\(page)&per_page=10"
        
        AF.request(path).responseJSON {response in
            self.dismissSpinner()
            switch response.result {
                case .success(let data):
                    print(data)
                case .failure(let err):
                    print(err)
            }
        }
        
    }
    
}

extension ListOfReposVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
