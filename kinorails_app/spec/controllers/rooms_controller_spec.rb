require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  before do
    @room = Room.create!({
      id: 0,
      name: 'Karkand',
      layout_file_path: '/home/tmp.txt',
    })

    @user_admin = User.create!({
      email: 'test@test.test',
      password: 'testtest',
      username: 'test',
      name: 'test',
      surname: 'test',
      phone_number: '111 111 111',
      role: 1})
  end

  describe 'GET #index' do
    it 'assigns @room' do
      sign_in @user_admin
      get :index
      expect(assigns(:rooms)).to eq([@room])
    end

    it 'renders the #index template' do
      sign_in @user_admin
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #new' do
    it 'renders the #new view' do
      sign_in @user_admin
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    it 'renders the #edit view' do
      sign_in @user_admin
      get :edit, params: { id: @room.id }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    it 'updates the room and redirects' do
      sign_in @user_admin
      put :update, params: { id: @room.id, room: { :name => 'Karkand NEW'} }
      expect(response).to be_redirect
    end
  end

  describe 'PUT #destroy' do
    it 'destroys room when admin' do
      sign_in @user_admin
      expect { 
        delete :destroy, params: { id: @room.id} 
      }.to change(Room, :count).by(-1)
    end

    it 'does not destroy room when not admin' do
      expect {
        delete :destroy, params: { id: @room.id}
      }.to change(Room, :count).by(0)
    end
  end

end
