begin;
select plan(33);

select has_table('public', 'pickup_windows', 'pickup_windows exists');
select has_table('public', 'listings', 'listings exists');
select has_table('public', 'listing_tags', 'listing_tags exists');
select has_table('public', 'orders', 'orders exists');
select has_table('public', 'order_items', 'order_items exists');
select has_table('public', 'device_tokens', 'device_tokens exists');
select has_table('public', 'outbox', 'outbox exists');
select has_table('public', 'audit_log', 'audit_log exists');

select columns_are(
  'public',
  'pickup_windows',
  array['id', 'restaurant_id', 'date', 'starts_at', 'ends_at']
);
select columns_are(
  'public',
  'listings',
  array[
    'id',
    'restaurant_id',
    'date',
    'name',
    'category_id',
    'original_price',
    'discounted_price',
    'quantity',
    'quantity_reserved',
    'photo_path',
    'status',
    'copied_from_id',
    'created_at',
    'updated_at'
  ]
);
select columns_are(
  'public',
  'order_items',
  array[
    'order_id',
    'listing_id',
    'name',
    'unit_price',
    'original_price',
    'quantity',
    'line_total'
  ]
);
select columns_are(
  'public',
  'orders',
  array[
    'id',
    'code',
    'customer_id',
    'customer_name',
    'restaurant_id',
    'pickup_window_id',
    'status',
    'total',
    'commission_rate',
    'commission_amount',
    'cancel_reason',
    'cancel_note',
    'cancelled_by',
    'reminder_sent_at',
    'reserved_at',
    'collected_at',
    'cancelled_at',
    'expired_at'
  ]
);

select col_type_is('public', 'orders', 'total', 'numeric(10,2)', 'order total is numeric(10,2)');
select col_type_is(
  'public',
  'orders',
  'commission_rate',
  'numeric(5,4)',
  'commission rate is numeric(5,4)'
);
select col_type_is(
  'public',
  'listings',
  'discounted_price',
  'numeric(10,2)',
  'listing price is numeric(10,2)'
);
select col_type_is('public', 'orders', 'code', 'character(6)', 'order code is char(6)');
select col_type_is(
  'public',
  'pickup_windows',
  'starts_at',
  'timestamp with time zone',
  'window bounds are timestamptz'
);

select ok(
  exists (select 1 from pg_constraint where conname = 'pickup_windows_one_per_day'),
  'one pickup window per restaurant per day'
);
select ok(
  exists (select 1 from pg_constraint where conname = 'pickup_windows_order'),
  'window start is before window end'
);
select ok(
  exists (select 1 from pg_constraint where conname = 'pickup_windows_same_day'),
  'window bounds fall on the window date in Asia/Dubai'
);
select ok(
  exists (select 1 from pg_constraint where conname = 'listings_stock'),
  'reserved quantity cannot exceed stock'
);
select ok(
  exists (select 1 from pg_constraint where conname = 'orders_code_alphabet'),
  'order codes use the unambiguous alphabet'
);
select ok(
  exists (select 1 from pg_constraint where conname = 'orders_other_needs_note'),
  'cancel reason other requires a note'
);

select has_index('public', 'restaurants', 'restaurants_location_idx', 'restaurant location gist index');
select has_index('public', 'listings', 'listings_restaurant_date_status_idx', 'listing lookup index');
select has_index('public', 'orders', 'orders_customer_status_idx', 'customer order index');
select has_index('public', 'orders', 'orders_restaurant_reserved_idx', 'restaurant order index');
select has_index('public', 'orders', 'orders_status_window_idx', 'expiry job index');
select has_index('public', 'pickup_windows', 'pickup_windows_date_ends_idx', 'window end index');
select has_index('public', 'outbox', 'outbox_state_next_idx', 'outbox dispatch index');
select has_index('public', 'profiles', 'profiles_email_lower_idx', 'profile email index');
select has_index('public', 'profiles', 'profiles_phone_idx', 'profile phone index');
select has_index('public', 'profiles', 'profiles_full_name_trgm_idx', 'profile name trigram index');

select * from finish();
rollback;
