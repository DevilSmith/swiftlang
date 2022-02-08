import Foundation

internal protocol SLServiceProtocol {
    typealias LangDictionaries = [String:Dictionary<String, String>]
    typealias LangDictionary = [String:String]
    
    func loadData() async -> LangDictionaries
    func setDict(language: String) async -> LangDictionary
    func getError(_ word: String) -> String
}

internal struct SLLocalizingService: SLServiceProtocol {

    func loadData() async -> LangDictionaries {
        
        guard let urlPath = Bundle.module.url(forResource: "Dictionaries", withExtension: "json") else { fatalError("Error") }
        print(urlPath)
        
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
    
    func setDict(language: String) async -> LangDictionary {
        guard let dict = await loadData()[language] else {
            fatalError("(SwiftLang) Dictionary '\(language)' does not exist.")
        }
        return dict
    }
    
    func getError(_ word: String) -> String {
        print("(SwiftLang) Service word '\(word)' not found.")
        return "LOCALE_ERROR"
    }
    
}
