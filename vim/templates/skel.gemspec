Gem::Specification.new do |s|
  s.name                  = "@BASENAME@"
  s.summary               = "@CURSOR@"
  s.description           = File.read(File.join(File.dirname(__FILE__), "README.md"))
  s.version               = "0.0.1"
  s.author                = "@AUTHOR@"
  s.email                 = "@EMAIL@"
  s.homepage              = "http://example.com"
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.9"
  s.files                 = Dir["**/**"]
  s.executables           = [ "@BASENAME@" ]
  s.test_files            = Dir["test/test*.rb"]
  s.has_rdoc              = false
end
