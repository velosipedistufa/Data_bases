#
# SELECTS
#

#Find providers, who has got more than 100 numbers and whos id less than 7
SELECT * FROM provider
WHERE number_of_numbers > 100
AND provider_id < 7;

#Find provider, that are capable of 5G
SELECT provider.provider_name, provider_specs.last_generation
FROM provider, provider_specs
WHERE provider_specs.provider_id = provider.provider_id
AND provider_specs.last_generation = '5G'

#Find all connections with speed greater than 1000mbits/second
SELECT network_abonent.connection_id, data_plan_spec.max_speed_mbits, connections.abonent_id
FROM network_abonent, data_plan_spec, connections
WHERE data_plan_spec.max_speed_mbits > 1000
AND connections.data_plan = data_plan_spec.data_plan_name

#
# DELETES and UPDATES
#

#Set generation of mobile communicaion to 5G for all providers, whos id exceeds number 7
UPDATE provider_specs SET last_generation = '5G'
WHERE provider_id > 7;

#Delete connections that aren't used by any abonents
DELETE FROM connections WHERE connections.connection_id NOT IN (
	SELECT network_abonent.connection_id
	FROM network_abonent
);

#Increase number of base stations for providers, that has more than 700 numbers
UPDATE provider_specs SET number_of_base_stations = number_of_base_stations + 100
WHERE provider_specs.provider_id IN (
	SELECT provider.provider_id
	FROM provider
	WHERE provider.number_of_numbers > 700
);


#
# TRANSACTIONS
#

BEGIN TRANSACTION ISOLATION LEVEU READ COMMITTTED;

UPDATE connections SET 

COMMIT;

CREATE OR REPLACE FUNCTION add_station()
RETURNs trigger as
$rise_stat$
BEGIN
UPDATE provider_specs SET coverage_zone_sq_km = coverage_zone_sq_km + 100
from new
WHERE provider_specs = NEW.provider_specs;
RETURN NEW;
END;
$rise_stat$
language plpgsql; 

CREATE TRIGGER rise_stat
AFTER INSERT ON service_plan
FOR EACH ROW
EXECUTE FUNCTION add_station();