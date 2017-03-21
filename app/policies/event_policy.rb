class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    user.admin?
  end

  def create?
    user.admin?
  end
end
