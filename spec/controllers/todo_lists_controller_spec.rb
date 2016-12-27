describe TodoListsController do
  let(:group) { create :group }
  let(:todo_list) { create :todo_list, group: group }
  let(:other_group) { create :group }
  let(:other_groups_todo_list) { create :todo_list, group: other_group }

  context 'GET #index' do
    it 'provides an array of todo lists' do
      login
      get :index, group_id: group.id
      expect(assigns(:todo_lists)).to eq([todo_list])
    end

    it 'should not list other groups todo lists' do
      login
      get :index, group_id: group.id

      expect(assigns(:todo_lists)).not_to include(other_groups_todo_list)
    end

    it 'renders the :index view' do
      login
      get :index, group_id: group.id
      expect(response).to render_template :index
    end

    context 'should reject' do
      it 'indexing anything if not signed in' do
        get :index, group_id: group.id
        expect(assigns(:todo_lists)).to be_nil
        expect(response).to redirect_to login_url
      end

      it 'indexing other groups todo lists' do
        login
        get :index, group_id: other_group.id
        expect(assigns(:todo_lists)).to be_nil
      end
    end
  end

  context 'GET #new' do
    it 'renders the :new template' do
      login
      xhr :get, :new, group_id: group.id
      expect(response).to render_template 'todo_lists/form_modal'
    end
  end

  context 'GET #edit' do
    it 'assigns the proper todo list to @todo_list' do
      login
      xhr :get, :edit, id: todo_list.id, group_id: group.id
      expect(assigns(:todo_list)).to eq(todo_list)
    end

    it 'renders the :edit template' do
      login
      xhr :get, :edit, id: todo_list.id, group_id: group.id
      expect(response).to render_template 'todo_lists/form_modal'
    end

    context 'should reject' do
      it 'editing other groups todo list' do
        login
        get :edit, id: other_groups_todo_list.id, group_id: other_group.id

        expect(flash[:danger]).to match /nicht erlaubt/
      end

      it 'editing todo list if not signed in' do
        get :edit, id: todo_list.id, group_id: group.id

        expect(assigns(:todo_list)).to be_nil
        expect(response).to redirect_to login_url
      end
    end
  end

  context 'POST #create' do
    it 'creates todo list under valid attribute values' do
      login
      expect {
        xhr :post, :create, todo_list: attributes_for(:todo_list), group_id: group.id
      }.to change(TodoList,:count).by(1)
    end

    it 'rejects creating todo list if attributes passed are invalid' do
      login
      expect {
        xhr :post, :create, todo_list: attributes_for(:todo_list, name: 'A'), group_id: group.id 
      }.to change(TodoList,:count).by(0)
    end

    context 'should reject' do
      it 'creating todo list if not logged in' do
        expect {
          xhr :post, :create, todo_list: attributes_for(:todo_list, name: 'AAA'), group_id: group.id 
        }.to change(TodoList,:count).by(0)
      end

      it 'creating todo list if attributes passed are invalid' do
        login
        expect {
          xhr :post, :create, todo_list: attributes_for(:todo_list, name: 'A'), group_id: group.id 
        }.to change(TodoList,:count).by(0)
      end

      it 'creating todo lists within other groups' do
        login
        expect {
          xhr :post, :create, todo_list: attributes_for(:todo_list, name: 'AAA'), group_id: other_group.id
        }.to change(TodoList, :count).by(0)
      end
    end
  end

  context 'PATCH #update' do
    it 'should update todo list under valid attribute values' do
      login
      xhr :patch, :update, id: todo_list.id, todo_list: attributes_for(:todo_list, name: 'AnotherName') , group_id: group.id
      expect(TodoList.find(todo_list.id).name).to eq('AnotherName')
    end

    context 'should reject update' do
      it 'if attributes passed are invalid' do
        login
        xhr :patch, :update, id: todo_list.id, todo_list: attributes_for(:todo_list, name: 'A'), group_id: group.id
        expect(TodoList.find(todo_list.id).name).to eq('TestList')
      end

      it 'if not signed in' do
        xhr :patch, :update, id: todo_list.id, todo_list: attributes_for(:todo_list, name: 'SomeChange'), group_id: group.id
        expect(TodoList.find(todo_list.id).name).to eq('TestList')
      end

      it 'of other groups' do
        login
        xhr :patch, :update, id: other_groups_todo_list.id, todo_list: attributes_for(:todo_list, name: 'AnotherName'), group_id: other_group
        expect(TodoList.find(other_groups_todo_list.id).name).not_to eq('AnotherName')
      end
    end
  end

  context 'GET #destroy' do
    it 'should be possible to destroy todo lists' do
      login
      xhr :get, :destroy, id: todo_list.id, group_id: group.id
      expect(TodoList.all).not_to include(todo_list)
    end

    context 'reject destroy' do
      it 'if not signed in' do
        xhr :get, :destroy, id: todo_list.id, group_id: group.id
        expect(TodoList.all).to include(todo_list)
      end

      it 'other groups todo lists' do
        login
        xhr :get, :destroy, id: other_groups_todo_list.id, group_id: other_group.id
        expect(TodoList.all).to include(todo_list)
      end
    end
  end
end
