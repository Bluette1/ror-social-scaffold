require 'rails_helper'

RSpec.describe 'Friendship Requests', type: :request do
  let(:mary) do
    {
      name: 'mary', email: 'mary@web.com', password: 'password', password_confirmation: 'password'
    }
  end
  let(:jane) do
    {
      name: 'jane', email: 'jane@web.com', password: 'password', password_confirmation: 'password'
    }
  end

  describe 'a user should be able to access friendship routes' do
    before :each do
      post '/users', params: { user: mary }
    end

    it 'should be able to send a friend request to another user' do
      receiver = User.create(jane)
      post "/users/#{receiver.id}/friendship_requests"

      expect(response).to redirect_to user_path(receiver.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
    end

    it 'should be able to accept a friend request from another user' do
      receiver = User.find_by(email: mary[:email])
      sender = User.create(jane)

      sent_request = FriendRequest.create(sender: sender, receiver: receiver)
      patch "/users/#{sender.id}/friendship_requests/#{sent_request.id}"

      expect(response).to redirect_to user_path(sender.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      expect(flash[:notice]).to eq "You are now friends with #{sender.name}"
      expect(Friendship.find_by(friend: sender, inverse_friend: receiver)).not_to eq nil
      expect(Friendship.find_by(friend: receiver, inverse_friend: sender)).not_to eq nil
    end

    it 'should be able to reject a friend request from another user' do
      receiver = User.find_by(email: mary[:email])
      sender = User.create(jane)

      sent_request = FriendRequest.create(sender: sender, receiver: receiver)
      delete "/users/#{sender.id}/friendship_requests/#{sent_request.id}"

      expect(response).to redirect_to user_path(sender.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
    end
  end

  describe 'failure scenarios on the friendship routes' do
    before :each do
      post '/users', params: { user: jane }
    end

    it 'should not be able to send multiple friend requests to another user' do
      sender = User.find_by(email: jane[:email])
      receiver = User.create(mary)

      FriendRequest.create(sender: sender, receiver: receiver)

      post "/users/#{receiver.id}/friendship_requests"

      expect(response).to redirect_to user_path(receiver.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      flash_messge = 'An error occurred while trying to request the friendship ["Sent requests is invalid"]'
      expect(flash[:alert]).to eq flash_messge
    end

    it 'fails to accept a friend request and sets the correct flash notice' do
      receiver = User.find_by(email: jane[:email])
      sender = User.create(mary)

      sent_request = FriendRequest.create(sender: sender, receiver: receiver)
      patch "/users/#{receiver.id}/friendship_requests/#{sent_request.id}"

      expect(response).to redirect_to user_path(receiver.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      flash_messge = 'An error occurred while trying to save the friendship ["Friend has already been taken"]'
      expect(flash[:alert]).to eq flash_messge
      expect(Friendship.find_by(friend: sender, inverse_friend: receiver)).to eq nil
      expect(Friendship.find_by(friend: receiver, inverse_friend: sender)).to eq nil
    end
  end
end