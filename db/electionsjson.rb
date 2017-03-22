require 'json'
require 'open-uri'

url = 'http://www.electionguide.org/ajax/election/upcoming/?sEcho=2&iColumns=5&sColumns=&iDisplayStart=0&iDisplayLength=300&mDataProp_0=0&mDataProp_1=1&mDataProp_2=2&mDataProp_3=3&mDataProp_4=4&sSearch=&bRegex=false&sSearch_0=&bRegex_0=false&bSearchable_0=true&sSearch_1=&bRegex_1=false&bSearchable_1=true&sSearch_2=&bRegex_2=false&bSearchable_2=true&sSearch_3=&bRegex_3=false&bSearchable_3=true&sSearch_4=&bRegex_4=false&bSearchable_4=true&iSortCol_0=3&sSortDir_0=asc&iSortingCols=1&bSortable_0=false&bSortable_1=true&bSortable_2=false&bSortable_3=true&bSortable_4=true&_=1490186507989'
event_serialized = open(url).read

def electionsjson_scraper(event_serialized)

  info = JSON.parse(event_serialized)
  total = event["iTotalRecords"]
  i = 0

  until i == total - 1
    country = info["aaData"][i][1][0]
    category = info["aaData"][i][2][0]
    date = info["aaData"][i][3]
    status = info["aaData"][i][4]
    title = info["aaData"][i][6]
    type = info["aaData"][i][7]
    if status == "Confirmed"
      event = {
        occurs_at: date,
        headline: "#{title} of #{country}",
        sub_category_name: "Elections",
        }
    end
    i +=1
  end
end

