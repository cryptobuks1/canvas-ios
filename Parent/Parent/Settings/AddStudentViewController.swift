//
// Copyright (C) 2016-present Instructure, Inc.
//   
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3 of the License.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
    
    

import UIKit
import Result
import SoLazy
import TooLegit
import Airwolf
import SoPersistent
import CWStatusBarNotification
import Armchair

class WebLoginViewController: UIViewController {
    
    let request: NSURLRequest?
    let useBackButton: Bool
    var prompt: String? = nil
    
    let webView = UIWebView()
    private let backButton = UIButton(type: .Custom)
    private let statusBarNotification = CWStatusBarNotification()
    
    init(request: NSURLRequest?, useBackButton: Bool = false) {
        self.request = request
        self.useBackButton = useBackButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearExistingCookies()
        
        setupWebView()
        setupBackButton()
        
        startLoginRequest()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let prompt = prompt {
            statusBarNotification.displayNotificationWithMessage(prompt) { _ in }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        statusBarNotification.dismissNotification()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    private func clearExistingCookies() {
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        if let cookies = storage.cookies {
            for cookie in cookies {
                storage.deleteCookie(cookie)
            }
        }
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func setupBackButton() {
        if let navController = self.navigationController where !navController.navigationBarHidden {
            return
        }
        let backImage = UIImage.RTLImage("icon_back", renderingMode: .AlwaysTemplate)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setBackgroundImage(backImage, forState: .Normal)
        backButton.setBackgroundImage(backImage, forState: .Selected)
        backButton.tintColor = UIColor.whiteColor()
        
        self.view.addSubview(backButton)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[subview]", options: .DirectionLeadingToTrailing, metrics: nil, views: ["subview": backButton]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[subview]", options: .DirectionLeadingToTrailing, metrics: nil, views: ["subview": backButton]))
        
        backButton.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40.0))
        backButton.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 40.0))
        
        backButton.addTarget(self, action: #selector(backButtonPressed(_:)), forControlEvents: .TouchUpInside)
        backButton.hidden = !useBackButton
    }
    
    func setupWebView() {
        self.automaticallyAdjustsScrollViewInsets = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(webView)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[webview]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["webview": webView]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[webview]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["webview": webView]))
    }
    
    func backButtonPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func startLoginRequest() {
        if let request = self.request {
            webView.loadRequest(request)
        }
    }
    
    func presentUnexpectedAuthError() {
        let alertController = UIAlertController(title: NSLocalizedString("Authorization Failed.", comment: "Authorization Failed Title"), message: NSLocalizedString("Unexpected Authentication Error.  Please try logging in again", comment: "Auth Failed Message"), preferredStyle: .Alert)
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: "OK Button Title"), style: .Default, handler: { [weak self] _ in self?.navigationController?.popViewControllerAnimated(true) })
        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func handleCommonResponses(url: NSURL) -> (failedLogin: Bool, shouldStartLoad: Bool) {
        if url.absoluteString!.containsString("/oauthFailure") {
            self.presentUnexpectedAuthError()
            return (true, false)
        } else if url.absoluteString!.containsString("/oauth2/deny") {
            self.navigationController?.popViewControllerAnimated(true)
            return (true, false)
        } else if url.absoluteString!.containsString("404") {
            backButton.tintColor = UIColor.blackColor()
            return (true, true)
        }
        
        return (false, false)
    }
}

class AddStudentViewController: WebLoginViewController {
    
    var completionHandler: ((Result<Bool, NSError>)->Void)?
    let refresher: Refresher
    
    init(session: Session, domain: NSURL, useBackButton: Bool = false, completionHandler: (Result<Bool, NSError>)->Void) throws {
        self.refresher = try Student.observedStudentsRefresher(session)
        
        super.init(request: try? AirwolfAPI.addStudentRequest(session, parentID: session.user.id, studentDomain: domain))
        
        webView.delegate = self
        self.completionHandler = completionHandler
    }
    
    required init?(coder aDecoder: NSCoder) {
        ❨╯°□°❩╯⌢"Can't handle storyboards so don't even try."
    }
}

extension AddStudentViewController: UIWebViewDelegate {
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.URL {
            if url.description == "about.blank" {
                return false
            }

            let commonErrorResults = handleCommonResponses(url)
            if commonErrorResults.failedLogin {
                return commonErrorResults.shouldStartLoad
            }
            
            if url.absoluteString!.containsString("/oauthSuccess") {
                // Clear the cookies so you're not automatically logged into a session on the next browser launch
                Armchair.userDidSignificantEvent(true)
                clearExistingCookies()
                refresher.refreshingCompleted.observeNext { [weak self] _ in
                    self?.completionHandler?(.Success(true))
                }
                refresher.refresh(true)
                return false
            }
        }

        return true
    }
}
