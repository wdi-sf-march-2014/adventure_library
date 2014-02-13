require 'spec_helper'

describe '/adventures' do
	describe 'GET with JSON' do
    before do
      get '/adventures.json'
    end

    it 'returns a list of all the adventures made locally' do

    end
    it 'does not return adventures made on another server'
  end

  describe 'GET with HTML' do
    before do
      get '/adventures'
    end
    it 'returns all adventures'
    it 'returns adventures made on another server'    
  end

  describe 'POST' do
    it 'adds a locally made adventure'
  end
end

describe '/servers' do
    describe 'GET' do

    end
end