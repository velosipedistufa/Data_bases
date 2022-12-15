CREATE USER test;
GRANT SELECT, INSERT, UPDATE ON TABLE data_plan_spec TO test;
GRANT SELECT (id, provider_name), UPDATE (number_of_numbers, code) ON TABLE provider TO test;
GRANT SELECT (id) ON TABLE network_abonent TO test;
--- some test queries
SET ROLE TO test;
SELECT * FROM data_plan_spec;

SET ROLE TO test;
SELECT * FROM connections;

SET ROLE TO test;
SELECT id FROM network_abonent;

SET ROLE TO test;
UPDATE provider SET code = 585
WHERE number_of_numbers = 683 

--- prohibited queries

SET ROLE TO test;
SELECT * FROM provider_specs;

--- extendet query

CREATE ROLE extenderer;
GRANT SELECT ON TABLE provider_specs TO extenderer;
GRANT extenderer TO test;
