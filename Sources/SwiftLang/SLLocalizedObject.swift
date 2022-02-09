import Foundation

/**
 Protocol describing the interface SLLocalizedObject
 */
public protocol SLObjectProtocol{
    
    typealias LangDictionary = [String:String]
    
    var currentLanguage: String { get }
    
    mutating func changeLanguageSet(language: String) -> Void
    
    func getWord(_ word: String) -> String
}

/**
 Gets translated strings from a table and changes the current dictionary to another one.
 */
public struct SLLocalizedObject: SLObjectProtocol {
    
    private var currentDictionary: LangDictionary
    private var urlPathToDictionary: URL
    private var service: SLLocalizingService
    
    /**
     String representing the current dictionary
     */
    public var currentLanguage: String

    /**
     Initializes an SLLocalizedObject with the given dictionary and URL file path.
        - returns:
        SLLocalizedObject()
        - parameters:
            - language:The name of the dictionary defined in the JSON file
            - urlPathToDictionary:Path to JSON file
     */
    public init(language: String, urlPathToDictionary: URL) {
        service = SLLocalizingService()
        currentLanguage = language
        self.urlPathToDictionary = urlPathToDictionary
        currentDictionary = service.setDict(language: language, urlPath: urlPathToDictionary)
    }
    
    /**
     Switches the language set in the dictionary.
        - parameters:
            - language:The name of the dictionary defined in the JSON file.
     */
    public mutating func changeLanguageSet(language: String) {
        currentDictionary = service.setDict(language: language, urlPath: urlPathToDictionary)
        currentLanguage = language
    }
    
    /**
     Returns localized string.
        - returns:
        Localized string defined in dictionary
        - parameters:
            - _ word:The name of the dictionary defined in the JSON file.
     */
    public func getWord(_ word: String) -> String {
        guard let result = currentDictionary[word] else {
            return service.getError(word)
        }
        return result
    }
    
}
