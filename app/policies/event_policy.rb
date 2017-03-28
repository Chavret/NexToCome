class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    user.admin?
  end

  def create?
    user.admin?
  end

  def admin?
    user.admin?
  end

  def sync_calendar?
    true # FIXME
  end
end
