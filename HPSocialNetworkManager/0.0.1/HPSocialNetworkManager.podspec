Pod::Spec.new do |s|
  s.name         = "HPSocialNetworkManager"
  s.version      = "0.0.1"
  s.summary      = "iOS framework for authenticating with Facebook and Twitter, with reverse-auth support"
  s.homepage     = "https://github.com/Hipo/HPSocialNetworkManager"

  s.license      = 'MIT (example)'
  s.authors      = { "Taylan Pince" => "taylan@hipo.biz", "Sarp Erdag" => "sarp.erdag@gmail.com" }
  s.source         = { :git => "https://github.com/jlorich/HPSocialNetworkManager.git" }
  s.platform     = :ios, '5.0'
  s.source_files = 'Classes/**/*.{h,m}', 'Dependencies/HPAccountManager/*.{h,m}', 'Dependencies/TWAPIManager/*.{h,m}', 'Dependencies/ABOAuthCore/*.{h,m}'

  s.frameworks = 'Twitter', 'Social', 'AdSupport', 'Accounts'

  s.library     = 'sqlite3.0'
  #s.requires_arc = true
  # s.xcconfig = { 'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2' }
  s.dependency 'Facebook-iOS-SDK', '~> 3.2.1'
end
