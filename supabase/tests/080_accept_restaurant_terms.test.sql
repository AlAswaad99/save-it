begin;
select plan(9);

select ok(
  not has_function_privilege('anon', 'public.accept_restaurant_terms()', 'execute'),
  'anon cannot accept restaurant terms'
);
select ok(
  has_function_privilege(
    'authenticated',
    'public.accept_restaurant_terms()',
    'execute'
  ),
  'a signed-in user can call accept_restaurant_terms'
);

insert into auth.users (
  instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at,
  confirmation_token, email_change, email_change_token_new,
  email_change_token_current, recovery_token
)
values
  (
    '00000000-0000-0000-0000-000000000000',
    'dddddddd-dddd-dddd-dddd-ddddddddddd1',
    'authenticated', 'authenticated', 'diner@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', '', ''
  ),
  (
    '00000000-0000-0000-0000-000000000000',
    'dddddddd-dddd-dddd-dddd-ddddddddddd2',
    'authenticated', 'authenticated', 'kitchen2@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', '', ''
  ),
  (
    '00000000-0000-0000-0000-000000000000',
    'dddddddd-dddd-dddd-dddd-ddddddddddd3',
    'authenticated', 'authenticated', 'norow@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', '', ''
  );

update public.profiles
set role = 'restaurant'
where id in (
  'dddddddd-dddd-dddd-dddd-ddddddddddd2',
  'dddddddd-dddd-dddd-dddd-ddddddddddd3'
);

insert into public.restaurants (id, user_id, name, login_email, area_id, location)
values (
  'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee1',
  'dddddddd-dddd-dddd-dddd-ddddddddddd2',
  'Olive Grove Bakery',
  'kitchen2@example.com',
  1,
  extensions.st_setsrid(extensions.st_makepoint(54.37, 24.45), 4326)::extensions.geography
);

select set_config('app.fake_now', '2026-11-23 12:00:00+00', true);

select throws_ok(
  $$select public.accept_restaurant_terms()$$,
  'P0001',
  'SI001',
  'a caller with no session is rejected'
);

select set_config(
  'request.jwt.claims',
  json_build_object(
    'sub', 'dddddddd-dddd-dddd-dddd-ddddddddddd1',
    'role', 'authenticated'
  )::text,
  true
);
select throws_ok(
  $$select public.accept_restaurant_terms()$$,
  'P0001',
  'SI001',
  'a customer cannot accept restaurant terms'
);

select set_config(
  'request.jwt.claims',
  json_build_object(
    'sub', 'dddddddd-dddd-dddd-dddd-ddddddddddd3',
    'role', 'authenticated'
  )::text,
  true
);
select throws_ok(
  $$select public.accept_restaurant_terms()$$,
  'P0001',
  'SI001',
  'a restaurant login without a restaurant row is rejected'
);

select set_config(
  'request.jwt.claims',
  json_build_object(
    'sub', 'dddddddd-dddd-dddd-dddd-ddddddddddd2',
    'role', 'authenticated'
  )::text,
  true
);
select lives_ok(
  $$select public.accept_restaurant_terms()$$,
  'the restaurant accepts the terms'
);
select is(
  (
    select terms_accepted_at
    from public.restaurants
    where id = 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee1'
  ),
  '2026-11-23 12:00:00+00'::timestamptz,
  'terms_accepted_at is the app clock'
);

select set_config('app.fake_now', '2026-11-23 18:00:00+00', true);
select lives_ok(
  $$select public.accept_restaurant_terms()$$,
  'accepting again is allowed'
);
select is(
  (
    select terms_accepted_at
    from public.restaurants
    where id = 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeee1'
  ),
  '2026-11-23 12:00:00+00'::timestamptz,
  'the first acceptance time stays'
);

select * from finish();
rollback;
