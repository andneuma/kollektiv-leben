describe GroupsController do
  let(:group) { create :group }

  context 'GET #new' do
    it 'should provide registration' do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end

    it 'should render :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  context 'POST #create' do
    it 'should allow creating new group if registration token is valid' do
      create_list :group, 2
      token = Group.first.registration_tokens.first

      expect {
        post :create, group: { name: "test", email: "test@test.com", password: "secret", password_confirmation: "secret" } , registration_token: token
      }.to change(Group, :count).from(2).to(3)
      expect(flash[:success]).to eq('Gruppe erfolgreich angelegt, ihr könnt euch nun einloggen!')
      expect(response).to redirect_to login_url
    end

    it 'should not set login status for newly created groups'

    it 'should not allow creating new group if registration token is not valid' do
      expect {
        post :create, group: attributes_for(:group), registration_token: 'SomeWrongToken'
      }.to change(Group, :count).by(0)
    end

    it 'should delete registration token from respective groups registration tokens stash' do
      groups = create_list :group, 3
      post :create, group: attributes_for(:group), registration_token: groups.first.registration_tokens.first 
      groups.first.reload
      expect(groups.first.registration_tokens.count).to eq(1)
    end
  end

  context 'GET #edit' do
    it 'should assign the proper group in @group' do
      session[:group_id] = group.id
      get :edit, id: group.id
      expect(assigns(:group)).to eq(group)
    end

    it 'should render the proper :edit template' do
      session[:group_id] = group.id
      get :edit, id: group.id
      expect(response).to render_template :edit
    end

    context 'reject editing' do
      it 'and redirect to root if not logged in' do
        get :edit, id: group.id
        expect(response).to redirect_to login_url
      end

      it 'if trying to edit attributes of different group' do
        session[:group_id] = group.id
        other_group = create(:group)
        get :edit, id: other_group.id
        expect(response).to redirect_to root_url
      end
    end
  end

  context 'PATCH #update' do
    it 'should update if attributes are valid' do
      session[:group_id] = group.id
      patch :update, id: group.id, group: { name: 'SomeOtherName' }

      group.reload
      expect(group.name).to eq('SomeOtherName')
      expect(response).to redirect_to edit_group_url(group)
    end

    context 'reject updates' do
      it 'if not logged in' do
        patch :update, id: group.id, group: { name: 'SomeOtherName' }
        expect(response).to redirect_to login_url
        expect(group.name).to_not eq('SomeOtherName')
      end

      it 'if values not valid' do
        session[:group_id] = group.id
        patch :update, id: group.id, group: { name: 'AA' }
        expect(response).to render_template :edit
        expect(flash[:danger]).to_not be_nil
      end

      it 'if trying to update attributes of different group' do
        session[:group_id] = group.id
        other_group = create(:group)
        patch :update, id: other_group.id, group: { name: 'SomeOtherName' }
        expect(response).to redirect_to root_url
        expect(other_group.name).to_not eq('SomeOtherName')
      end
    end
  end

  context 'DESTROY #destroy' do
    it 'should destroy group' do
      session[:group_id] = group.id
      delete :destroy, id: group.id
      expect(Group.count).to eq(0)
    end

    it 'should not destroy other groups' do
      other_group = create(:group)
      session[:group_id] = group.id
      delete :destroy, id: other_group.id
      expect(response).to redirect_to root_url
    end
  end
end
