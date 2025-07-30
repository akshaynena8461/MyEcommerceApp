


import UIKit

var app = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var arrCart:[ProductModel] = []
    var arrWishlist: [ProductModel] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let data = UserDefaults.standard.value(forKey: "WishList") {
            do{
                let arr = try JSONDecoder().decode([ProductModel].self, from: data as! Data)
                arrWishlist = arr
            }
            catch{
                print(error)
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationwillterminatae")
        do {
            let data = try JSONEncoder().encode(app.arrWishlist)
            UserDefaults.standard.set(data, forKey: "WishList")
            UserDefaults.standard.synchronize()
        }
        catch{
            print(error)
        }
    }
}


