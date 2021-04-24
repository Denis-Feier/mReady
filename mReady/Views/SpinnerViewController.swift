//
//  SpinnerViewController.swift
//  mReady
//
//  Created by Denis Feier on 24.04.2021.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .whiteLarge)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    static func showSpinnerView(vc: UIViewController, spinner: SpinnerViewController) {
        DispatchQueue.main.async {
            vc.addChild(spinner)
            spinner.view.frame = vc.view.frame
            vc.view.addSubview(spinner.view)
            spinner.didMove(toParent: vc)
        }
    }
    
    static func removeSpinnerView(spinner: SpinnerViewController) {
        DispatchQueue.main.async {
            spinner.willMove(toParent: nil)
            spinner.view.removeFromSuperview()
            spinner.removeFromParent()
        }
    }
    
}
