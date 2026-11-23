begin;
select plan(8);

select ok(
  not has_function_privilege('anon', 'public.reserve_login_code(text)', 'execute'),
  'anon cannot reserve a login code'
);
select ok(
  not has_function_privilege('authenticated', 'public.reserve_login_code(text)', 'execute'),
  'authenticated cannot reserve a login code'
);
select ok(
  has_function_privilege('service_role', 'public.reserve_login_code(text)', 'execute'),
  'the email function can reserve a login code'
);

select set_config('app.fake_now', '2026-11-22 12:00:00+00', true);

select is(
  (public.reserve_login_code('Ada@Example.com') ->> 'ok')::boolean,
  true,
  'the first code in an hour is allowed'
);
select is(
  (public.reserve_login_code('ada@example.com') ->> 'ok')::boolean,
  true,
  'the second code in an hour is allowed'
);
select is(
  (public.reserve_login_code('ada@example.com') ->> 'ok')::boolean,
  true,
  'the third code in an hour is allowed'
);
select is(
  public.reserve_login_code('ADA@example.com') ->> 'code',
  'SI050',
  'the fourth code within an hour returns SI050'
);

select set_config('app.fake_now', '2026-11-22 13:00:01+00', true);
select is(
  (public.reserve_login_code('ada@example.com') ->> 'ok')::boolean,
  true,
  'a code is allowed again once the hour has passed'
);

select * from finish();
rollback;
