require 'spec_helper'

describe Scoreoid do
	it 'has a valid version constant' do
		# This regex is far from perfect, but it should keep me from accidentally
		# doing something stupid to the version.
		Scoreoid::VERSION.should =~ /\A\d+\.\d+\.\d+(\.\w+)?\Z/
	end
end
