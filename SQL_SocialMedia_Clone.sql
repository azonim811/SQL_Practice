# 1. Find the 5 oldest users - to reward for loyalty
select *
from users
order by created_at
limit 5;

# 2. What day of the week do most users register on? - to schedule a one day ad campaign
select dayname(created_at) as day_of_week, count(*) as total
from users
group by day_of_week
order by total desc;

# 3. Find the users who have never posted a photo - to target for an email campaign
select u.username, p.image_url 
from users u
left join photos p
	on u.id = p.user_id
where p.image_url is null;

# 4. Who get the most liked photo?
select u.username, p.id, p.image_url, count(*) as total
from users u
join photos p
	on u.id = p.user_id
join likes l
	on p.id = l.photo_id
group by u.username, p.id, p.image_url
order by total desc
limit 1;

# 5. Investors want to know - Average number of photos per user posts
-- Total # of photos / Total # of users
select	(count(*) / (select count(*) from users)) as avg_num_photo
from photos;

# 6. What are the top 5 most commonly used hashtags?
select t.tag_name, count(*) as total
from tags t
join photo_tags p
	on t.id = p.tag_id
group by t.tag_name
order by total desc
limit 5;

# 7. Find users who have liked every single photo on the site - bots problem
select u.username, count(*) as num_likes
from users u 
join likes l
	on u.id = l.user_id
group by u.username
having num_likes = (select count(*) from photos);





