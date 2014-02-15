require 'spec_helper'

describe Adventure do
  describe 'creation' do
    it 'has a guid' do
      a = Adventure.create!(:author => "Test author",
                      :title => "Great time")
      a.guid.should_not == nil
    end
    it 'does not override a guid' do
      guid = SecureRandom.urlsafe_base64(10)
      a = Adventure.create!(:author => "Test author",
                      :title => "Great time",
                      :guid => guid)
      a.guid.should == guid
    end
  end
end
