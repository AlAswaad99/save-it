begin;
select plan(14);

select ok(
  not has_function_privilege(
    'anon',
    'public.complete_profile(text, text, boolean)',
    'execute'
  ),
  'anon cannot complete a profile'
);
select ok(
  has_function_privilege(
    'authenticated',
    'public.complete_profile(text, text, boolean)',
    'execute'
  ),
  'a signed-in user can call complete_profile'
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
    'cccccccc-cccc-cccc-cccc-ccccccccccc1',
    'authenticated', 'authenticated', 'new@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', '', ''
  ),
  (
    '00000000-0000-0000-0000-000000000000',
    'cccccccc-cccc-cccc-cccc-ccccccccccc2',
    'authenticated', 'authenticated', 'kitchen@example.com',
    extensions.crypt('test-password', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', '', ''
  );

update public.profiles
set role = 'restaurant'
where id = 'cccccccc-cccc-cccc-cccc-ccccccccccc2';

select set_config('app.fake_now', '2026-11-23 12:00:00+00', true);

select throws_ok(
  $$select public.complete_profile('Ada', '+971501234567', true)$$,
  'P0001',
  'SI001',
  'a caller with no session is rejected'
);

select set_config(
  'request.jwt.claims',
  json_build_object(
    'sub', 'cccccccc-cccc-cccc-cccc-ccccccccccc2',
    'role', 'authenticated'
  )::text,
  true
);
select throws_ok(
  $$select public.complete_profile('Kitchen', '+971501234567', true)$$,
  'P0001',
  'SI001',
  'a restaurant login cannot complete a customer profile'
);

select set_config(
  'request.jwt.claims',
  json_build_object(
    'sub', 'cccccccc-cccc-cccc-cccc-ccccccccccc1',
    'role', 'authenticated'
  )::text,
  true
);
select throws_ok(
  $$select public.complete_profile('Ada', '+971501234567', false)$$,
  'P0001',
  'SI051',
  'terms must be accepted'
);
select throws_ok(
  $$select public.complete_profile(' ', '+971501234567', true)$$,
  'P0001',
  'SI051',
  'a name is required'
);
select throws_ok(
  $$select public.complete_profile('Ada', '0501234567', true)$$,
  'P0001',
  'SI051',
  'the phone has to be E.164'
);
select ok(
  (
    select full_name is null and phone is null and terms_accepted_at is null
    from public.profiles
    where id = 'cccccccc-cccc-cccc-cccc-ccccccccccc1'
  ),
  'a rejected call leaves the profile empty'
);

select lives_ok(
  $$select public.complete_profile('Ada', '+971501234567', true)$$,
  'a new customer can complete the profile'
);
select ok(
  (
    select full_name = 'Ada'
      and phone = '+971501234567'
      and terms_accepted_at = timestamptz '2026-11-23 12:00:00+00'
    from public.profiles
    where id = 'cccccccc-cccc-cccc-cccc-ccccccccccc1'
  ),
  'name, phone, and terms are stored'
);
select is(
  (
    select payload
    from public.outbox
    where template = 'welcome'
      and recipient_user_id = 'cccccccc-cccc-cccc-cccc-ccccccccccc1'
  ),
  jsonb_build_object(
    'name', 'Ada',
    'email', 'new@example.com',
    'support_email', 'contact@arisehub.org',
    'subject', 'You''re in! Welcome to Save It'
  ),
  'the welcome email is queued once with the support address'
);

select lives_ok(
  $$select public.complete_profile('Ada L', '+971509876543', true)$$,
  'completing the profile again updates the contact details'
);
select is(
  (select count(*) from public.outbox where template = 'welcome'),
  1::bigint,
  'a second completion does not queue another welcome'
);
select set_config('app.trusted_profile_write', 'off', true);
select throws_ok(
  $$
    update public.profiles
    set terms_accepted_at = timestamptz '2026-11-23 13:00:00+00'
    where id = 'cccccccc-cccc-cccc-cccc-ccccccccccc1'
  $$,
  'P0001',
  'SI001',
  'the customer cannot write terms_accepted_at directly'
);

select * from finish();
rollback;
