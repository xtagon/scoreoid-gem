lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'scoreoid/version'

Gem::Specification.new do |gem|
	gem.name = 'scoreoid'
	gem.version = Scoreoid::VERSION
	gem.author = 'Justin Workman'
	gem.email = 'xtagon@gmail.com'
	gem.summary = 'Scoreoid Ruby is a wrapper for the Scoreoid API.'
	gem.license = 'MIT'

	gem.required_ruby_version = '1.9.2'
	gem.add_runtime_dependency 'chronic', '~> 0.8.0'
	gem.add_runtime_dependency 'multi_json', '~> 1.3'
	gem.add_runtime_dependency 'rest-client', '~> 1.6'

	gem.files = `git ls-files`.split($/)
	gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
	gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
	gem.require_paths = ['lib']
end
