describe MembersController do
  context 'GET #index' do
    it 'should populate all members in a group'
    context 'reject index' do
      it 'if not signed in'
      it 'members of another group'
    end
  end

  context 'GET #new' do
    it 'should create new empty member'
  end

  context 'POST #create' do
    it 'should allow creating new member if logged in'
    context 'reject creating new member' do
      it 'if not logged in'
      it 'in another group'
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
    context 'reject destroying member' do
      it 'if not logged in'
      it 'of another group'
    end
  end
end
