describe TodoItemsController do
  let(:todo_list) { create :todo_list }
  let(:todo_items) { create_list :todo_item, 5, todo_list: todo_list }

  context 'GET #index' do
    it 'should return an array of todoitems within respective todolist' do
      get :index, todo_list_id: todo_list.id
      expect(assigns(:todo_items)).to eq(todo_items)
    end

    it 'should not return todos of other todo lists' do
      other_todo_list = create :todo_list
      other_todo_item = create :todo_item, todo_list: other_todo_list

      get :index, todo_list_id: todo_list.id
      expect(assigns(:todo_items)).to_not include(other_todo_item)
    end

    it 'should render the :index template' do
      get :index, todo_list_id: todo_list.id
      expect(response).to render_template :index
    end
  end

  context 'GET #show' do
    it 'should initiate the proper todo_item in @todo_item' do
      get :show, todo_list_id: todo_list.id, id: todo_items.first.id
      expect(assigns(:todo_item)).to eq(todo_items.first)
    end

    it 'should render the proper :show template' do
      get :show, todo_list_id: todo_list.id, id: todo_items.first.id
      expect(response).to render_template :show
    end
  end

  context 'GET #new' do
    it 'should instantiate a new todo item in @todo_item' do
      get :new, todo_list_id: todo_list.id
      expect(assigns(:todo_item)).to_not be_nil 
    end

    it 'should render the proper :new template' do
      get :new, todo_list_id: todo_list.id
      expect(response).to render_template :new
    end
  end

  context 'POST #create' do
    it 'should create a todo item if attributes are valid and redirect to todo list' do
      expect {
        post :create, todo_list_id: todo_list.id, todo_item: attributes_for(:todo_item)
      }.to change(TodoItem, :count).by(1)
      expect(flash[:success]).to eq('Neue Aufgabe erfolgreich angelegt!')
      expect(response).to redirect_to todo_list_url(todo_list)
    end

    it 'should reject a todo item if attributes are invalid and render :new template' do
      expect {
        post :create, todo_list_id: todo_list.id, todo_item: { name: "AA", password: "secret", password_confirmation: "secret" }
      }.to change(TodoItem, :count).by(0)
      expect(flash[:danger]).to_not be nil
      expect(response).to render_template :new
    end
  end

  context 'GET #edit' do
    it 'should initiate the proper todo_item in @todo_item' do
      get :edit, todo_list_id: todo_list.id, id: todo_items.first.id
      expect(assigns(:todo_item)).to eq(todo_items.first)
    end

    it 'should render the proper :edit template' do
      get :edit, todo_list_id: todo_list.id, id: todo_items.first.id
      expect(response).to render_template :edit
    end
  end

  context 'PATCH #update' do
    it 'should accept updates for correct values passed' do
      patch :update, todo_list_id: todo_list.id, id: todo_items.first.id, todo_item: { name: 'SomeChange' } 

      expect(todo_items.first.reload.name).to eq('SomeChange')
      expect(flash[:success]).to eq('Änderungen erfolgreich übernommen!')
      expect(response).to redirect_to todo_list_url(todo_list)
    end

    it 'should reject update if values passed are incorrect and render :edit template' do
      patch :update, todo_list_id: todo_list.id, todo_item: { name: "AA" }, id: todo_items.first.id
      expect(flash[:danger]).to_not be nil
      expect(response).to render_template :edit
    end
  end

  context 'GET #destroy' do
    it 'should be possible to destroy todo items' do
      get :destroy, todo_list_id: todo_list.id, id: todo_items.first.id
      expect(TodoItem.all).not_to include(todo_items.first)
      expect(flash[:warning]).to eq('Aufgabe gelöscht!')
      expect(response).to redirect_to todo_list_url(todo_list)
    end
  end
end
