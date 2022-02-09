import XCTest
@testable import SwiftLang

struct LangDictionaries: Codable{
    typealias LangDictionary = Dictionary<String, String>
    var testDict1: LangDictionary
    var testDict2: LangDictionary
}

final class SwiftLangTests: XCTestCase {
    func testSwiftLangModule() throws {
        
        //Copy the URL of the Dictionaries.json file:
        guard let pathAsURL = Bundle.module.url(forResource: "Dictionaries", withExtension: "json") else {return XCTestCase.tearDown()}
        
        //Testing:
        var locale = SLLocalizedObject(language: "testDict1", urlPathToDictionary: pathAsURL)
        XCTAssertEqual("testDict1", locale.currentLanguage)
        XCTAssertEqual("translatedWord1(testDict1)", locale.getWord("serviceWord1"))
        XCTAssertEqual("translatedWord2(testDict1)", locale.getWord("serviceWord2"))

        locale.changeLanguageSet(language: "testDict2")
        XCTAssertEqual("testDict2", locale.currentLanguage)
        XCTAssertEqual("translatedWord1(testDict2)", locale.getWord("serviceWord1"))
        XCTAssertEqual("translatedWord2(testDict2)", locale.getWord("serviceWord2"))
        
        //Testing error handling:
        XCTAssertEqual("LOCALE_ERROR", locale.getWord("serviceWord3"))
    }
}
