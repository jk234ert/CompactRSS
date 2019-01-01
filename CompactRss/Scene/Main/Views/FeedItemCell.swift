//
//  FeedItemCell.swift
//  CompactRss
//
//  Created by jk234ert on 2018/12/28.
//  Copyright © 2018 Brad. All rights reserved.
//

import UIKit
import SwifterSwift

class FeedItemCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    var feedItem: FeedItemProtocol? {
        didSet {
            updateAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateAppearance() {
        titleLabel.text = feedItem?.itemTitle
        
        #warning("update tag later")
        tagLabel.text = "#Tech"
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.setNeedsDisplay()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let autoLayoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let targetSize = CGSize(width: SwifterSwift.screenWidth, height: 0)
        let autoLayoutSize = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        let autoLayoutFrame = CGRect(origin: autoLayoutAttributes.frame.origin, size: autoLayoutSize)
        autoLayoutAttributes.frame = autoLayoutFrame
        return autoLayoutAttributes
    }

}
