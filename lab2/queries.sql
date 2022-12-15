insert into provider_specs 
values
(9, 299, 526408, '4G');
select * from provider_specs

UPDATE provider_specs SET number_of_base_stations = number_of_base_stations + 100
WHERE provider_specs.provider_id IN (
	SELECT provider.provider_id
	FROM provider
	WHERE provider.number_of_numbers > 700
);

select * from connections 
where connection_id = 76;