select job_id, count(job_id) n_clicks, min(created_at) first_click, max(created_at) last_click,
	datediff(day,min(created_at),max(created_at)) days, datediff(hour,min(created_at),max(created_at)) hours,datediff(minute,min(created_at),max(created_at)) minutes	
into job_clicks_sum
from job_clicks_all
group by job_id
order by count(job_id) desc

GO

select jcs.n_clicks,jcs.first_click,jcs.last_click,jcs.minutes,jcs.hours,jcs.days,jcs.mins_per_click as mins_per_click,ja.*
into job_clicks_sum_full
from job_clicks_sum as jcs
join jobs_all ja on ja.job_id = jcs.job_id
order by mins_per_click

GO


select n_clicks,count(n_clicks) n_of_n_clicks,avg(minutes) av_mins_btw_clicks,avg(minutes)/60 av_hrs_btw_clicks,avg(minutes)/1440 av_days_btw_clicks
into job_click_stats
from job_clicks_sum
group by n_clicks
order by n_of_n_clicks desc

GO
