require 'spec_helper'

describe Scoreoid do
	describe '.configure' do
		it 'should set default API parameters' do
			default_params = {api_key: 'API_KEY', game_id: 'GAME_ID'}
			Scoreoid::API.should_receive(:default_params=).and_return(default_params)
			returned_default_params = Scoreoid.configure(default_params)
			returned_default_params.should == default_params
		end
	end
end
