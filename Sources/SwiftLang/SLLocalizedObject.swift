import Foundation

public protocol SLObjectProtocol{
    
    typealias LangDictionary = [String:String]
    
    var currentLanguage: String { get }
    
    mutating func changeLanguageSet(language: String) async -> Void
    
    func getWord(_ word: String) -> String
}

public struct SLLocalizedObject: SLObjectProtocol {
    
    private var currentDictionary: LangDictionary
    private var service: SLLocalizingService
    public var currentLanguage: String

    public init(language: String) async {
        service = SLLocalizingService()
        currentLanguage = language
        currentDictionary = await service.setDict(language: language)
    }
    
    public mutating func changeLanguageSet(language: String) async {
        currentDictionary = await service.setDict(language: language)
        currentLanguage = language
    }
    
    public func getWord(_ word: String) -> String {
        guard let result = currentDictionary[word] else {
            return service.getError(word)
        }
        return result
    }
    
}
