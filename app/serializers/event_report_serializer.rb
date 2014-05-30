class EventReportSerializer < ActiveModel::Serializer
  attributes :barn_name, :event_code, :description, :reported_at

  def description
  	object.description
  end

  def barn_name
  	object.barn.name
  end

  def reported_at
  	object.created_at
  end
end
