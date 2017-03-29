class Event < ApplicationRecord
  belongs_to :sub_category
  has_one :category, through: :sub_category

  validates :occurs_at, presence: true, uniqueness: { scope: :headline }
  validates :headline, presence: true
  # validates :valid
  paginates_per 50

  def to_ics
    event = Icalendar::Event.new
    tzid = ActiveSupport::TimeZone.find_tzinfo('Paris').name

    event.dtstart = Icalendar::Values::DateTime.new(occurs_at, tzid: tzid)
    event.dtend   = Icalendar::Values::DateTime.new(occurs_at + 24.hours, tzid: tzid)

    event.summary = headline
    event.uid = "CommingUp-#{Rails.env}-#{id}"

    event
  end
end

