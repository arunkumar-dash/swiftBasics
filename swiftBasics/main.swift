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


