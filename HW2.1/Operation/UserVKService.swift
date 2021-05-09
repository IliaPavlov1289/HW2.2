//
//  UserVKService.swift
//  HW2.1
//
//  Created by Илья Павлов on 13.04.2021.
//


import Foundation
import RealmSwift
import Alamofire


class VKSFriendService {

    lazy var operationQueue = OperationQueue()

    func get() {
        let fetchOperation = FetchOperation()
        let parseOperation = ParseOperation()
        let saveOperation = SaveOperation()

        parseOperation.addDependency(fetchOperation)
        saveOperation.addDependency(parseOperation)

        let operations = [fetchOperation, parseOperation, saveOperation]
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }

    final class FetchOperation: AsyncOperation {
        var outputData: Data?
        var outputError: Error?

        override func main() {
            let baseURL = "https://api.vk.com"
            let path = "/method/friends.get"
            AF.request(baseURL + path, method: .get, parameters: [
                "access_token": Session.shared.token,
                "v": "5.92",
                "fields": "nickname,photo_50"
            ]).responseData { [weak self] (response) in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    self?.outputData = data
                    self?.state = .finished
                case .failure(let error):
                    print(error)
                    self?.outputError = error
                }
            }
        }
    }

    final class ParseOperation: Operation {
        var outputItems: [User]?

        override func main() {
            guard
                let operation = dependencies.first as? FetchOperation,
                let data = operation.outputData
            else { return }
            
            let users = try! JSONDecoder().decode(UserResponse.self, from: data).response.items
            outputItems = users
        }

    }

    final class SaveOperation: Operation {
        override func main() {
            guard
                let operation = dependencies.first as? ParseOperation,
                let items = operation.outputItems
            else { return }

                do {
                    let realm = try Realm()
                    let oldDate = realm.objects(User.self)
                    realm.beginWrite()
                    realm.delete(oldDate)
                    realm.add(items)
                    try realm.commitWrite()
                } catch {
                    print(error)
                }
        }
    }
}

class AsyncOperation: Operation{
    
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath) }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath) }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        if isCancelled { state = .finished }
        else {
            main()
            state = .executing
        }
    }
    
    override func cancel() {
        super.cancel()
        state = .finished
    }
    
}
