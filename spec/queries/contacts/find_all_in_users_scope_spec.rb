require 'rails_helper'

RSpec.describe Contacts::FindAllInUsersScope, type: :model do
  let!(:user) { UserRepository.new.create!({ email: "user1@example.com", password: '123456789' }) }
  let!(:user2) { UserRepository.new.create!({ email: "user2@example.com", password: '123456789' }) }
  let!(:user3) { UserRepository.new.create!({ email: "user3@example.com", password: '123456789' }) }
  let!(:user1_contact1) { ContactRepository.new.create!( {user_id: user.id}) }
  let!(:user1_contact2) { ContactRepository.new.create!( {user_id: user.id}) }
  let!(:user2_contact2) { ContactRepository.new.create!( {user_id: user2.id}) }
  let(:query) { Contacts::FindAllInUsersScope.new(user) }
  let(:empty_query) { Contacts::FindAllInUsersScope.new(user3) }

  it 'returns contact if correct id is passed' do
    expect(query.execute).not_to be_empty
  end

  it 'returns all contacts of given user' do
    obtained_contacts = query.execute
    expect(obtained_contacts.map(&:id)).to match_array([user1_contact1.id, user1_contact2.id])
  end

  it 'does not returns other users contacts' do
    obtained_contacts = query.execute
    expect(obtained_contacts.map(&:id)).not_to include(user2_contact2.id)
  end

  it 'returns empty array if user has no contacts' do
    expect(empty_query.execute).to be_empty
  end
end