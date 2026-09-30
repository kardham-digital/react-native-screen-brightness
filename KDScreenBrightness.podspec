require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "KDScreenBrightness"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.license      = package["license"]
  s.author       = package["author"]
  s.homepage     = package["homepage"]
  s.platforms    = { :ios => min_ios_version_supported }
  s.source       = { :path => "." }
  s.source_files = "ios/**/*.{h,m,mm}"

  install_modules_dependencies(s)
end
