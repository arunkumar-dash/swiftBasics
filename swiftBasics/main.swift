//
//  main.swift
//  swiftBasics
//
//  Created by Arun Kumar on 10/09/21.
//

import Foundation

print("Hello, World!")

print(type(of: 1..<5))

print(type(of: (1,1)))

let tupleTraverse: ((Int, Int)) -> Void = { tuple in
    print(tuple.0 + tuple.1)
}
print(tupleTraverse((1,2)))

var hasher = Hasher()
hasher.combine(23)
hasher.combine("Hello")
let hashValue = hasher.finalize()
print(hashValue)

let a = ("a", 1, 2, 3, 4, 5)
let b = ("a", 1, 2, 3, 4, 5)
print(a == b)

struct Winners: Equatable {
    var first: Int
    var second: Int
    var third: Int
    init(first: Int, second: Int, third: Int){
        self.first=first
        self.second=second
        self.third=third
    }
    static func == (lhs: Winners, rhs: Winners) -> Bool{
        return lhs.first==rhs.first &&
            lhs.second==rhs.second &&
            lhs.third==rhs.third
    }
}
var fileManager = FileManager()

print(NSUserName(),"Home directory: ", NSHomeDirectoryForUser("arun-pt4306")!)

print(NSFullUserName(), NSHomeDirectory(), fileManager.temporaryDirectory)

//try fileManager.url(for: FileManager.SearchPathDirectory.downloadsDirectory, in: FileManager.SearchPathDomainMask.localDomainMask, appropriateFor: URL(string: "/Users/arun-pt4306/Downloads")!, create: true)

//keypath
struct Videogame {
    var title:String
    var published:String
    var rating:Double
}

let cyberpunk = Videogame(title: "Cyberpunk 2077", published: "2020", rating: 5)
let titleKeyPath = \Videogame.title

print(cyberpunk[keyPath: titleKeyPath])

let games = [
    Videogame(title: "Cyberpunk 2077", published: "2020", rating: 999),
    Videogame(title: "Fallout 4", published: "2015", rating: 4.5),
    Videogame(title: "The Outer Worlds", published: "2019", rating: 4.4),
    Videogame(title: "RAGE", published: "2011", rating: 4.5),
    Videogame(title: "Far Cry New Dawn", published: "2019", rating: 4),
]

extension Array {
    func column<Value>(_ keyPath: KeyPath<Element, Value>) -> [Value] {
        return map { $0[keyPath: keyPath] }
    }
}

print(games.column(\Videogame.title))

//mirror
var mirror = Mirror(reflecting: cyberpunk)
print("Mirror")
for i in mirror.children{
    print("\(i.label ?? ""): \(i.value)")
}
print("test main")

//filemanager
print(String(repeating: "-", count: 10),"FileManager")

let completePath = "/Users/arun-pt4306/Downloads/users1.json"
let home = FileManager.default.homeDirectoryForCurrentUser
let playgroundPath = "Downloads/users1.json"
let playgroundUrl = home.appendingPathComponent(playgroundPath)
print(playgroundUrl.path)
print(playgroundUrl.absoluteString)
print(playgroundUrl.absoluteURL)
print(playgroundUrl.baseURL)
print(playgroundUrl.pathComponents)
print(playgroundUrl.lastPathComponent)
print(playgroundUrl.pathExtension)
print(playgroundUrl.isFileURL)
print(playgroundUrl.hasDirectoryPath)

print(URL(string: "https://webtech.training.oregonstate.edu/faq/what-base-url")?.baseURL) //prints nil always

var urlForEditing = home
print(urlForEditing.path)

urlForEditing.appendPathComponent("Downloads")
print(urlForEditing.path)

urlForEditing.appendPathComponent("Test file")
print(urlForEditing.path)

urlForEditing.appendPathExtension("txt")
print(urlForEditing.path)

urlForEditing.deletePathExtension()
print(urlForEditing.path)

urlForEditing.deleteLastPathComponent()
print(urlForEditing.path)


let fileUrl = home
    .appendingPathComponent("Downloads")
    .appendingPathComponent("Test file")
    .appendingPathExtension("txt")
print(fileUrl.path)

let desktopUrl = fileUrl.deletingLastPathComponent()
print(desktopUrl.path)

fileManager = FileManager.default
print(fileManager.fileExists(atPath: desktopUrl.path))

let missingFile = URL(fileURLWithPath: "this_file_does_not_exist.missing")
print(fileManager.fileExists(atPath: missingFile.path))

var isDirectory: ObjCBool = false
fileManager.fileExists(atPath: desktopUrl.path, isDirectory: &isDirectory)
print(isDirectory.boolValue)

print(URL(string: "/gs/ab", relativeTo: URL(string: "https://google.co.in"))?.absoluteURL)

do{
    try print(URL(string: "/gs/ab", relativeTo: URL(string: "https://google.co.in"))?.bookmarkData().description)
}
catch{
    print("didn't show bookmark")
}

//comparable

struct Orange: Comparable{
    var size: Int
    init(ofSize size: Int){
        self.size=size
    }
    static func <(lhs: Orange, rhs: Orange) -> Bool{
        return lhs.size<rhs.size
    }
    static func ==(lhs: Orange, rhs: Orange) -> Bool{
        return lhs.size==rhs.size
    }
}

//urlsession

// default configuration, store cache and cookie in the disk storage and other urlsession can access it
let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)
var jsonString : String?
config.httpAdditionalHeaders = ["User-Agent":"Legit Safari", "Authorization" : "Bearer key1234567"]
config.timeoutIntervalForRequest = 30
// use saved cache data if exist, else call the web API to retrieve
config.requestCachePolicy = NSURLRequest.CachePolicy.returnCacheDataElseLoad

let url = URL(string: "https://ap.chucknorris.io/jokes/random")!
let task = session.dataTask(with: url) { data, response, error in

    // ensure there is no error for this HTTP response
    guard error == nil else {
        print ("error: \(error!)")
        return
    }
    
    // ensure there is data returned from this HTTP response
    guard let content = data else {
        print("No data")
        return
    }
    
    // serialise the data / NSData object into Dictionary [String : Any]
    guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
        print("Not containing JSON")
        return
    }
    jsonString = String(json.description)
    print("gotten json response dictionary is \n \(json)")
    // update UI using the response here
}

// execute the HTTP request
task.resume()
print("task started")
sleep(5)

struct Response: Codable
{
    struct User: Codable {
        var firstName: String
        var lastName: String
        var country: String
        
        enum CodingKeys: String, CodingKey{
            case firstName = "first_name"
            case lastName = "last_name"
            case country
        }
    }

    var users: [User]
}

//let jsonData = jsonString ?? "".data(using: .utf8)!
//let users = try! JSONDecoder().decode(Response.self, from: jsonData)
//
//for user in users.users {
//    print(user.firstName)
//}


