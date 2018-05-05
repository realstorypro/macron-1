# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record, :component

  def initialize(context, record)
    @user = context.user
    @component = context.params[:component]
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  # TODO: Check if the scope can be deleted? I don't think we're not using it anywhere
  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
