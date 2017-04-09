//
//  FilterTableViewCell.swift
//  Yelp
//
//  Created by Bhagat, Puneet on 4/9/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FilterTableViewCellDelegate{
    @objc optional func filterTableViewCell(filterTableViewCell: FilterTableViewCell, didChangeValue value: Bool)
}

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    weak var delegate: FilterTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        onSwitch.addTarget(self, action: #selector(FilterTableViewCell.switchValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func switchValueChanged() {
        delegate?.filterTableViewCell?(filterTableViewCell: self, didChangeValue: onSwitch.isOn)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViews()
    }
    
    func initViews() {
        selectedBackgroundView = UIView(frame: frame)
        selectedBackgroundView?.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 0.9, alpha: 0.8)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        super.setSelected(selected, animated: animated)
        let fontSize: CGFloat = selected ? 34.0 : 17.0
        self.textLabel?.font = self.textLabel?.font.withSize(fontSize)
    }
}
