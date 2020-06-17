require 'zoom'

Zoom.configure do |c|
  c.api_key = 'YwV1lFz_SgeoMjh6HAa6Fw'
  c.api_secret = 'b73xgASHiXObTMZmzCNtP8aXQY9vhyNUX7hu'
end

zoom_client = Zoom.new

user_list = zoom_client.user_list
user_id = user_list['users'][0]['id']
meeting_room = zoom_client.meeting_create(
  user_id: user_id,
  type: 2,
  start_time: Time.now,
  duration: 50,
  timezone: 'Asia/Tokyo',
  password: 'password',
  settings: {
    host_video: true,
    participant_video: true,
    cn_meeting: false,
    in_meeting: false,
    join_before_host: true,
    mute_upon_entry: false,
    waiting_room: false
  }
)

puts meeting_room

# user_list['users'].each do |user|
#   user_id = user['id']
#   puts zoom_client.meeting_list(host_id: user_id)
# end

# begin
#   user_list = zoom_client.user_list!
# rescue Zoom::Error => exception
#   puts 'Something went wrong'
# end