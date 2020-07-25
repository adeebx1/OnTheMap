import UIKit
import Foundation

var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt")!)
let session = URLSession.shared
let task = session.dataTask(with: request) { data, response, error in
  if error != nil { // Handle error...
      return
  }
  print(String(data: data!, encoding: .utf8)!)
}
task.resume()
