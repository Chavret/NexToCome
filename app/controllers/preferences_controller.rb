class PreferencesController < ApplicationController
  skip_after_action :verify_authorized

  def save_filters
    ActsAsVotable::Vote.by_type("User").
      where(votable_type: ["Category", "SubCategory"], voter_id: current_user.id).
      destroy_all

    @selected_categories = Category.where(name: params[:categories])

    @selected_categories.each do |category|
      category.liked_by current_user
    end

    @selected_sub_categories = SubCategory.where(name: params[:sub_categories])

    @selected_sub_categories.each do |sub_category|
      sub_category.liked_by current_user
    end

    redirect_to sync_calendar_path
  end

def sync_calendar
    @events = current_user.find_liked_items
    respond_to do |format|
      format.html
      format.ics do
        cal = Icalendar::Calendar.new
        filename = "Your coming up calendar"
        @events.each do |event|
            happening = Icalendar::Event.new
            happening.dtstart = event.occurs_at
            happening.dtend = event.occurs_at
            happening.summary = event.description
            cal.add_event(happening)
          end
        end
        cal.publish
        #apparition du pop up avec "lien intégré qui dépend du cal "

        render :text =>  cal.to_ical


        #faire une modal avec un lien

        #cal unique pour chaque utilisateur
        #si il existe déjà, update

        redirect_to events_path

        # send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
      end
  end



end
