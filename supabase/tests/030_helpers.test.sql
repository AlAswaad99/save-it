begin;
select plan(22);

select set_config('app.fake_now', '2026-11-21 23:30:00+00', true);
select is(
  public.app_today(),
  date '2026-11-22',
  '23:30 UTC is the next date in Asia/Dubai'
);

select set_config('app.fake_now', '2026-11-21 19:00:00+00', true);
select is(
  public.app_today(),
  date '2026-11-21',
  '19:00 UTC is still 23:00 on that Dubai date'
);

select is(
  public.setting('commission_rate'),
  '0.40'::jsonb,
  'setting reads commission_rate'
);
select ok(
  not has_function_privilege('anon', 'public.setting(text)', 'execute'),
  'anon cannot read app_settings through setting()'
);
select ok(
  has_function_privilege('service_role', 'public.setting(text)', 'execute'),
  'service role can read app_settings through setting()'
);

insert into auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at,
  confirmation_token,
  email_change,
  email_change_token_new,
  email_change_token_current,
  recovery_token
)
values
  (
    '00000000-0000-0000-0000-000000000000',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
    'authenticated',
    'authenticated',
    'cust@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')),
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now(),
    '',
    '',
    '',
    '',
    ''
  ),
  (
    '00000000-0000-0000-0000-000000000000',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
    'authenticated',
    'authenticated',
    'rest@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')),
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{"role":"restaurant"}'::jsonb,
    now(),
    now(),
    '',
    '',
    '',
    '',
    ''
  ),
  (
    '00000000-0000-0000-0000-000000000000',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3',
    'authenticated',
    'authenticated',
    'admin@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')),
    now(),
    '{"provider":"email","providers":["email"]}'::jsonb,
    '{}'::jsonb,
    now(),
    now(),
    '',
    '',
    '',
    '',
    ''
  );

select is(
  (select role::text from public.profiles where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2'),
  'customer',
  'first sign-in always starts as a customer'
);
select ok(
  (
    select full_name is null and phone is null and terms_accepted_at is null
    from public.profiles
    where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1'
  ),
  'a new profile has no name, phone, or terms acceptance'
);
select is(
  (select email from public.profiles where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1'),
  'cust@example.com',
  'the profile copies the auth email'
);
select has_trigger(
  'auth',
  'users',
  'on_auth_user_created',
  'auth insert creates the profile'
);

select ok(
  (
    select bool_and(code ~ '^[ABCDEFGHJKLMNPQRSTUVWXYZ23456789]{6}$')
    from (
      select public.generate_order_code() as code
      from generate_series(1, 30)
    ) as codes
  ),
  'generated codes are 6 safe characters'
);

update public.profiles
set role = 'restaurant'
where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2';

insert into public.restaurants (id, user_id, name, login_email, area_id, location)
values (
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
  'Test Kitchen',
  'rest@example.com',
  1,
  extensions.st_setsrid(extensions.st_makepoint(54.37, 24.45), 4326)::extensions.geography
);

insert into public.opening_hours (restaurant_id, weekday, opens_at, closes_at, is_closed)
values
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 6, '18:00', '02:00', false),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 0, null, null, true),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 1, '10:00', '22:00', false);

-- Saturday 18:00–02:00. Sunday is closed. Monday is 10:00–22:00.
select set_config('app.fake_now', '2026-11-21 21:30:00+00', true);
select is(
  public.is_open_now('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1'),
  true,
  'overnight hours are still open at 01:30 Dubai'
);

select set_config('app.fake_now', '2026-11-21 22:30:00+00', true);
select is(
  public.is_open_now('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1'),
  false,
  'overnight hours are closed at 02:30 Dubai'
);

select set_config('app.fake_now', '2026-11-22 15:00:00+00', true);
select is(
  public.is_open_now('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1'),
  false,
  'a closed weekday stays closed in the evening'
);

select set_config('app.fake_now', '2026-11-23 06:00:00+00', true);
select is(
  public.is_open_now('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1'),
  true,
  'a same-day span is open at the opening time'
);

select set_config('app.fake_now', '2026-11-23 05:59:00+00', true);
select is(
  public.is_open_now('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1'),
  false,
  'a same-day span is closed one minute before opening'
);

select set_config('app.fake_now', '2026-11-23 18:00:00+00', true);
select is(
  public.is_open_now('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1'),
  false,
  'a same-day span is closed at the closing time'
);

select set_config('app.fake_now', '2026-11-23 17:59:00+00', true);
select is(
  public.is_open_now('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1'),
  true,
  'a same-day span is open one minute before closing'
);

update public.profiles
set role = 'admin'
where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3';

select set_config(
  'request.jwt.claims',
  json_build_object(
    'sub', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3',
    'role', 'authenticated'
  )::text,
  true
);
select is(public.is_admin(), true, 'an active admin is recognised');

update public.profiles
set is_active = false
where id = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3';
select is(public.is_admin(), false, 'a deactivated admin is not an admin');

select set_config(
  'request.jwt.claims',
  json_build_object(
    'sub', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1',
    'role', 'authenticated'
  )::text,
  true
);
select is(public.is_admin(), false, 'a customer is not an admin');
select is(public.my_restaurant_id(), null, 'a customer has no restaurant');

select set_config(
  'request.jwt.claims',
  json_build_object(
    'sub', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2',
    'role', 'authenticated'
  )::text,
  true
);
select is(
  public.my_restaurant_id(),
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbb1'::uuid,
  'my_restaurant_id follows the restaurant login'
);

select * from finish();
rollback;
