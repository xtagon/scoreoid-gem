require 'spec_helper'

describe Scoreoid do
	describe 'self.configure' do
		it 'should set Scoreoid API key and game ID parameters' do
			Scoreoid.configure('API_KEY', 'GAME_ID')
			default_params = Scoreoid::APIClient.class_variable_get(:@@default_params)
			default_params.key?(:api_key).should be_true
			default_params.key?(:game_id).should be_true
			default_params[:api_key].should == 'API_KEY'
			default_params[:game_id].should == 'GAME_ID'
		end
	end
end
