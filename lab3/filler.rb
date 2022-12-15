require 'pg'
require 'faker'
require 'date'

PROVIDER = 100
NETWORK_ABONENTS = 100
CONNECTIONS = 10000
DATA_PLAN_SPECS = 100
PROVIDER_SPECS = 100

arr_philosophers = (0...DATA_PLAN_SPECS).map {|_| Faker::Name.unique.name }
DB = PG.connect(dbname: 'lab2', password: '1234')

Faker::Config.locale = 'en-US'

DB.exec File.read('lab3.sql')

DATA_PLAN_SPECS.times do |i|
  DB.exec "INSERT INTO data_plan_spec (
            max_speed_MBits,
            num_non_roam_state,
            monthly_subscription_fee
        )
        values ( 
            #{rand(10..10000)},
            #{rand(1..27)},
            #{rand(7..58)}
            );"
end

PROVIDER.times do
    DB.exec "INSERT INTO provider(
            provider_name,
            number_of_numbers,
            code
        )
        values (
            '#{DB.escape(Faker::Blockchain::Bitcoin.address)}',
            #{rand(100..1000)},
            #{rand(1..1000)}
            );"
end

NETWORK_ABONENTS.times do 
    DB.exec "INSERT INTO network_abonent (
        abonent_fullname,
        abonent_personal_data,
        abonent_address,
        connection_id
    )
    values (
        '#{DB.escape((Faker::Name.name_with_middle).to_s)}',
        '#{DB.escape(Faker::IDNumber.valid)}',
        '#{DB.escape(Faker::Address.full_address)}',
        #{Faker::Number.unique.within(range: 1..CONNECTIONS)}
    	);"
end

CONNECTIONS.times do
    daten = (Faker::Date.between(from:'2000-01-01', to:'2002-12-12'))
    daten = daten.to_s
    tel_numero = Faker::PhoneNumber.unique.phone_number
    DB.exec "INSERT INTO connections (
	installation_date,
	tel_num,
        abonent_id,
        provider_id,
        plan_indebtedness,
        data_plan_id
    )
    values (
	'#{DB.escape(daten)}',
        '#{DB.escape(tel_numero)}',
        #{rand(1..NETWORK_ABONENTS)},
        #{rand(1..PROVIDER)},
        #{rand(100)},
        #{rand(1..DATA_PLAN_SPECS)}
        )"
end

PROVIDER_SPECS.times do
    DB.exec "INSERT INTO provider_specs (
    number_of_base_stations,
    coverage_zone_sq_km,
    last_generation
    )
    values (
        #{rand(100..1000)},
        #{rand(100000..1000000)},
        '#{rand(2..5)}G'
    )"
end
