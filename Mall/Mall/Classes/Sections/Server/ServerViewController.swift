//
//  ServerViewController.swift
//  Mall
//
//  Created by midland on 2019/7/18.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit
import WebKit

// MARK: - 客服
class ServerViewController: UIViewController {
    
    private var webView: WKWebView = {
        let userContent = WKUserContentController()
        /*
         let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
         let wkUScript = WKUserScript.init(source: jScript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
         userContent.addUserScript(wkUScript)
         */
        let config = WKWebViewConfiguration()
        config.userContentController = userContent
        return WKWebView.init(frame: CGRect.zero, configuration: config)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "客服"
        setupUI()
        guard let url = URL.init(string: "https://www.baidu.com") else {
            return
        }
        webView.load(URLRequest.init(url: url))
    }
    
    
    // MARK: - Private methods
    private func setupUI() {
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        // setupNavBar()
    }
    

    private func setupNavBar() {

        // 分享按钮
        let shareButton = UIButton(type: .custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let shareImage = UIImage.init(named: "knowledge-Btn-Share")
        shareButton.setImage(shareImage, for: .normal)
        shareButton.setImage(shareImage, for: .highlighted)
        shareButton.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        debugPrint(shareButton)
        // navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        
    }
    
    func setGetWebContent(html: String) -> String {
        
        var content = "<html>"
        content += "<head>"
        content += "<meta charset='utf-8' />"
        content += "<meta name='apple-mobile-web-app-capable' content='yes'>"
        content += "<meta name='apple-mobile-web-app-status-bar-style' content='black'>"
        content += "<meta name='viewport' content='width=device-width,initial-scale=1, minimum-scale=1.0, maximum-scale=1, user-scalable=no'>"
        content += "</head>"
        content += "<body id='cont' >"
        content += html
        content += "</body>"
        content += "</html>"
        return content
        
        /*
         content += "<script type='text/javascript'>"
         content += "window.onload=function(){"
         content += "var src=document.getElementsByTagName('img');"
         content += "var width = document.body.clientWidth;"
         content += "for (var i=0; i<src.length; i++) {"
         content += "var imageh = src[i].naturalHeight;"
         content += "if(src[i].naturalWidth > width){"
         content += "src[i].setAttribute('width','100%');"
         content += "var imagew = src[i].naturalWidth;"
         content += "var contentH = width * imageh / imagew;"
         content += "src[i].setAttribute('height',contentH + 'px');"
         content += "}"
         content += "src[i].setAttribute('style','margin-top:0px;');}}"
         content += "</script>"
         */
        
    }
    

    // MARK: - Event response
    // canGoback
    @objc
    func buttonBackAction() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    // 关闭
    @objc
    func buttonCloseAction() {
        navigationController?.popViewController(animated: true)
    }
    
    // 分享
    @objc
    func shareAction() {
        
    }
    
    @IBAction func goodButtonAction(_ sender: Any) {
    }
    

}


// MARK: - WKNavigationDelegate
extension ServerViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        var webheight: CGFloat = 0.0
        
        // 获取内容实际高度
        self.webView.evaluateJavaScript("document.body.scrollHeight") { [unowned self] (result, error) in
            
            if let tempHeight: Double = result as? Double {
                webheight = CGFloat(tempHeight)
                print("webheight: \(webheight)")
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else {return}
                debugPrint(self)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
}

