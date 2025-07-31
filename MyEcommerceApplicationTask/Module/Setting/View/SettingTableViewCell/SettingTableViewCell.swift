
import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var switchOnOff: UISwitch!
    @IBOutlet weak var lbldata: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(product: Settinglabels) {
        self.lbldata.text = product.strTitle
        self.imgView.image = UIImage(systemName: product.strImage)
        switchOnOff.isHidden = product.intTag != 7
    }
    
    @IBAction func switcchValueChange(_ sender: Any) {
        print(switchOnOff.isOn ? "On" : "Off")

    }
}
