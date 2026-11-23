begin;
select plan(81);

-- Invoker, not security definer. Postgres refuses SET ROLE inside a
-- security-definer function. The test runner is a superuser, so this
-- function may switch to anon or authenticated and then back.
create or replace function public.rls_exec(p_role text, p_uid uuid, p_sql text)
returns text
language plpgsql
set search_path = public
as $$
declare
  out text;
begin
  perform set_config('request.jwt.claims', '', true);
  if p_uid is not null then
    perform set_config(
      'request.jwt.claims',
      json_build_object('sub', p_uid, 'role', 'authenticated')::text,
      true
    );
  end if;

  execute format('set local role %I', p_role);
  begin
    execute p_sql into out;
  exception
    when others then
      out := sqlstate;
  end;
  reset role;
  return out;
end;
$$;

insert into auth.users (
  instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at,
  confirmation_token, email_change, email_change_token_new,
  email_change_token_current, recovery_token
)
values
  (
    '00000000-0000-0000-0000-000000000000',
    '11111111-1111-1111-1111-111111111111',
    'authenticated', 'authenticated', 'cust-a@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', '', ''
  ),
  (
    '00000000-0000-0000-0000-000000000000',
    '22222222-2222-2222-2222-222222222222',
    'authenticated', 'authenticated', 'cust-b@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', '', ''
  ),
  (
    '00000000-0000-0000-0000-000000000000',
    '33333333-3333-3333-3333-333333333333',
    'authenticated', 'authenticated', 'rest-a@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', '', ''
  ),
  (
    '00000000-0000-0000-0000-000000000000',
    '44444444-4444-4444-4444-444444444444',
    'authenticated', 'authenticated', 'rest-b@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', '', ''
  ),
  (
    '00000000-0000-0000-0000-000000000000',
    '55555555-5555-5555-5555-555555555555',
    'authenticated', 'authenticated', 'admin@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', '', ''
  );

update public.profiles set role = 'restaurant'
where id in (
  '33333333-3333-3333-3333-333333333333',
  '44444444-4444-4444-4444-444444444444'
);
update public.profiles set role = 'admin'
where id = '55555555-5555-5555-5555-555555555555';
update public.profiles set full_name = 'Ada'
where id = '11111111-1111-1111-1111-111111111111';
update public.profiles set full_name = 'Bea'
where id = '22222222-2222-2222-2222-222222222222';

insert into public.restaurants (id, user_id, name, login_email, area_id, location)
values
  (
    '66666666-6666-6666-6666-666666666666',
    '33333333-3333-3333-3333-333333333333',
    'Kitchen A', 'rest-a@example.com', 1,
    extensions.st_setsrid(extensions.st_makepoint(54.37, 24.45), 4326)::extensions.geography
  ),
  (
    '77777777-7777-7777-7777-777777777777',
    '44444444-4444-4444-4444-444444444444',
    'Kitchen B', 'rest-b@example.com', 2,
    extensions.st_setsrid(extensions.st_makepoint(54.38, 24.46), 4326)::extensions.geography
  );

insert into public.opening_hours (restaurant_id, weekday, opens_at, closes_at, is_closed)
values
  ('66666666-6666-6666-6666-666666666666', 1, '10:00', '22:00', false),
  ('77777777-7777-7777-7777-777777777777', 1, '10:00', '22:00', false);

insert into public.pickup_windows (id, restaurant_id, date, starts_at, ends_at)
values
  (
    'aaaaaaaa-1111-1111-1111-111111111111',
    '66666666-6666-6666-6666-666666666666',
    date '2026-11-22',
    '2026-11-22 12:00:00+00',
    '2026-11-22 16:00:00+00'
  ),
  (
    'aaaaaaaa-2222-2222-2222-222222222222',
    '77777777-7777-7777-7777-777777777777',
    date '2026-11-22',
    '2026-11-22 12:00:00+00',
    '2026-11-22 16:00:00+00'
  );

insert into public.listings (
  id, restaurant_id, date, name, category_id, original_price, discounted_price, quantity
)
values
  (
    '88888888-8888-8888-8888-888888888888',
    '66666666-6666-6666-6666-666666666666',
    date '2026-11-22', 'Soup A', 1, 20, 8, 2
  ),
  (
    '99999999-9999-9999-9999-999999999999',
    '77777777-7777-7777-7777-777777777777',
    date '2026-11-22', 'Soup B', 1, 20, 8, 2
  ),
  (
    '88888888-8888-8888-8888-888888888881',
    '66666666-6666-6666-6666-666666666666',
    date '2026-11-22', 'Spare A', 1, 20, 8, 2
  );

insert into public.orders (
  id, code, customer_id, customer_name, restaurant_id, pickup_window_id,
  status, total, commission_rate, commission_amount
)
values
  (
    'bbbbbbbb-1111-1111-1111-111111111111',
    'ABCD23',
    '11111111-1111-1111-1111-111111111111',
    'Ada',
    '66666666-6666-6666-6666-666666666666',
    'aaaaaaaa-1111-1111-1111-111111111111',
    'reserved', 8, 0.4000, 3.20
  ),
  (
    'bbbbbbbb-2222-2222-2222-222222222222',
    'EFGH45',
    '22222222-2222-2222-2222-222222222222',
    'Bea',
    '77777777-7777-7777-7777-777777777777',
    'aaaaaaaa-2222-2222-2222-222222222222',
    'reserved', 8, 0.4000, 3.20
  );

insert into public.order_items (
  order_id, listing_id, name, unit_price, original_price, quantity, line_total
)
values
  (
    'bbbbbbbb-1111-1111-1111-111111111111',
    '88888888-8888-8888-8888-888888888888',
    'Soup A', 8, 20, 1, 8
  ),
  (
    'bbbbbbbb-2222-2222-2222-222222222222',
    '99999999-9999-9999-9999-999999999999',
    'Soup B', 8, 20, 1, 8
  );

insert into public.device_tokens (user_id, token, platform)
values ('22222222-2222-2222-2222-222222222222', 'token-b', 'android');

insert into public.outbox (id, channel, recipient_user_id, template)
values (
  'cccccccc-1111-1111-1111-111111111111',
  'email',
  '11111111-1111-1111-1111-111111111111',
  'login_code'
);

insert into public.audit_log (id, actor_id, action, target_type, target_id)
values (
  'dddddddd-1111-1111-1111-111111111111',
  '55555555-5555-5555-5555-555555555555',
  'test',
  'profile',
  '11111111-1111-1111-1111-111111111111'
);

-- profiles
select is(public.rls_exec('anon', null, $$select count(*)::text from public.profiles$$), '0', 'anon cannot read profiles');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.profiles$$), '1', 'a customer reads only their profile');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.profiles where id = '22222222-2222-2222-2222-222222222222'$$), '0', 'a customer cannot read another profile');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$with u as (update public.profiles set full_name = 'Ada Updated' where id = '11111111-1111-1111-1111-111111111111' returning 1) select count(*)::text from u$$), '1', 'a customer can update their name');
select is((select full_name from public.profiles where id = '11111111-1111-1111-1111-111111111111'), 'Ada Updated', 'the customer name update is stored');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$with u as (update public.profiles set role = 'admin' where id = '11111111-1111-1111-1111-111111111111' returning 1) select count(*)::text from u$$), 'P0001', 'a customer cannot change their role');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$with u as (update public.profiles set full_name = 'Stolen' where id = '22222222-2222-2222-2222-222222222222' returning 1) select count(*)::text from u$$), '0', 'a customer cannot rename someone else');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.profiles$$), '1', 'a restaurant reads only their profile');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with u as (update public.profiles set full_name = 'No' where id = '33333333-3333-3333-3333-333333333333' returning 1) select count(*)::text from u$$), '0', 'a restaurant cannot edit their profile directly');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.profiles$$), '5', 'an admin reads every profile');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$with u as (update public.profiles set status = 'warned' where id = '22222222-2222-2222-2222-222222222222' returning 1) select count(*)::text from u$$), '1', 'an admin can update any profile');

-- reference data
select is(public.rls_exec('anon', null, $$select count(*)::text from public.areas$$), '26', 'anon can read areas');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.categories$$), '7', 'a customer can read categories');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.dietary_tags$$), '5', 'a restaurant can read dietary tags');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.areas$$), '26', 'an admin can read areas');
select is(public.rls_exec('anon', null, $$with i as (insert into public.areas (id, name, location, sort) values (99, 'Nowhere', extensions.st_setsrid(extensions.st_makepoint(54, 24), 4326)::extensions.geography, 99) returning 1) select count(*)::text from i$$), '42501', 'anon cannot insert an area');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$with i as (insert into public.categories (id, name, sort) values (99, 'Extra', 99) returning 1) select count(*)::text from i$$), '42501', 'an admin cannot edit the category list');

-- restaurants, hours, windows
select is(public.rls_exec('anon', null, $$select count(*)::text from public.restaurants$$), '0', 'anon cannot read restaurants directly');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.restaurants$$), '0', 'a customer cannot read restaurants directly');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.restaurants$$), '1', 'a restaurant reads their own row');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.restaurants where id = '77777777-7777-7777-7777-777777777777'$$), '0', 'a restaurant cannot read another restaurant');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with u as (update public.restaurants set name = 'Hijack' where id = '66666666-6666-6666-6666-666666666666' returning 1) select count(*)::text from u$$), '0', 'a restaurant cannot edit their row directly');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.restaurants$$), '2', 'an admin reads every restaurant');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$with u as (update public.restaurants set name = 'Kitchen A renamed' where id = '66666666-6666-6666-6666-666666666666' returning 1) select count(*)::text from u$$), '1', 'an admin can update a restaurant');

select is(public.rls_exec('anon', null, $$select count(*)::text from public.opening_hours$$), '0', 'anon cannot read opening hours');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.opening_hours$$), '0', 'a customer cannot read opening hours directly');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.opening_hours$$), '1', 'a restaurant reads their own hours');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.opening_hours where restaurant_id = '77777777-7777-7777-7777-777777777777'$$), '0', 'a restaurant cannot read another restaurant''s hours');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with i as (insert into public.opening_hours (restaurant_id, weekday, opens_at, closes_at, is_closed) values ('66666666-6666-6666-6666-666666666666', 3, '10:00', '22:00', false) returning 1) select count(*)::text from i$$), '42501', 'a restaurant cannot write opening hours');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.opening_hours$$), '2', 'an admin reads every opening hour');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$with i as (insert into public.opening_hours (restaurant_id, weekday, opens_at, closes_at, is_closed) values ('66666666-6666-6666-6666-666666666666', 2, '10:00', '22:00', false) returning 1) select count(*)::text from i$$), '1', 'an admin can write opening hours');

select is(public.rls_exec('anon', null, $$select count(*)::text from public.pickup_windows$$), '0', 'anon cannot read pickup windows');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.pickup_windows$$), '0', 'a customer cannot read pickup windows directly');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.pickup_windows$$), '1', 'a restaurant reads their own window');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.pickup_windows where restaurant_id = '77777777-7777-7777-7777-777777777777'$$), '0', 'a restaurant cannot read another window');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with i as (insert into public.pickup_windows (restaurant_id, date, starts_at, ends_at) values ('66666666-6666-6666-6666-666666666666', date '2026-11-23', '2026-11-23 12:00:00+00', '2026-11-23 16:00:00+00') returning 1) select count(*)::text from i$$), '42501', 'a restaurant cannot write a window directly');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.pickup_windows$$), '2', 'an admin can read windows');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$with i as (insert into public.pickup_windows (restaurant_id, date, starts_at, ends_at) values ('66666666-6666-6666-6666-666666666666', date '2026-11-24', '2026-11-24 12:00:00+00', '2026-11-24 16:00:00+00') returning 1) select count(*)::text from i$$), '42501', 'an admin cannot write a window directly');

-- listings
select is(public.rls_exec('anon', null, $$select count(*)::text from public.listings$$), '0', 'anon cannot read listings directly');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.listings$$), '0', 'a customer cannot read listings directly');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.listings$$), '2', 'a restaurant reads their own listings');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.listings where restaurant_id = '77777777-7777-7777-7777-777777777777'$$), '0', 'a restaurant cannot read another restaurant''s listings');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with u as (update public.listings set name = 'Soup renamed' where id = '88888888-8888-8888-8888-888888888888' returning 1) select count(*)::text from u$$), '1', 'a restaurant can update their own listing');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with u as (update public.listings set name = 'Stolen' where id = '99999999-9999-9999-9999-999999999999' returning 1) select count(*)::text from u$$), '0', 'a restaurant cannot update another listing');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with u as (update public.listings set quantity_reserved = 1 where id = '88888888-8888-8888-8888-888888888888' returning 1) select count(*)::text from u$$), '42501', 'a restaurant cannot change quantity_reserved');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with d as (delete from public.listings where id = '88888888-8888-8888-8888-888888888881' returning 1) select count(*)::text from d$$), '1', 'a restaurant can delete their own listing');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with i as (insert into public.listings (restaurant_id, date, name, category_id, original_price, discounted_price, quantity) values ('77777777-7777-7777-7777-777777777777', date '2026-11-22', 'Bad', 1, 20, 8, 1) returning 1) select count(*)::text from i$$), '42501', 'a restaurant cannot insert a listing for someone else');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.listings$$), '2', 'an admin can read listings');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$with u as (update public.listings set name = 'Admin edit' where id = '88888888-8888-8888-8888-888888888888' returning 1) select count(*)::text from u$$), '0', 'an admin cannot edit a listing directly');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with i as (insert into public.listing_tags (listing_id, tag_id) values ('88888888-8888-8888-8888-888888888888', 1) returning 1) select count(*)::text from i$$), '1', 'a restaurant can tag their own listing');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with i as (insert into public.listing_tags (listing_id, tag_id) values ('99999999-9999-9999-9999-999999999999', 1) returning 1) select count(*)::text from i$$), '42501', 'a restaurant cannot tag another restaurant''s listing');

-- orders
select is(public.rls_exec('anon', null, $$select count(*)::text from public.orders$$), '0', 'anon cannot read orders');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.orders$$), '1', 'a customer reads only their order');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.orders where id = 'bbbbbbbb-2222-2222-2222-222222222222'$$), '0', 'a customer cannot read another order');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.orders$$), '1', 'a restaurant reads only their orders');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.orders where restaurant_id = '77777777-7777-7777-7777-777777777777'$$), '0', 'a restaurant cannot read another restaurant''s orders');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.orders$$), '2', 'an admin can read orders');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$with u as (update public.orders set customer_name = 'Changed' where id = 'bbbbbbbb-1111-1111-1111-111111111111' returning 1) select count(*)::text from u$$), '0', 'an admin cannot edit an order directly');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.order_items$$), '1', 'a customer reads only their order items');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.order_items where order_id = 'bbbbbbbb-2222-2222-2222-222222222222'$$), '0', 'a restaurant cannot read another restaurant''s items');
select is(public.rls_exec('anon', null, $$select count(*)::text from public.order_items$$), '0', 'anon cannot read order items');

-- settings, tokens, outbox, audit
select is(public.rls_exec('anon', null, $$select count(*)::text from public.app_settings$$), '0', 'anon cannot read app_settings directly');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.app_settings$$), '0', 'a customer cannot read app_settings directly');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.app_settings$$), '0', 'a restaurant cannot read app_settings directly');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.app_settings$$), '15', 'an admin can read app_settings');
select is((public.rls_exec('anon', null, $$select public.public_settings()::text$$)::jsonb ->> 'currency'), 'AED', 'a guest can read the public currency');
select ok(not ((public.rls_exec('anon', null, $$select public.public_settings()::text$$)::jsonb) ? 'commission_rate'), 'public settings omit the commission rate');
select is(public.rls_exec('anon', null, $$select count(*)::text from public.device_tokens$$), '0', 'anon cannot read device tokens');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$with i as (insert into public.device_tokens (user_id, token, platform) values ('11111111-1111-1111-1111-111111111111', 'token-a', 'android') returning 1) select count(*)::text from i$$), '1', 'a customer can save their own device token');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.device_tokens where token = 'token-b'$$), '0', 'a customer cannot read someone else''s token');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$with d as (delete from public.device_tokens where token = 'token-a' returning 1) select count(*)::text from d$$), '1', 'a customer can delete their own token');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.device_tokens$$), '0', 'an admin cannot read device tokens');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$with i as (insert into public.device_tokens (user_id, token, platform) values ('33333333-3333-3333-3333-333333333333', 'token-r', 'ios') returning 1) select count(*)::text from i$$), '1', 'a restaurant can save their own device token');
select is(public.rls_exec('anon', null, $$select count(*)::text from public.outbox$$), '0', 'anon cannot read the outbox');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.outbox$$), '0', 'a customer cannot read the outbox');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.outbox$$), '0', 'a restaurant cannot read the outbox');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.outbox$$), '1', 'an admin can read the outbox');
select is(public.rls_exec('anon', null, $$select count(*)::text from public.audit_log$$), '0', 'anon cannot read the audit log');
select is(public.rls_exec('authenticated', '11111111-1111-1111-1111-111111111111', $$select count(*)::text from public.audit_log$$), '0', 'a customer cannot read the audit log');
select is(public.rls_exec('authenticated', '33333333-3333-3333-3333-333333333333', $$select count(*)::text from public.audit_log$$), '0', 'a restaurant cannot read the audit log');
select is(public.rls_exec('authenticated', '55555555-5555-5555-5555-555555555555', $$select count(*)::text from public.audit_log$$), '1', 'an admin can read the audit log');

select * from finish();
rollback;
