# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  before do
    @user = build(:user)
  end

  describe 'New user registration' do
    context 'When new registration is successful' do
      it 'name and email, password and password_Being able to register if confirmation exists' do
        expect(@user).to be_valid
      end
      it 'You can register if your password is 8 characters or more' do
        expect(@user).to be_valid
      end
    end

    context 'When new registration does not go well' do
      it 'Cannot register if name is empty' do
        @user.name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it 'Cannot register if email is empty' do
        @user.email = nil
        @user.valid?

        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'Cannot register if there are duplicate emails' do
        @user.save
        another_user = build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'Cannot register if password is empty' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'password even if password exists_Confirmation cannot be registered if it is empty' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'Cannot register if password is 5 characters or less' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 8 characters)')
      end
      it 'Cannot register if password is no lowercase character' do
        @user.password = 'A!2345678'
        @user.password_confirmation = 'A!2345678'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password  must contain at least one lowercase letter')
      end
      it 'Cannot register if password is no upper character' do
        @user.password = 'a!2345678'
        @user.password_confirmation = 'a!2345678'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password  must contain at least one uppercase letter')
      end
      it 'Cannot register if password is no digit character' do
        @user.password = 'A!asdasdas'
        @user.password_confirmation = 'A!asdasdas'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password  must contain at least one digit')
      end
      it 'Cannot register if password is no digit character' do
        @user.password = 'A2asdasdas'
        @user.password_confirmation = 'A2asdasdas'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password  must contain at least one special character')
      end
    end
  end
end
