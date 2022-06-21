
import UIKit

class EmailVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet  weak var okOutlet: UIButton!{
        didSet{
            okOutlet.layer.cornerRadius = 8
        }
    }
    @IBOutlet  weak var emailLabel: UILabel?
    @IBOutlet  weak var emailTF: UITextField?
    var defaultMessage = "Подпишись и я буду рассказывать тебе о всех новостях"
    var emailTextForSave: String?
    var flagTFText: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF?.delegate = self
        obsererForShow()
        observerForHide()
        loadData()
        setFont()
        attrString(str: emailTextForSave, flagStr: flagTFText, labelText: emailLabel?.text)
    }
    
    @IBAction  func okeyAction(_ sender: UIButton) {
        registation(textField: emailTF ?? UITextField())
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        registation(textField: textField)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}


