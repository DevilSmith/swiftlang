import Foundation

internal protocol SLServiceProtocol {
    typealias LangDictionaries = [String:Dictionary<String, String>]
    typealias LangDictionary = [String:String]
    
    func loadData() -> LangDictionaries
    func setDict(language: String) -> LangDictionary
    func getError(_ word: String) -> String
}

/**
 Process action from SLLocalizedObject and also deserializes a JSON file with described tables.
 */
internal struct SLLocalizingService: SLServiceProtocol {

    func loadData() -> LangDictionaries {
        
        guard let urlPath = Bundle.module.url(forResource: "Dictionaries", withExtension: "json") else { fatalError("Error") }
        
        do{
            let data = try Data(contentsOf: urlPath)
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
    
    func setDict(language: String) -> LangDictionary {
        guard let dict = loadData()[language] else {
            fatalError("(SwiftLang) Dictionary '\(language)' does not exist.")
        }
        return dict
    }
    
    func getError(_ word: String) -> String {
        print("(SwiftLang) Service word '\(word)' not found.")
        return "LOCALE_ERROR"
    }
    
}
