import Foundation

public protocol SLObjectProtocol{
    
    typealias LangDictionary = [String:String]
    
    var currentLanguage: String { get }
    
    mutating func changeLanguageSet(language: String) -> Void
    
    func getWord(_ word: String) -> String
}

public struct SLLocalizedObject: SLObjectProtocol {
    
    private var currentDictionary: LangDictionary
    private var urlPathToDictionary: URL
    private var service: SLLocalizingService
    public var currentLanguage: String

    //String path to dictionary file init:
    public init(language: String, stringPathToDictionary: String) {
        service = SLLocalizingService()
        currentLanguage = language
        let urlPath = URL(fileURLWithPath: stringPathToDictionary)
        urlPathToDictionary = urlPath
        currentDictionary = service.setDict(language: language, urlPath: urlPathToDictionary)
    }
    
    //URL path to dictionary file init:
    public init(language: String, urlPathToDictionary: URL) {
        service = SLLocalizingService()
        currentLanguage = language
        self.urlPathToDictionary = urlPathToDictionary
        currentDictionary = service.setDict(language: language, urlPath: urlPathToDictionary)
    }
    
    public mutating func changeLanguageSet(language: String) {
        currentDictionary = service.setDict(language: language, urlPath: urlPathToDictionary)
        currentLanguage = language
    }
    
    public func getWord(_ word: String) -> String {
        guard let result = currentDictionary[word] else {
            return service.getError(word)
        }
        return result
    }
    
}
