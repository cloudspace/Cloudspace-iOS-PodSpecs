Pod::Spec.new do |s|
  s.name         = 'CSShortcuts'
  s.version      = '0.0.1'
  s.summary      = 'Common shortcut to ease development'
  s.homepage     = 'https://github.com/cloudspace/Cloudspace-iOS'
  s.license = {
    :type => 'Custom',
    :text => <<-LICENSE
      Copyright (c) 2013, Cloudspace

      All rights reserved.

      Redistribution and use in source and binary forms requires explicit permission.

    LICENSE
  }
  s.author       = { 'Joseph Lorich' => 'joey@cloudspace.com' }
  s.source       = { :git => 'https://github.com/cloudspace/Cloudspace-iOS.git' }
  s.platform     = :ios, '5.1'
  s.source_files = 'Library/CSShortcuts/*.{h,m}'
  s.requires_arc = true
end
