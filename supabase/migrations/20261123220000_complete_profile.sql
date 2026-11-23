-- T04.4. complete_profile fills a new customer and queues the welcome email.
-- The column guard blocks terms_accepted_at unless this function marks the write.

create or replace function public.complete_profile(
  full_name text,
  phone text,
  accept_terms boolean
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  caller uuid := auth.uid();
  caller_role public.user_role;
  trimmed_name text := nullif(btrim(full_name), '');
  already timestamptz;
  customer_email text;
  support text;
begin
  if caller is null then
    raise exception using errcode = 'P0001', message = 'SI001';
  end if;

  select profiles.role, profiles.terms_accepted_at, profiles.email
  into caller_role, already, customer_email
  from public.profiles
  where profiles.id = caller;

  if caller_role is distinct from 'customer' then
    raise exception using errcode = 'P0001', message = 'SI001';
  end if;

  if accept_terms is not true
    or trimmed_name is null
    or phone is null
    or phone !~ '^\+[1-9][0-9]{6,14}$'
  then
    raise exception using errcode = 'P0001', message = 'SI051';
  end if;

  perform set_config('app.trusted_profile_write', 'on', true);

  update public.profiles
  set
    full_name = trimmed_name,
    phone = complete_profile.phone,
    terms_accepted_at = coalesce(profiles.terms_accepted_at, public.app_now())
  where profiles.id = caller;

  if already is not null then
    return;
  end if;

  support := public.setting('support_email') #>> '{}';
  insert into public.outbox (channel, recipient_user_id, template, payload)
  values (
    'email',
    caller,
    'welcome',
    jsonb_build_object(
      'name', trimmed_name,
      'email', customer_email,
      'support_email', support,
      'subject', 'You''re in! Welcome to Save It'
    )
  );
end;
$$;

comment on function public.complete_profile(text, text, boolean) is
  'Fills name, phone, and terms for the signed-in customer and queues welcome once.';

revoke all on function public.complete_profile(text, text, boolean) from public;
grant execute on function public.complete_profile(text, text, boolean) to authenticated;
