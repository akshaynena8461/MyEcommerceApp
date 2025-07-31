
import Foundation

class AddressModel{
    
    var strFirstName:String = "";
    var strLastName:String = "";
    var strEmail:String = "";
    var strMobile:String = "";
    var strDob:String = "";
    var strState:String = "";
    var strCity:String = "";
    var strAddress1:String = "";
    var strAddress2:String = "";
    var strPincode:String = "";
    var selectedState: String?
    var selectedCity: String?
    
    
    init(strFirstName: String, strLastName: String, strEmail: String, strMobile: String, strDob: String, strState: String, strCity: String, strAddress1: String, strAddress2: String, strPincode: String) {
        self.strFirstName = strFirstName
        self.strLastName = strLastName
        self.strEmail = strEmail
        self.strMobile = strMobile
        self.strDob = strDob
        self.strState = strState
        self.strCity = strCity
        self.strAddress1 = strAddress1
        self.strAddress2 = strAddress2
        self.strPincode = strPincode
    }
    
    static let stateCityData: [String: [String]] = [
        "Andhra Pradesh": ["Visakhapatnam", "Vijayawada", "Guntur"],
        "Arunachal Pradesh": ["Itanagar", "Tawang", "Naharlagun"],
        "Assam": ["Guwahati", "Silchar", "Dibrugarh"],
        "Bihar": ["Patna", "Gaya", "Bhagalpur"],
        "Chhattisgarh": ["Raipur", "Bilaspur", "Durg"],
        "Goa": ["Panaji", "Margao", "Vasco da Gama"],
        "Gujarat": ["Ahmedabad", "Surat", "Vadodara"],
        "Haryana": ["Gurgaon", "Faridabad", "Panipat"],
        "Himachal Pradesh": ["Shimla", "Manali", "Dharamshala"],
        "Jharkhand": ["Ranchi", "Jamshedpur", "Dhanbad"],
        "Karnataka": ["Bengaluru", "Mysuru", "Mangalore"],
        "Kerala": ["Kochi", "Thiruvananthapuram", "Kozhikode"],
        "Madhya Pradesh": ["Bhopal", "Indore", "Jabalpur"],
        "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
        "Manipur": ["Imphal", "Bishnupur", "Thoubal"],
        "Meghalaya": ["Shillong", "Tura", "Nongpoh"],
        "Mizoram": ["Aizawl", "Lunglei", "Champhai"],
        "Nagaland": ["Kohima", "Dimapur", "Mokokchung"],
        "Odisha": ["Bhubaneswar", "Cuttack", "Rourkela"],
        "Punjab": ["Amritsar", "Ludhiana", "Jalandhar"],
        "Rajasthan": ["Jaipur", "Jodhpur", "Udaipur"],
        "Sikkim": ["Gangtok", "Namchi", "Geyzing"],
        "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai"],
        "Telangana": ["Hyderabad", "Warangal", "Nizamabad"],
        "Tripura": ["Agartala", "Udaipur", "Dharmanagar"],
        "Uttar Pradesh": ["Lucknow", "Kanpur", "Varanasi"],
        "Uttarakhand": ["Dehradun", "Haridwar", "Nainital"],
        "West Bengal": ["Kolkata", "Siliguri", "Durgapur"]
    ]
    
    static var stateList: [String] {
        return Array(stateCityData.keys).sorted()
    }
    
    static func cities(forState state: String) -> [String] {
        return stateCityData[state] ?? []
    }
    
    
}
