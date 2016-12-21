describe SessionsController do
  let(:group) { create(:group) }

  it 'should provide login' do
    get :new
    expect(response).to render_template :new
  end

  it 'should login with valid credentials' do
    post :create, sessions: { name: group.name, password: 'secret' }
    expect(response).to redirect_to root_url
    expect(session).not_to be_nil
    expect(flash[:success]).to eq('Herzlich willkommen!')
  end

  it 'should reject login without valid credentials' do
    post :create, sessions: { name: 'SomeWrongName', password: 'SomeWrongPassword' }
    expect(response).to render_template :new
    expect(session[:group_id]).to be_nil
    expect(flash[:danger]).to eq('Username oder Passwort falsch!')
  end

  it 'should set sessions hash nil on logout' do
    post :create, sessions: { name: group.name, password: 'secret' }
    get :destroy, id: session[:id]
    expect(session[:group_id]).to be_nil
    expect(flash[:success]).to eq('Tschüssikowski!')
  end
end
