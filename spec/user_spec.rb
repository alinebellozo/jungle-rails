require 'rails_helper'

RSpec.describe User, type: :nodel do

  describe 'Validations' do
  
    it 'saves user when required fields are set correctly' do
      @user = User.new(first_name: 'Robert', last_name: 'Downey', email: 'example@email.com', password: "example123", password_confirmation: "example123")
      expect(@user).to be_valid
    end

    it 'shows an error message if first name is not set' do
      @user = User.new(first_name: nil, last_name: 'Downey', email: 'example@email.com', password: "example123", password_confirmation: "example123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'shows an error message if last name is not set' do
      @user = User.new(first_name: 'Robert', last_name: nil, email: 'example@email.com', password: "example123", password_confirmation: "example123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'shows an error message if email is not set' do
      @user = User.new(first_name: 'Robert', last_name: 'Downey', email: nil, password: "example123", password_confirmation: "example123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end


    it 'shows an error message if password is not set' do
      @user = User.new(first_name: 'Robert', last_name: 'Downey', email: 'example@email.com', password: nil, password_confirmation: nil)
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'fails to save if password and password_confirmation do not match' do
      @user = User.new(first_name: 'Robert', last_name: 'Downey', email: 'example@email.com', password: "example123", password_confirmation: "123example")
      expect(@user.errors.full_messages).to include("The passwords don't match")
    end

    it 'password should have a minimun length' do
      @user = User.new(first_name: 'Robert', last_name: 'Downey', email: 'example@email.com', password: "example", password_confirmation: "example")
      expect(@user.errors.full_messages).to include("The password is too short, the minimum is 8 characters")
    end
  
  end

  describe '.authenticate_with_credentials' do

      it 'returns user if authenticated succesfully' do
      @user = User.new(first_name: 'Robert', last_name: 'Downey', email: 'example@email.com', password: "example123", password_confirmation: "example123")
      @user_logged_in = User.authenticate_with_credentials('example@email.com', "example123")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'authenticates user if email has extra spaces' do
      @user = User.new(first_name: 'Robert', last_name: 'Downey', email: ' example@email.com ', password: "example123", password_confirmation: "example123")
      @user_logged_in = User.authenticate_with_credentials(' example@email.com', "example123")
      expect(@user_logged_in).to_not eq(nil)
    end

    it 'authenticates user if email has the wrong case' do
      @user = User.new(first_name: 'Robert', last_name: 'Downey', email: 'example@email.com', password: "example123", password_confirmation: "example123")
      @user_logged_in = User.authenticate_with_credentials('eXAMPLE@eMAiL.com', "example123")
      expect(@user_logged_in).to_not eq(nil)
    end
  
  end

end

