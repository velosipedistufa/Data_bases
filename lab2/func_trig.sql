CREATE OR REPLACE FUNCTION add_station()
RETURNs trigger as
$rise_stat$
BEGIN
UPDATE provider_specs SET coverage_zone_sq_km = coverage_zone_sq_km + 100
--from new
WHERE provider_specs = NEW.provider_specs;
RETURN NEW;
END;
$rise_stat$
language plpgsql;

CREATE TRIGGER rise_stat
AFTER INSERT ON provider_specs
FOR EACH ROW
EXECUTE FUNCTION add_station();