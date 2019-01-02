//
//  UISegmentCustom.swift
//  UISegmentCustom
//
//  Created by Macintosh on 1/15/1397 AP.
//  Copyright © 1397 ali. All rights reserved.
//

import UIKit

@IBDesignable
class UISegmentCustom: UIControl {

    var buttons = [UIButton]()
    var selector : UIView!
    let selectorTitle = UILabel()
    
    var selectedSegmentIndex = 0
    
    
    
    @IBInspectable
    var borderWidth : CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor : UIColor = UIColor.clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = ""{
        didSet{
            updateView()
        }
    }
    
    
    @IBInspectable
    var textColor : UIColor = .lightGray{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor : UIColor = .darkGray{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor : UIColor = .white{
        didSet{
            updateView()
        }
    }
    
    func updateView() {
        buttons.removeAll()
        subviews.forEach{ $0.removeFromSuperview() }
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        let buttonWidth = frame.width / CGFloat(buttonTitles.count)
        
        var buttonX = frame.width - buttonWidth
        
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor( textColor , for: .normal)
            
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = frame.height / 2
            button.layer.shadowRadius = 1
            button.layer.shadowOpacity = 0.2
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            button.frame = CGRect(x: buttonX, y: 0, width: buttonWidth , height: frame.height)
            buttonX = buttonX -  buttonWidth
            addSubview(button)
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        selectorTitle.text = buttons[0].titleLabel?.text
        
        
        
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x:  frame.width - buttonWidth , y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height / 2
        selector.layer.shadowRadius = 1
        selector.layer.shadowOpacity = 0.2
        selector.layer.shadowOffset = CGSize(width: 0, height: 0)
        selector.backgroundColor = selectorColor
        
        
        selectorTitle.textColor = UIColor.white
        selectorTitle.textAlignment = .center
        selectorTitle.frame = CGRect(x: 0, y: 0, width: selector.frame.width , height: selector.frame.height)
        selector.addSubview(selectorTitle)
        addSubview(selector)
        
        
    }
    
    @objc func buttonTapped ( _ sender : UIButton){
        for (buttonIndex , btn)   in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == sender {
                selectedSegmentIndex = buttonIndex
                //                let selectorStartPosition = (frame.width / CGFloat(buttons.count)) * CGFloat(buttonIndex)
                let selectorStartPosition = frame.width - (frame.width / CGFloat(buttons.count)) * (CGFloat(buttonIndex + 1 ))
                UIView.animate(withDuration: 0.3 , animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                btn.setTitleColor(selectorTextColor, for: .normal)
                selectorTitle.text = btn.titleLabel?.text
            }
            
        }
        
        sendActions(for: .valueChanged)
    }
    
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
        updateView()
    }
    
    func changeSelectedSegment(index : Int)  {
        for (buttonIndex , btn)   in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
        }
        selectedSegmentIndex = index
        let selectorStartPosition = frame.width - (frame.width / CGFloat(buttons.count)) * (CGFloat(index + 1 ))
        UIView.animate(withDuration: 0.1 , animations: {
            self.selector.frame.origin.x = selectorStartPosition
        })
        buttons[index].setTitleColor(selectorTextColor, for: .normal)
        selectorTitle.text = buttons[index].titleLabel?.text
    }


}
