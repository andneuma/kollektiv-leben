describe TodoListsController do
  let(:todo_list) { FactoryGirl.create(:todo_list) }

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

  context 'GET #show' do
    it 'assigns the proper todo list to @todo_list' do
      get :show, id: todo_list.id
      expect(assigns(:todo_list)).to eq(todo_list)
    end

    it 'renders the :show template' do
      get :show, id: todo_list.id
      expect(response).to render_template :show
    end
  end

  context 'GET #new' do
    it 'assigns a new todo list to @todo_list' do
      get :new
      expect(assigns(:todo_list)).to_not be_nil
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  context 'GET #edit' do
    it 'assigns the proper todo list to @todo_list' do
      get :edit, id: todo_list.id
      expect(assigns(:todo_list)).to eq(todo_list)
    end

    it 'renders the :edit template' do
      get :edit, id: todo_list.id
      expect(response).to render_template :edit
    end
  end

  context 'POST #create' do
    it 'creates todo list under valid attribute values' do
      expect {
        post :create, todo_list: FactoryGirl.attributes_for(:todo_list)
      }.to change(TodoList,:count).by(1)
      expect(response).to redirect_to :todo_lists
      expect(flash[:success]).to  eq('Liste erfolgreich angelegt!') 
    end

    it 'rejects creating todo list if attributes passed are invalid' do
      expect {
        post :create, todo_list: FactoryGirl.attributes_for(:todo_list, name: 'A') 
      }.to change(TodoList,:count).by(0)
      expect(response).to render_template :new
    end
  end

  context 'PATCH #update' do
    it 'updates todo list under valid attribute values' do
      patch :update, id: todo_list.id, todo_list: FactoryGirl.attributes_for(:todo_list, name: 'AnotherName') 
      expect(TodoList.find(todo_list.id).name).to eq('AnotherName')
      expect(flash[:success]).to eq('Liste erfolgreich geändert!')
    end

    it 'rejects updating todo list if attributes passed are invalid' do
      patch :update, id: todo_list.id, todo_list: FactoryGirl.attributes_for(:todo_list, name: 'A') 
      expect(TodoList.find(todo_list.id).name).to eq('TestList')
    end
  end
end
