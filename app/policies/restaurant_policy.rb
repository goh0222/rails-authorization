class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all # If users can see all restaurants
    #   # scope.where(user: user) # If users can only see their restaurants
    #   # scope.where("name LIKE 't%'") # If users can only see restaurants starting with `t`
    # end

    def resolve
      user.admin? ? scope.all : scope.where(user: user)
    end

    # If it doesn’t exist, it falls back to ApplicationPolicy#show? by inheritance.
    def show?
      true
    end

    # new? returns create? in ApplicationPolicy
    def create?
      true
    end

    # edit? returns update? in ApplicationPolicy
    def update?
      record.user == user
      # record: the restaurant passed to the `authorize` method in controller
      # user: the `current_user` signed in with Devise
    end

    def destroy?
      record.user == user
    end
  end
end
