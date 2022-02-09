import Foundation

/**
 Protocol describing the interface SLLocalizingService
 */
internal protocol SLServiceProtocol {
    typealias LangDictionaries = [String:Dictionary<String, String>]
    typealias LangDictionary = [String:String]
    
    func loadData(_ urlPathToDict: URL) -> LangDictionaries
    func setDict(language: String, urlPath: URL) -> LangDictionary
    func getError(_ word: String) -> String
}

/**
 Process action from SLLocalizedObject and also deserializes a JSON file with described tables.
 */
internal struct SLLocalizingService: SLServiceProtocol {

    func loadData(_ urlPathToDict: URL) -> LangDictionaries {
        
        do{
            let data = try Data(contentsOf: urlPathToDict)
            do {
            let dicts = try JSONDecoder().decode(LangDictionaries.self, from: data)
                return dicts
            } catch {
                let nserror = error
                fatalError("\(nserror)")
            }
        } catch {
            let nserror = error
            fatalError("\(nserror)")
        }
    }
    
    func setDict(language: String, urlPath: URL) -> LangDictionary {
        guard let dict = loadData(urlPath)[language] else {
            fatalError("(SwiftLang) Dictionary '\(language)' does not exist.")
        }
        return dict
    }
    
    func getError(_ word: String) -> String {
        print("(SwiftLang) Service word '\(word)' not found.")
        return "LOCALE_ERROR"
    }
    
}
