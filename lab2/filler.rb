require 'pg'
require 'faker'
require 'date'

PROVIDER = 1000
NETWORK_ABONENTS = 10000
CONNECTIONS = 100000
DATA_PLAN_SPECS = 1000
PROVIDER_SPECS = 1000

arr_philosophers = (0...DATA_PLAN_SPECS).map {|_| Faker::Name.unique.name }
# p PG.version
#puts arr_philosophers[Faker::Number.unique.between(from: 0, to: DATA_PLAN_SPECS)]
#puts arr_philosophers.length
#11.times do
#    puts Faker::Number.unique.between(from: 0, to: (DATA_PLAN_SPECS))
#end
DB = PG.connect(dbname: 'lab2', password: '1234')

Faker::Config.locale = 'en-US'

#DB.exec File.read('SQL/creating_tables.sql')
DB.exec File.read('lab2.sql')

#Tariff data
DATA_PLAN_SPECS.times do |i|
  DB.exec "INSERT INTO data_plan_spec (
            data_plan_name ,
            max_speed_MBits ,
            num_non_roam_state ,
            monthly_subscription_fee
        )
        values ( 
            '#{DB.escape(arr_philosophers[i])}',
            #{rand(10..10000)},
            #{rand(1..27)},
            #{rand(7..58)}
            );"
end

PROVIDER.times do
    DB.exec "INSERT INTO provider(
            provider_name,
            provider_id,
            number_of_numbers,
            code
        )
        values (
            '#{DB.escape(Faker::Blockchain::Bitcoin.address)}',
            #{Faker::Number.unique.between(from: 0, to: (PROVIDER-1))},
            #{rand(100..1000)},
            #{rand(1..1000)}
            )"
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
        data_plan
    )
    values (
	    '#{DB.escape(daten)}',
        '#{DB.escape(tel_numero)}',
        #{Faker::Number.unique.between(from: 0, to: CONNECTIONS)},
        #{rand(PROVIDER)},
        #{rand(100)},
        '#{DB.escape((arr_philosophers[rand(10)]).to_s)}'
        )"
end

#puts Faker::Number.unique.between(from: 0, to: CONNECTIONS)

NETWORK_ABONENTS.times do 
    DB.exec "INSERT INTO network_abonent (
        abonent_id,
        abonent_fullname,
        abonent_personal_data,
        abonent_address,
        connection_id
    )
    values (
        #{Faker::Number.unique.between(from: 0, to: NETWORK_ABONENTS)},
        '#{DB.escape((Faker::Name.name_with_middle).to_s)}',
        '#{DB.escape(Faker::IDNumber.valid)}',
        '#{DB.escape(Faker::Address.full_address)}',
        #{Faker::Number.unique.within(range: 1..CONNECTIONS)}
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
        '#{rand(2..5)}G'
    )"
end
