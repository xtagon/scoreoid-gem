require 'spec_helper'

describe Scoreoid do
	it 'has a valid version constant' do
		Scoreoid::VERSION.should =~ /\A\d+\.\d+\.\d+\Z/
	end
end
