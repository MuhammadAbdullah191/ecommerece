class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    if @user
      true
    else
      false
    end
  end

  def edit?
    if @user
      @user.id == @record.user_id
    else
      false
    end
  end

  def destroy?
    if @user
      @user.id == @record.user_id
    else
      false
    end
  end
end
