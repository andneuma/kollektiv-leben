describe TodoListsController do
  let(:todo_list) { create :todo_list }

  context 'GET #index' do
    it 'provides an array of todo lists' do
      get :index
      expect(assigns(:todo_lists)).to eq([todo_list])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to render_template :index
    end
  end

  context 'GET #new' do
    it 'assigns a new todo list to @todo_list' do
      xhr :get, :new
      expect(assigns(:todo_list)).to_not be_nil
    end

    it 'renders the :new template' do
      xhr :get, :new
      expect(response).to render_template 'todo_lists/form_modal'
    end
  end

  context 'GET #edit' do
    it 'assigns the proper todo list to @todo_list' do
      xhr :get, :edit, id: todo_list.id
      expect(assigns(:todo_list)).to eq(todo_list)
    end

    it 'renders the :edit template' do
      xhr :get, :edit, id: todo_list.id
      expect(response).to render_template 'todo_lists/form_modal'
    end
  end

  context 'POST #create' do
    it 'creates todo list under valid attribute values' do
      expect {
        xhr :post, :create, todo_list: FactoryGirl.attributes_for(:todo_list)
      }.to change(TodoList,:count).by(1)
    end

    it 'rejects creating todo list if attributes passed are invalid' do
      expect {
        xhr :post, :create, todo_list: FactoryGirl.attributes_for(:todo_list, name: 'A') 
      }.to change(TodoList,:count).by(0)
    end
  end

  context 'PATCH #update' do
    it 'updates todo list under valid attribute values' do
      xhr :patch, :update, id: todo_list.id, todo_list: FactoryGirl.attributes_for(:todo_list, name: 'AnotherName') 
      expect(TodoList.find(todo_list.id).name).to eq('AnotherName')
    end

    it 'rejects updating todo list if attributes passed are invalid' do
      xhr :patch, :update, id: todo_list.id, todo_list: FactoryGirl.attributes_for(:todo_list, name: 'A') 
      expect(TodoList.find(todo_list.id).name).to eq('TestList')
    end
  end

  context 'GET #destroy' do
    it 'should be possible to destroy todo lists' do
      xhr :get, :destroy, id: todo_list.id
      expect(TodoList.all).not_to include(todo_list)
    end
  end
end
