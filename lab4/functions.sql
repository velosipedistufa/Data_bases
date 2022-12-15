CREATE OR REPLACE FUNCTION coverage_per_station(identif integer)
RETURNS INTEGER as
$Sdiv$
DECLARE 
	C int;
	S int;
BEGIN
	C = (SELECT provider_specs.coverage_zone_sq_km FROM provider_specs
	WHERE provider_specs.provider_id = identif);
	S = (SELECT provider_specs.number_of_base_stations FROM provider_specs
	WHERE provider_specs.provider_id = identif);
	IF div(C, S) > 500 THEN
		RETURN div(C, S);
	ELSE
		RAISE EXCEPTION 'Error, insufficiend ratio';
	END IF;
END
$Sdiv$
LANGUAGE plpgsql;

select * from coverage_per_station(12);
select * from coverage_per_station(15);

CREATE OR REPLACE FUNCTION factorization(giv_num integer)
RETURNS INTEGER as
$Sdiv$
DECLARE 
	iter int = 1;
	N int = 1;
BEGIN
	WHILE iter <= giv_num LOOP
		N = N * (iter);
		iter = iter + 1;
	END LOOP;
	RETURN N;
END
$Sdiv$
LANGUAGE plpgsql;
Функция для вычисления факториала, хотя есть встроенная в PostgreSQL
select * from factorization(5);


CREATE OR REPLACE FUNCTION cur_func(identif integer)
RETURNS REFCURSOR as
$Sdiv$
DECLARE
	my_cur CURSOR (elem integer) FOR SELECT * FROM provider WHERE id = elem;
BEGIN
	OPEN my_cur (elem := identif);
	RETURN my_cur;
END
$Sdiv$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cur_func(identif integer)
RETURNS REFCURSOR as
$Sdiv$
DECLARE
	my_cur REFCURSOR := 'mycur';
BEGIN
	OPEN my_cur FOR SELECT * FROM provider WHERE id = identif;
	RETURN my_cur;
END
$Sdiv$
LANGUAGE plpgsql;

select * from cur_func(14);
fetch all from my_cur;

Select * from provider where provider.id = 14