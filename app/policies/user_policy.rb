class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end

    def destroy?
      true
    end
  end
end
