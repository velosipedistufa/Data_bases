require 'pg'
require 'faker'

PROVIDER = 10
NETWORK_ABONENTS = 10
CONNECTIONS = 1000
DATA_PLAN_SPECS = 10
PROVIDER_SPECS = 10

# p PG.version

DB = PG.connect(dbname: 'lab2', password: '1234')

Faker::Config.locale = 'en-US'

#DB.exec File.read('SQL/creating_tables.sql')
DB.exec File.read('lab2')

#Tariff data
#DATA_PLAN_SPECS.times do
#  DB.exec "INSERT INTO data_plan_spec (
#            data_plan ,
#            max_speed_MBits ,
#            num_non_roam_state ,
#            monthly_subscription_fee
#        )
#        values ( 
#            '#{DB.escape(Faker::GreekPhilosophers.name)}',
#            #{rand(10..10000)},
#            #{rand(1..27)},
#            #{rand(7..58)}
#            );"
#end

PROVIDER.times do
    DB.exec "INSERT INTO provider(
            provider_name,
            provider_id,
            number_of_numbers,
            code
        )
        values (
            '#{DB.escape(Faker::Kpop.solo)}',
            #{rand(1000..9999)},
            #{rand(100..1000)},
            #{rand(1..1000)}
            )"
end

CONNECTIONS.times do
    DB.exec "INSERT INTO connections (
	    installation_date,
	    tel_num,
        abonent_id,
        provider_id,
        plan_indebtedness
    )
    values (
	    '#{DB.escape(Faker::Date.between(from:'2000-01-01',to:'2002-12-12'))}'
        '#{DB.escape(Faker::PhoneNumber.phone_number)}'
        #{rand(NETWORK_ABONENTS)},
        #{rand(PROVIDER)},
        #{rand(100)}
        )"
end

NETWORK_ABONENTS.times do
    DB.exec "INSERT INTO network_abonents (
        abonent_id,
        abonent_fullname,
        abonent_personal_data,
        abonent_address
    )
    values (
        #{rand(NETWORK_ABONENTS)},
        #{DB.escape(Faker::Name.name_with_middle)},
        #{DB.escape(Faker::IDNumber.valid)},
        #{DB.escape(Faker::Address.full_address)}
    )"
end

PROVIDER_SPECS.times do
    DB.exec "INSERT INTO provider_specs (
    provider_id,
    number_of_base_stations,
    coverage_zone_sq_km,
    last_generation
    )
    values (
        #{rand(PROVIDER_SPECS)},
        #{rand(100..1000)},
        #{rand(100000..1000000)},
        #{rand(2-5)}G
    )"
end
