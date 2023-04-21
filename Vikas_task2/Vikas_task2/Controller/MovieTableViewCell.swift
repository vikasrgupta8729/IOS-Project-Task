//
//  MovieTableViewCell.swift
//  Vikas_task2
//
//  Created by BATWOMAN on 21/04/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var desclbl: UILabel!
    
    @IBOutlet weak var checkboxBtn: UIButton!
    
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func updateUI(){
        cellView.layer.cornerRadius = 15
    }
    
    
    
}
