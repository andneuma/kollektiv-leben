describe MembersController do
  context 'GET #new' do
    it 'should create new empty member'
    it 'render :new template'
  end

  context 'POST #create' do
    it 'should allow creating new member if logged in'
    context 'reject' do
      it 'creating new member if not logged in'
    end
  end

  context 'GET #edit' do
    it 'should populate member in @member'
    it 'should render :edit template'
    context 'reject editing' do
      it 'if not logged in'
      it 'other groups members'
    end
  end

  context 'PATCH #update' do
    it 'should update if attributes are valid'
    context 'reject updates' do
      it 'if not logged in'
      it 'other groups members'
    end
  end

  context 'DESTROY #destroy' do
    it 'should destroy members'
    context 'reject destruction' do
      it 'if not logged in'
      it 'if member not belonging to group'
    end
  end
end
