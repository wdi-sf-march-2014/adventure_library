require 'spec_helper'

  describe Adventure do
    it 'should create a new instance of adventure if given valid parameters' do
    Adventure = Adventure.create(title: 'title', author: 'author', guid: '1234567891')
    Adventure.should be_valid
  end
end