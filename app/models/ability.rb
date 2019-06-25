class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Event, published: true
    can :manage, User, id: user.id
    can :read, Startup

    if user.member?
      can :read, Startup
      can :create, Startup
      can :manage, Startup, author_id: user.id

      can :create, Event
      can :read, Event, organizer_id: user.id
      can :update, Event, organizer_id: user.id
      can :destroy, Event, organizer_id: user.id
      cannot :publish, Event

      can :create, EventParticipation
      can :destroy, EventParticipation, user_id: user.id
    end

    if user.admin?
      can :manage, Startup
      can :manage, Event
      can :publish, Event
      can :manage, EventParticipation
    end
  end
end
