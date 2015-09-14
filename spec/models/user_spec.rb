require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user1) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user)}
  let(:user3) {FactoryGirl.create(:user)}

  context "Factory" do
    it "should validate all the user factories" do
      expect(FactoryGirl.build(:user).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_presence_of :name }
    it { should allow_value('Krishnaprasad Varma').for(:name )}
    it { should_not allow_value('KP').for(:name )}
    it { should_not allow_value("x"*257).for(:name )}

    it { should validate_presence_of :password }
    it { should allow_value('Password@1').for(:password )}
    it { should_not allow_value('password').for(:password )}
    it { should_not allow_value('password1').for(:password )}
    it { should_not allow_value('password@1').for(:password )}
    it { should_not allow_value('ED').for(:password )}
    it { should_not allow_value("a"*257).for(:password )}
  end

  context "Instance Methods" do
    it "token_expired?" do
      token_created_at = Time.now - 30.minute
      u = FactoryGirl.build(:user, token_created_at: token_created_at)
      expect(u.token_expired?).to be_truthy

      token_created_at = Time.now - 29.minute
      u = FactoryGirl.build(:user, token_created_at: token_created_at)
      expect(u.token_expired?).to be_falsy
    end
  end

end