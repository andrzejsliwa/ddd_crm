module Api::V1
  class ContactsController < BaseController
    def index
      user = current_user_entity
      query = Contacts::FindAllInUsersScope.new(user)
      render json: query.execute, each_serializer: ContactSerializer, root: 'contacts'
    end

    def show
      user = current_user_entity
      contact_id = params[:id]
      query = Contacts::FindByIdInUsersScope.new(user, contact_id)
      render json: query.execute, serializer: ContactSerializer
    end

    def create
      user = current_user_entity
      action = Contacts::Add.new(user, params)
      action.execute
      if action.errors.empty?
        render json: action.result, serializer: ContactSerializer
      else
        render json: action.errors, status: 422
      end
    end

    def update
      user = current_user_entity
      action = Contacts::Update.new(user, params[:id], params)
      action.execute
      if action.errors.empty?
        render json: :ok
      else
        render json: action.errors, status: 422
      end
    end

    def destroy
      user = current_user_entity
      action = Contacts::Remove.new(user, params[:id])
      action.execute
      render json: :ok
    end
  end
end