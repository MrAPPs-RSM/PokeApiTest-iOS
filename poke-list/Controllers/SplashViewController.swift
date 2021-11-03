//
//  SplashController.swift
//  poke-list
//
//  Created by Nicola Innocenti on 31/10/21.
//

import UIKit
import PureLayout

class SplashViewController: BaseViewController {
    
    // MARK: - Layout
    
    var spinner: UIActivityIndicatorView = {
        var activityIndicator: UIActivityIndicatorView!
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        activityIndicator.color = .gray
        return activityIndicator
    }()
    var lblProgress: UILabel = {
        let label = UILabel()
        label.textColor = .navBarTint
        label.textAlignment = .center
        label.font = UIFont.regular(size: 17)
        label.numberOfLines = 0
        return label
    }()
    var progressBar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.layer.cornerRadius = 4
        progressView.trackTintColor = .lightGray
        progressView.progressTintColor = UIColor.green.darker
        return progressView
    }()
    
    // MARK: - Variables
    
    private var viewModel: SplashViewModel!
    
    // MARK: - UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        createLayout()
    }
    
    func createLayout() {
        view.addSubview(spinner)
        spinner.autoAlignAxis(toSuperviewAxis: .horizontal)
        spinner.autoAlignAxis(toSuperviewAxis: .vertical)
        spinner.startAnimating()
        
        view.addSubview(lblProgress)
        lblProgress.autoAlignAxis(toSuperviewAxis: .vertical)
        lblProgress.autoPinEdge(.top, to: .bottom, of: spinner, withOffset: 16)
        lblProgress.autoPinEdge(toSuperviewEdge: .leading, withInset: 30, relation: .greaterThanOrEqual)
        lblProgress.autoPinEdge(toSuperviewEdge: .trailing, withInset: 30, relation: .greaterThanOrEqual)
        
        view.addSubview(progressBar)
        progressBar.autoAlignAxis(toSuperviewAxis: .vertical)
        progressBar.autoPinEdge(.top, to: .bottom, of: lblProgress, withOffset: 16)
        progressBar.autoSetDimension(.width, toSize: 240)
        progressBar.autoSetDimension(.height, toSize: 8)
    }
    
    // MARK: - Other Methods
    
    func setupViewModel() {
        viewModel = SplashViewModel()
        viewModel.onSetupComplete = {(success, message) in
            self.spinner.stopAnimating()
            DispatchQueue.main.async {
                UIApplication.shared.loadMainInterface()
            }
        }
        viewModel.onProgress = { (message, percentage) in
            self.lblProgress.text = message
            self.progressBar.setProgress(percentage, animated: false)
        }
    }
}
