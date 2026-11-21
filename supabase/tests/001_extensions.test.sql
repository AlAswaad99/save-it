begin;
select plan(5);

select has_extension('postgis', 'postgis is installed');
select has_extension('pgcrypto', 'pgcrypto is installed');
select has_extension('pg_trgm', 'pg_trgm is installed');
select has_extension('pg_net', 'pg_net is installed');
select has_extension('pg_cron', 'pg_cron is installed');

select * from finish();
rollback;
