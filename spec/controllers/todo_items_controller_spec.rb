describe TodoItemsController do
  let(:todo_list) { create :todo_list }
  let(:todo_items) { create_list :todo_item, 5, todo_list: todo_list }

  context 'GET #new' do
    it 'should instantiate a new todo item in @todo_item' do
      xhr :get, :new, todo_list_id: todo_list.id
      expect(assigns(:todo_item)).to_not be_nil 
    end

    it 'should render the proper :new template' do
      xhr :get, :new, todo_list_id: todo_list.id
      expect(response).to render_template 'todo_items/form_modal'
    end
  end

  context 'POST #create' do
    it 'should create a todo item if attributes are valid and redirect to todo list' do
      expect {
        xhr :post, :create, todo_list_id: todo_list.id, todo_item: attributes_for(:todo_item)
      }.to change(TodoItem, :count).by(1)
    end

    it 'should reject a todo item if attributes are invalid' do
      expect {
        post :create, todo_list_id: todo_list.id, todo_item: { name: "AA", password: "secret", password_confirmation: "secret" }
      }.to change(TodoItem, :count).by(0)
    end
  end

  context 'GET #edit' do
    it 'should initiate the proper todo_item in @todo_item' do
      xhr :get, :edit, todo_list_id: todo_list.id, id: todo_items.first.id
      expect(assigns(:todo_item)).to eq(todo_items.first)
    end

    it 'should render the proper :edit template' do
      xhr :get, :edit, todo_list_id: todo_list.id, id: todo_items.first.id
      expect(response).to render_template 'todo_items/form_modal'
    end
  end

  context 'PATCH #update' do
    it 'should accept updates for correct values passed' do
      xhr :patch, :update, todo_list_id: todo_list.id, id: todo_items.first.id, todo_item: { name: 'SomeChange' } 
      expect(todo_items.first.reload.name).to eq('SomeChange')
    end

    it 'should reject update if values passed are incorrect and render :edit template' do
      xhr :patch, :update, todo_list_id: todo_list.id, todo_item: { name: "AA" }, id: todo_items.first.id
      expect(todo_items.first.reload.name).to_not eq('SomeChange')
    end
  end

  context 'GET #destroy' do
    it 'should be possible to destroy todo items' do
      xhr :get, :destroy, todo_list_id: todo_list.id, id: todo_items.first.id
      expect(TodoItem.all).not_to include(todo_items.first)
    end
  end
end
