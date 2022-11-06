/* This project is focused on military sizes from countries around the world. 
In the year 2022 to be precise.
 We will take a dive into the components of these militaries which will 
 include from activity duty towards reserves.
 As well as some facts about some militaries*/

/* activeDuty:	Soliders who work for the military full time,
                Often live on base, are deployable at any time.
paramilitary: Units that assit with defence forces, private military like, 
              but not formally part of the armed forces.
reserves: Soliders who serve part time, without devoting 
            their full time to the military     
total:	Refering to the amount of services members throughout the country 
         regardless of the component they are assoicated with
Pop2022: Averaging the amount of individuals living in that country at the
          time of 2022*/
 
 -- change names for further queries
alter table army_total_world
change country army_country text;

alter table atomic_weapon
change `ï»¿country` country text;


-- top 10 countries with highest population 
select army_country ,pop2022
from army_total_world
order by pop2022 desc
limit 10;
 
 -- we may think that countries with highest population , also have highest number of military , let's check out .
 select army_country ,
           total 
from maw.army_total_world 
order by total desc 
limit 10;

/* our assumption , that countries with highest population have maximum army
is wrong , vietnam is not even in top populated country , but still have highest number of military. */

-- countries with only active duty army

select army_country,
           activeDuty 
from maw.army_total_world 
where paramilitary=0 
          and reserves=0 
order by activeDuty;


-- military vs population ratio 

select army_country , 
           total , 
           pop2022 ,
           (total/pop2022)*10 as ratio
from army_total_world
order by ratio ,pop2022 ;


-- countries having atomic weapon with their total military 

select army.army_country , 
         army.total,
         weapon.total_inventory
from maw.atomic_weapon as weapon 
 left join maw.army_total_world as army
on weapon.country=army.army_country
where weapon.retired_weapons=0
order by army.pop2022 desc;

-- ratio of military stockpile with total military of that country

select  army.army_country , 
        (weapon.military_stockpile/army.total)*100 as ratio
from maw.atomic_weapon as weapon  
inner join maw.army_total_world as army
on weapon.country=army.army_country
where weapon.retired_weapons=0
order by army.pop2022 desc;

-- both table join together 

select  army.* , 
            weapon.country,
            weapon.military_stockpile,
            weapon.retired_weapons, 
            weapon.total_inventory, 
            weapon.total_nuclear_tests
from maw.atomic_weapon as weapon  inner join maw.army_total_world as army
on weapon.country=army.army_country
where weapon.retired_weapons=0
order by army.pop2022 desc;

-- top countries having atomic weapon

select country,
        total_nuclear_tests
from maw.atomic_weapon 
order by total_nuclear_tests desc;