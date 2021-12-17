//
//  WebsiteViewController.swift
//  BottleRocket
//
//  Created by Ethan Perkins on 12/15/21.
//


import UIKit
import WebKit


class WebsiteViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        importWeb()
        addButtons()
    }
    
    func importWeb() {
        self.webView = WKWebView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        self.view.addSubview(webView)
        
        let myURL = URL(string: "https://www.bottlerocketstudios.com")
        let myURLRequest: URLRequest = URLRequest(url: myURL!)
        webView.load(myURLRequest)
    }
    
    func addButtons() {
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        backButton.setImage(UIImage(named: "ic_webBack"), for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: backButton)
        
        let refreshButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        refreshButton.setImage(UIImage(named: "ic_webRefresh"), for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: refreshButton)
        
        let forwardButton = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        forwardButton.setImage(UIImage(named: "ic_webForward"), for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardTapped), for: .touchUpInside)
        let item3 = UIBarButtonItem(customView: forwardButton)
        
        navigationItem.setLeftBarButtonItems([item1, item2, item3], animated: false)
        
    }
    
    @objc func backTapped() {
        self.webView.goBack()
    }
    
    @objc func refreshTapped() {
        self.webView.reload()
    }
    
    @objc func forwardTapped() {
        self.webView.goForward()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
