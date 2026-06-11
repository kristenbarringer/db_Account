# user_accounts

## Columns

| Name | Type | Default | Nullable | Children | Parents | Comment |
| ---- | ---- | ------- | -------- | -------- | ------- | ------- |
| user_uuid | uniqueidentifier | (newsequentialid()) | false |  |  |  |
| user_rid | bigint |  | false | [account_type](account_type.md) [account_type_permission_mapping](account_type_permission_mapping.md) [contact](contact.md) [customer_account_information](customer_account_information.md) [customer_billing_information](customer_billing_information.md) [customer_internal_view](customer_internal_view.md) [customer_rate_information](customer_rate_information.md) [dealer](dealer.md) [dealer_family](dealer_family.md) [locations_common](locations_common.md) [role_permission_mapping](role_permission_mapping.md) [subscription](subscription.md) [tenant_service_level_mapping](tenant_service_level_mapping.md) [user_grid_view_preference](user_grid_view_preference.md) |  |  |
| tenant_uuid | uniqueidentifier |  | false |  | [account_details](account_details.md) |  |
| user_name | nvarchar(200) |  | true |  |  |  |
| first_name | nvarchar(50) | ('Tracking') | false |  |  |  |
| last_name | nvarchar(50) | ('User') | false |  |  |  |
| email_address | nvarchar(300) |  | false |  |  |  |
| phone_number | nvarchar(50) |  | true |  |  |  |
| phone_extension | int |  | true |  |  |  |
| title | nvarchar(200) |  | true |  |  |  |
| landing_page | nvarchar(55) | ('DEFAULT') | false |  |  |  |
| object_id | nvarchar(50) |  | true |  |  |  |
| role_rid | bigint | ((1)) | true |  | [role](role.md) |  |
| account_type_code | varchar(30) | ('ACT_CUSTOMER') | false |  | [lookup_code](lookup_code.md) |  |
| speed_type_code | varchar(30) | ('SPT_MPH') | false |  | [lookup_code](lookup_code.md) |  |
| language_code | varchar(30) | ('ENUS') | false |  | [lookup_code](lookup_code.md) |  |
| temperature_type_code | varchar(30) | ('TMP_FAHRENHEIT') | false |  | [lookup_code](lookup_code.md) |  |
| fuel_type_code | varchar(30) | ('FLT_U_S_GALLONS') | false |  | [lookup_code](lookup_code.md) |  |
| timezone_code | varchar(30) | ('TMZ_AMERICA_CHICAGO') | false |  | [lookup_code](lookup_code.md) |  |
| theme_code | varchar(30) | ('THM_LIGHT') | false |  | [lookup_code](lookup_code.md) |  |
| tour_status_code | varchar(30) | ('TOR_0') | false |  | [lookup_code](lookup_code.md) |  |
| phone_type_code | varchar(30) | ('PHT_MOBILE') | false |  | [lookup_code](lookup_code.md) |  |
| status_code | varchar(30) | ('USR_ACTIVE') | false |  | [lookup_code](lookup_code.md) |  |
| is_active | bit | ((1)) | false |  |  |  |
| is_onboarded | bit | ((1)) | true |  |  |  |
| is_migrated_data | bit | ((0)) | false |  |  |  |
| created_date | datetime | (getdate()) | false |  |  |  |
| updated_date | datetime | (getdate()) | false |  |  |  |
| activated_date | datetime |  | true |  |  |  |
| expiration_date | datetime |  | true |  |  |  |
| created_by_user_rid | uniqueidentifier |  | true |  |  |  |
| updated_by_user_rid | uniqueidentifier |  | true |  |  |  |
| notes | nvarchar(1000) |  | true |  |  |  |
| test_data_group | int |  | true |  |  |  |
| active | bit | ((1)) | false |  |  |  |
| created | datetime | (getdate()) | false |  |  |  |

## Constraints

| Name | Type | Definition |
| ---- | ---- | ---------- |
| pk_user_accounts_tenant_uuid_user_accounts_rid | PRIMARY KEY | CLUSTERED, unique, part of a PRIMARY KEY constraint, [ tenant_uuid, user_rid ] |
| uk_user_accounts_uuid | UNIQUE | NONCLUSTERED, unique, part of a UNIQUE constraint, [ user_uuid ] |
| uk_user_accounts_rid | UNIQUE | NONCLUSTERED, unique, part of a UNIQUE constraint, [ user_rid ] |
| fk_user_accounts_account_type_code | FOREIGN KEY | FOREIGN KEY(account_type_code) REFERENCES lookup_code(code) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accounts_fuel_type_code | FOREIGN KEY | FOREIGN KEY(fuel_type_code) REFERENCES lookup_code(code) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accounts_language_code | FOREIGN KEY | FOREIGN KEY(language_code) REFERENCES lookup_code(code) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accounts_role_rid | FOREIGN KEY | FOREIGN KEY(role_rid) REFERENCES role(role_rid) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accounts_speed_type_code | FOREIGN KEY | FOREIGN KEY(speed_type_code) REFERENCES lookup_code(code) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accounts_status_code | FOREIGN KEY | FOREIGN KEY(status_code) REFERENCES lookup_code(code) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accounts_temperature_type_code | FOREIGN KEY | FOREIGN KEY(temperature_type_code) REFERENCES lookup_code(code) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accounts_tenant_uuid | FOREIGN KEY | FOREIGN KEY(tenant_uuid) REFERENCES account_details(tenant_uuid) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accounts_theme_code | FOREIGN KEY | FOREIGN KEY(theme_code) REFERENCES lookup_code(code) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accounts_timezone_code | FOREIGN KEY | FOREIGN KEY(timezone_code) REFERENCES lookup_code(code) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accounts_tour_status_code | FOREIGN KEY | FOREIGN KEY(tour_status_code) REFERENCES lookup_code(code) ON UPDATE NO_ACTION ON DELETE NO_ACTION |
| fk_user_accountsphone_type_code | FOREIGN KEY | FOREIGN KEY(phone_type_code) REFERENCES lookup_code(code) ON UPDATE NO_ACTION ON DELETE NO_ACTION |

## Indexes

| Name | Definition |
| ---- | ---------- |
| pk_user_accounts_tenant_uuid_user_accounts_rid | CLUSTERED, unique, part of a PRIMARY KEY constraint, [ tenant_uuid, user_rid ] |
| uk_user_accounts_uuid | NONCLUSTERED, unique, part of a UNIQUE constraint, [ user_uuid ] |
| uk_user_accounts_rid | NONCLUSTERED, unique, part of a UNIQUE constraint, [ user_rid ] |
| ix_fk_user_accounts_speed_type_code | NONCLUSTERED, [ speed_type_code ] |
| ix_fk_user_accounts_fuel_type_code | NONCLUSTERED, [ fuel_type_code ] |
| ix_fk_user_accounts_tenant_uuid | NONCLUSTERED, [ tenant_uuid ] |
| ix_user_accounts_tenant_uuid_status_code | NONCLUSTERED, [ tenant_uuid, status_code ] |
| ix_fk_user_accounts_tour_status_code | NONCLUSTERED, [ tour_status_code ] |
| ix_fk_user_accounts_account_type_code | NONCLUSTERED, [ account_type_code ] |
| ix_fk_user_accounts_role_rid | NONCLUSTERED, [ role_rid ] |
| ix_fk_user_accounts_temperature_type_code | NONCLUSTERED, [ temperature_type_code ] |
| ix_fk_user_accounts_timezone_code | NONCLUSTERED, [ timezone_code ] |
| ix_fk_user_accounts_phone_type_code | NONCLUSTERED, [ phone_type_code ] |
| ix_fk_user_accounts_status_code | NONCLUSTERED, [ status_code ] |
| ix_fk_user_accounts_theme_code | NONCLUSTERED, [ theme_code ] |
| ix_fk_user_accounts_language_code | NONCLUSTERED, [ language_code ] |

## Relations

![er](user_accounts.svg)

---

> Generated by [tbls](https://github.com/k1LoW/tbls)
