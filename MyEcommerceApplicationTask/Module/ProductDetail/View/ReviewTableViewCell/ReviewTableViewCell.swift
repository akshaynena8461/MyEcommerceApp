
import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var lblreviewpoint: UILabel!
    @IBOutlet weak var lblcomments: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var lbltimestemp: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgview.layer.cornerRadius = imgview.frame.size.width / 2
        imgview.clipsToBounds = true
        imgview.layer.borderWidth = 1
        imgview.layer.borderColor = UIColor.lightGray.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBOutlet weak var stackstars: UIStackView!
    
    func configreviewcell(reviewmodel: ReviewModel) {
        lblname.text = reviewmodel.name
        lblcomments.text = reviewmodel.comments
        lblreviewpoint.text = "\(reviewmodel.reviewpoint)"
        imgview.image = UIImage(named: reviewmodel.imageName)
        lbltimestemp.text = "\(reviewmodel.timestamp.timeAgoDisplay())"
        fillStars(for: reviewmodel.reviewpoint, in: stackstars)

    }
    
    func fillStars(for rating: Int, in stackView: UIStackView) {
        for (index, view) in stackView.arrangedSubviews.enumerated() {
            if let imageView = view as? UIImageView {
                if index < rating {
                    imageView.image = UIImage(systemName: "star.fill") // Filled star
                    imageView.tintColor = .systemYellow
                } else {
                    imageView.image = UIImage(systemName: "star") // Empty star
                    imageView.tintColor = .systemGray
                }
            }
        }
    }


    
}
