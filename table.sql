start transaction;
--drop table rest_users;


create table rest_users (
		        id      	serial primary key,
                name    	varchar(10),
                longitude 	double precision,
                latitude 	double precision,
		        geolocation geography(point, 4326));

insert into rest_users (id, name, longitude, latitude) values(default,'mitch',10.1, 10.1);
insert into rest_users (id, name, longitude, latitude) values(default,'wayne',10.2, 10.1);

select * from rest_users
	where id =1;
select * from rest_users
	where id=2; 

--alter table rest_users add column geolocation geography(point);

--\d rest_users
update rest_users set geolocation =ST_makepoint(longitude, latitude);
--select * from rest_users where id =1;

select name, ST_Distance(ru.geolocation,
			 first_user.geolocation) distance
from rest_users ru,
lateral(
	select id, geolocation
	from rest_users
	where name = '1') as first_user
where ru.id != first_user.id
--and ST_Distance(ru.geolocation, first_user.geolocation)<10000
order by distance;


/*select to_json(t)
from (select name, 
		longitude, latitude, geolocation
	from rest_users
	order by geolocation) t;*/

delete from rest_users 
where name='mitch' and longitude=10.1 and latitude=10.1;

select * from rest_users;

rollback transaction;
--commit transaction;
                
