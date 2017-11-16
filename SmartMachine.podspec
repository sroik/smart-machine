Pod::Spec.new do |s|
  s.name = 'SmartMachine'
  s.module_name = 'SmartMachine'
  s.version = '0.1'
  s.summary = 'Machine Learning :)'
  s.description = 'Machine Learning :)'
  s.homepage = 'https://github.com/sroik/smart-machine'
  s.license = { :type => 'MIT', :file => 'LICENSE', :text => 'LICENSE' }
  s.author = { 'sroik' => 'vasili.kazhanouski@gmail.com' }
  s.source = { :git => 'git@github.com:sroik/smart-machine.git', :tag => s.version.to_s }
  s.platform = :ios, '9.0'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }
  s.source_files = 'SmartMachine/Sources/**/*.{h,m,swift}'
  s.frameworks = 'UIKit'
end
