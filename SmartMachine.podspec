Pod::Spec.new do |s|
  s.name = 'SmartMachine'
  s.module_name = 'SmartMachine'
  s.version = '0.2.1'
  s.summary = ' Smart Machine'
  s.description = 'Machine Learning Lib'
  s.homepage = 'https://github.com/sroik/smart-machine'
  s.license = { :type => 'MIT', :file => 'LICENSE', :text => 'LICENSE' }
  s.author = { 'sroik' => 'vasili.kazhanouski@gmail.com' }
  s.source = { :git => 'https://github.com/sroik/smart-machine.git', :tag => s.version.to_s }
  s.platform = :ios, '9.0'
  s.requires_arc = true
  s.swift_version = '5.0'
  s.source_files = 'SmartMachine/Sources/**/*.{h,m,swift}'
  s.frameworks = 'UIKit'
  
  s.dependency 'Surge', '~> 2.2.0'
end
