module Contacts
  class FindByIdInUsersScope < ::FindByIdInUsersScope
    def initialize(user, id, repository = ContactRepository.new)
      super
    end
  end
end