//
//  walletTableViewCell.swift
//  carcabigateFinal
//
//  Created by Arqam Butt on 22/07/2017.
//  Copyright © 2017 Arqam Butt. All rights reserved.
//

import UIKit

class walletTableViewCell: UITableViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var labelImages: UIImageView!
    @IBOutlet weak var rightTcik: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
