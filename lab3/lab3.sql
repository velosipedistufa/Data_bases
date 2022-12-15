DROP TABLE IF EXISTS connections CASCADE;
DROP TABLE IF EXISTS data_plan_spec CASCADE;
DROP TABLE IF EXISTS network_abonent CASCADE;
DROP TABLE IF EXISTS provider CASCADE;
DROP TABLE IF EXISTS provider_specs CASCADE;

CREATE TABLE data_plan_spec (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	max_speed_MBits INT NOT NULL,
	num_non_roam_state INT NOT NULL,
	monthly_subscription_fee INT NOT NULL
);

CREATE TABLE provider (
	id INT GENERATED ALWAYS AS IDENTITY NOT NULL  PRIMARY KEY,
	provider_name VARCHAR(64) NOT NULL,
	number_of_numbers INT NOT NULL,
	code INT NOT NULL
);

CREATE TABLE network_abonent (
	id INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
	connection_id INT NOT NULL,
	abonent_fullname VARCHAR(128) NOT NULL,
	abonent_personal_data VARCHAR(128) NOT NULL,
	abonent_address VARCHAR(128) NOT NULL
);

CREATE TABLE connections (
	id INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
	abonent_id INT NOT NULL,
	provider_id INT NOT NULL,
	tel_num VARCHAR(32) NOT NULL,
	data_plan_id INT NOT NULL,
	plan_indebtedness INT NOT NULL,
	installation_date DATE NOT NULL,
	CONSTRAINT fk_connections
		FOREIGN KEY (data_plan_id)
		REFERENCES data_plan_spec (id),
	CONSTRAINT fk_prov
		FOREIGN KEY (provider_id)
		REFERENCES provider (id),
	CONSTRAINT fk_abon
		FOREIGN KEY (abonent_id)
		REFERENCES network_abonent (id)
);

CREATE TABLE provider_specs (
	provider_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	number_of_base_stations INT NOT NULL,
	coverage_zone_sq_km INT NOT NULL,
	last_generation VARCHAR(8),
	CONSTRAINT fk_provider_specs
		FOREIGN KEY (provider_id)
		REFERENCES provider (id)
);