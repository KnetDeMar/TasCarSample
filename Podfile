platform :ios, '11.0'

# ignore all warnings from all pods
inhibit_all_warnings!
use_frameworks!

# Common Pods for every OnionArchitecture target
def TasCarPods
  pod 'Kingfisher'                # https://github.com/onevcat/Kingfisher
  pod 'Moya'                      # https://github.com/Moya/Moya
  pod 'RxSwift'                   # https://github.com/ReactiveX/RxSwift
  pod 'Action'                    # https://github.com/RxSwiftCommunity/Action
  pod 'CocoaLumberjack/Swift'
  pod 'SwiftLint'                 # https://github.com/realm/SwiftLint
  pod 'DynamicColor'              # https://github.com/yannickl/DynamicColor
  pod 'RxRealm'                   # https://github.com/RxRealm
  pod 'LicensePlist'              # https://github.com/mono0926/LicensePlist
end

target 'TasCarSample' do
  
  #Pods for TasCar
  TasCarPods()
  
  #Pods for TasCarTests
  target 'TasCarTests' do
    pod 'RxBlocking'
    pod 'RxTest'
    pod 'RxSwift'
  end

  #Pods for TasCarUITests
  target 'TasCarUITests' do
    
  end

end
