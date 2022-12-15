CREATE VIEW coverage_5g AS
	SELECT provider_specs.coverage_zone_sq_km, provider.provider_name
	FROM provider_specs, provider
	WHERE provider_specs.provider_id = provider.id
	ORDER BY 1 DESC;
GRANT SELECT ON TABLE coverage_5g TO test;

SET ROLE TO test;
SELECT * FROM coverage_5g;