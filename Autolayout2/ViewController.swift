//
//  ViewController.swift
//  Autolayout2
//
//  Created by Марина Звягина on 01.07.16.
//  Copyright © 2016 Марина Звягина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var passwordLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var CompanyLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var loggedInUser: User? {
        didSet { updateUI()}
    }
    
    var secure: Bool = false {
        didSet { updateUI() }
    }
    
    private func updateUI() {
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "Secured Password" : "Password"
        nameLabel.text = loggedInUser?.name
        CompanyLabel.text = loggedInUser?.company
        image = loggedInUser?.image
    }
    
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    @IBAction func login() {
        loggedInUser = User.login(loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0)
                } else {
                    aspectRatioConstraint = nil
                }
            }
        }
    }
    // Hide keyboard when you touch on screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, withEvent: event)
    }
    
    var aspectRatioConstraint: NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRatioConstraint {
                view.removeConstraint(existingConstraint)
            }
        }
        didSet {
            if let newConstraint = aspectRatioConstraint {
                view.addConstraint(newConstraint)
            }
        }
    }
    
}

extension User
{
    var image: UIImage?{
        if let image =  UIImage(named: login) {
            return image
        } else {
            return UIImage (named: "unknown_user")
        }
        
    }
}

extension UIImage
{
    var aspectRatio: CGFloat {
        return size.height != 0 ? size.width / size.height : 0
    }
}
