import XCTest
@testable import MoviesApp

class HomeViewControllerTests: XCTestCase {
    
    var sut: HomeViewController!
    
    override func setUp() {
        super.setUp()
        sut = HomeViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testHasInternetConnection() {
        let hasInternet = sut.viewModel.connectivityChecker.hasInternetConnection()
        XCTAssertTrue(hasInternet)
    }
    
    func testFetchDataWithoutInternetConnection() {
        sut.viewModel.connectivityChecker = MockConnectivityChecker()
        
        sut.fetchData()
        
        XCTAssertTrue(sut.viewModel.showData.isEmpty, "La lista de datos debería estar vacía sin conexión")
    }
}

class MockConnectivityChecker: ConnectivityChecker {
    func hasInternetConnection() -> Bool {
        return false
    }
}
