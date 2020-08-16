json.array!(@schedules) do |schedule|
	json.extract! schedule, :id
	json.title schedule.content
	json.start schedule.start_day
	json.end schedule.end_day
end