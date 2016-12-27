feature 'Todo list index', :js do
  let(:group) { create :group }
  let(:todo_list) { create :todo_list, group: group }

  scenario 'shows todo lists' do
    skip
    visit todo_lists_url(group)
    expect(page).to have_content('TestList')
  end

  scenario 'can create new todo list and shows it without redirect' do
    skip
    save_new_list
    expect(page).to_not have_content('Speichern')
    expect(page).to have_content('NewTodoList')
    expand_new_list
    expect(page).to have_content('NewTodoList description')
  end

  scenario 'can create new todo item and shows it without redirect' do
    skip
    expand_list
    save_new_item
    expect(page).to_not have_content('Speichern')
    expect(page).to have_content('NewTodoItem')
  end

  private

  def save_new_list
    click_on 'New todo list'
    sleep(0.1)
    fill_in('Name', with: 'NewTodoList')
    fill_in('Description', with: 'NewTodoList description')
    click_on 'Save'
    sleep(0.1)
  end

  def expand_new_list
    find('.todo-list-name', text: 'NewTodoList').trigger('click')
    sleep(1)
  end

  def save_new_item
    click_on 'New item'
    sleep(0.1)
    fill_in('Name', with: 'NewTodoItem')
    fill_in('Description', with: 'NewTodoItem description')
    fill_in('Start', with: '2015-01-01')
    fill_in('End', with: '2016-01-01')
    click_on 'Save'
    sleep(0.1)
  end

  def expand_list
    find('.todo-list-name', text: 'TestList').trigger('click')
    sleep(1)
  end
end
