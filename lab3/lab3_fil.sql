INSERT INTO data_plan_spec (max_speed_MBits, num_non_roam_state, monthly_subscription_fee)
SELECT r1.max_speed_MBits, r1.num_non_roam_state, r1.monthly_subscription_fee
FROM data_plan_spec r1
CROSS JOIN data_plan_spec r2
LIMIT 1000000;

INSERT INTO connections (installation_date, tel_num, abonent_id, provider_id, plan_indebtedness, data_plan_id)
SELECT r1.installation_date, r1.tel_num, r1.abonent_id, r1.provider_id, r1.plan_indebtedness, r1.data_plan_id
FROM connections r1
CROSS JOIN connections r2
LIMIT 10000000;