class ApplicationPolicy
  attr_reader :user, :record

  def initialize user, record
    @user = user
    @record = record
  end

  def manage?
    @record.user == @user
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end
end
