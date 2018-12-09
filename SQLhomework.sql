use sakila;
# 1a.
select last_name, first_name
from actor;
 
#1b. 
select concat(first_name, ' ' ,last_name) as `Actor Name`
from actor;

#2a.
select actor_id, first_name, last_name
from actor
where first_name='joe';

#2b.
select last_name, first_name
from actor
where last_name like '%gen%';

#2c.
select last_name, first_name
from actor
where last_name like '%li%'
order by last_name, first_name;

#2d.
select country_id, country
from country
where country in ('Afghanistan','Bangladesh','China');

#3a.
alter table actor
	add column description blob;

#3b.    
alter table actor
	drop column description;

#4a.    
select last_name, count(last_name)
from actor
group by last_name;

#4b.
select last_name, count(last_name)
from actor
group by last_name
having count(last_name) >= 2;

  
select *
from actor
where last_name='williams';

#4c.
update actor
    set first_name = 'Harpo'
    where actor_id = 172;

#4d.    
update actor
	set first_name = 'Groucho'
    where first_name = 'Harpo';

#5a.    
create table address2
select *
from address;

#6a.
select last_name, first_name, address
from staff
inner join address on staff.address_id=address.address_id;

#6b.
select sum(p.amount) as `Total Sales`,s.last_name, s.first_name
from payment p
join staff s on p.staff_id=s.staff_id
where p.payment_date between '2005-08-01 00:00:00' and '2005-08-31 23:59:59'
group by s.last_name;

#6c.
select f.title, count(a.last_name) as `Number of Actors in Film`
from film f, actor a, film_actor fa
where f.film_id = fa.film_id and fa.actor_id = a.actor_id
group by f.title;

#6d.
select count(i.inventory_id) as `Number of Copies`
from inventory i
inner join film f on i.film_id=f.film_id
where title='Hunchback Impossible';

#6e.
select sum(p.amount) as `Total Paid`, c.last_name, c.first_name
from payment p join customer c
on p.customer_id=c.customer_id
group by c.last_name;

#7a.
select title
from film
where title like 'k%' or title like 'q%'
and (select name from language where name='english');

#7b.
select a.last_name, a.first_name
from actor a
where a.actor_id in
(	select fa.actor_id
	from film_actor fa
	where fa.film_id in
	(	select f.film_id
		from film f
        where f.title='Alone Trip'
    )
);

#7c.
select c.last_name, c.first_name, c.email
from customer c
where c.address_id in
(
	select a.address_id
    from address a
    where a.city_id in
    (
		select y.city_id
        from city y
        where y.country_id in
        (
			select cr.country_id
            from country cr
            where country='canada'
        )
    )
);

#7c.
select c.last_name, c.first_name, c.email, cr.country
from customer c, address a, city y, country cr
where c.address_id=a.address_id and a.city_id=y.city_id
and y.country_id=cr.country_id
and country = 'canada';

#7d.
select f.title
from film f, film_category fc, category c
where f.film_id=fc.film_id and fc.category_id=c.category_id
and c.name = 'family';

#7e
select f.title, count(r.rental_id) as `Rental Count`
from rental r, film f, inventory i
where r.inventory_id=i.inventory_id
and i.film_id=f.film_id
group by title
order by count(r.rental_id) desc;


#7f.
select  s.store_id, sum(p.amount) as `Rent Income`
from store s, payment p, staff sf
where p.staff_id=sf.staff_id and sf.store_id=s.store_id
group by s.store_id;

#7g.
select s.store_id, y.city, cr.country
from store s, address a, city y, country cr
where s.address_id=a.address_id and a.city_id=y.city_id
and y.country_id=cr.country_id;


#7h.
select c.name, sum(p.amount) as `Gross Revenue`
from category c, payment p, film_category fc, inventory i, rental r
where p.rental_id=r.rental_id and r.inventory_id=i.inventory_id
and i.film_id=fc.film_id and fc.category_id=c.category_id
group by c.name
order by sum(p.amount) desc
limit 5;

#8a.
create view top_five_genres_view as
select c.name, sum(p.amount) as `Gross Revenue`
from category c, payment p, film_category fc, inventory i, rental r
where p.rental_id=r.rental_id and r.inventory_id=i.inventory_id
and i.film_id=fc.film_id and fc.category_id=c.category_id
group by c.name
order by sum(p.amount) desc
limit 5;

#8b.
SELECT * FROM sakila.top_five_genres_view;

#8c.
drop view sakila.top_five_genres_view;


