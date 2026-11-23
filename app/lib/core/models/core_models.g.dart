// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  id: json['id'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  fullName: json['full_name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  termsAcceptedAt: json['terms_accepted_at'] == null
      ? null
      : DateTime.parse(json['terms_accepted_at'] as String),
  status: $enumDecode(_$CustomerStatusEnumMap, json['status']),
  statusChangedAt: json['status_changed_at'] == null
      ? null
      : DateTime.parse(json['status_changed_at'] as String),
  suspensionLiftedAt: json['suspension_lifted_at'] == null
      ? null
      : DateTime.parse(json['suspension_lifted_at'] as String),
  isActive: json['is_active'] as bool,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'id': instance.id,
  'role': _$UserRoleEnumMap[instance.role]!,
  'full_name': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'terms_accepted_at': instance.termsAcceptedAt?.toIso8601String(),
  'status': _$CustomerStatusEnumMap[instance.status]!,
  'status_changed_at': instance.statusChangedAt?.toIso8601String(),
  'suspension_lifted_at': instance.suspensionLiftedAt?.toIso8601String(),
  'is_active': instance.isActive,
  'created_at': instance.createdAt.toIso8601String(),
};

const _$UserRoleEnumMap = {
  UserRole.customer: 'customer',
  UserRole.restaurant: 'restaurant',
  UserRole.admin: 'admin',
};

const _$CustomerStatusEnumMap = {
  CustomerStatus.active: 'active',
  CustomerStatus.warned: 'warned',
  CustomerStatus.suspended: 'suspended',
};

_Area _$AreaFromJson(Map<String, dynamic> json) => _Area(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  location: geoPointRequiredFromJson(json['location']),
  sort: (json['sort'] as num).toInt(),
);

Map<String, dynamic> _$AreaToJson(_Area instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'location': geoPointRequiredToJson(instance.location),
  'sort': instance.sort,
};

_Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => _Restaurant(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  name: json['name'] as String,
  logoPath: json['logo_path'] as String?,
  address: json['address'] as String?,
  placeId: json['place_id'] as String?,
  location: geoPointFromJson(json['location']),
  phone: json['phone'] as String?,
  loginEmail: json['login_email'] as String,
  areaId: (json['area_id'] as num).toInt(),
  status: $enumDecode(_$RestaurantStatusEnumMap, json['status']),
  termsAcceptedAt: json['terms_accepted_at'] == null
      ? null
      : DateTime.parse(json['terms_accepted_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$RestaurantToJson(_Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'logo_path': instance.logoPath,
      'address': instance.address,
      'place_id': instance.placeId,
      'location': geoPointToJson(instance.location),
      'phone': instance.phone,
      'login_email': instance.loginEmail,
      'area_id': instance.areaId,
      'status': _$RestaurantStatusEnumMap[instance.status]!,
      'terms_accepted_at': instance.termsAcceptedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$RestaurantStatusEnumMap = {
  RestaurantStatus.active: 'active',
  RestaurantStatus.suspended: 'suspended',
};

_OpeningHours _$OpeningHoursFromJson(Map<String, dynamic> json) =>
    _OpeningHours(
      restaurantId: json['restaurant_id'] as String,
      weekday: (json['weekday'] as num).toInt(),
      opensAt: json['opens_at'] as String?,
      closesAt: json['closes_at'] as String?,
      isClosed: json['is_closed'] as bool,
    );

Map<String, dynamic> _$OpeningHoursToJson(_OpeningHours instance) =>
    <String, dynamic>{
      'restaurant_id': instance.restaurantId,
      'weekday': instance.weekday,
      'opens_at': instance.opensAt,
      'closes_at': instance.closesAt,
      'is_closed': instance.isClosed,
    };

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  sort: (json['sort'] as num).toInt(),
);

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sort': instance.sort,
};

_DietaryTag _$DietaryTagFromJson(Map<String, dynamic> json) => _DietaryTag(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  sort: (json['sort'] as num).toInt(),
);

Map<String, dynamic> _$DietaryTagToJson(_DietaryTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sort': instance.sort,
    };

_PickupWindow _$PickupWindowFromJson(Map<String, dynamic> json) =>
    _PickupWindow(
      id: json['id'] as String,
      restaurantId: json['restaurant_id'] as String,
      date: json['date'] as String,
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: DateTime.parse(json['ends_at'] as String),
    );

Map<String, dynamic> _$PickupWindowToJson(_PickupWindow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'restaurant_id': instance.restaurantId,
      'date': instance.date,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': instance.endsAt.toIso8601String(),
    };

_Listing _$ListingFromJson(Map<String, dynamic> json) => _Listing(
  id: json['id'] as String,
  restaurantId: json['restaurant_id'] as String,
  date: json['date'] as String,
  name: json['name'] as String,
  categoryId: (json['category_id'] as num).toInt(),
  originalPrice: numericFromJson(json['original_price']),
  discountedPrice: numericFromJson(json['discounted_price']),
  quantity: (json['quantity'] as num).toInt(),
  quantityReserved: (json['quantity_reserved'] as num).toInt(),
  photoPath: json['photo_path'] as String?,
  status: $enumDecode(_$ListingStatusEnumMap, json['status']),
  copiedFromId: json['copied_from_id'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ListingToJson(_Listing instance) => <String, dynamic>{
  'id': instance.id,
  'restaurant_id': instance.restaurantId,
  'date': instance.date,
  'name': instance.name,
  'category_id': instance.categoryId,
  'original_price': numericToJson(instance.originalPrice),
  'discounted_price': numericToJson(instance.discountedPrice),
  'quantity': instance.quantity,
  'quantity_reserved': instance.quantityReserved,
  'photo_path': instance.photoPath,
  'status': _$ListingStatusEnumMap[instance.status]!,
  'copied_from_id': instance.copiedFromId,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};

const _$ListingStatusEnumMap = {
  ListingStatus.draft: 'draft',
  ListingStatus.live: 'live',
  ListingStatus.removed: 'removed',
};

_ListingTag _$ListingTagFromJson(Map<String, dynamic> json) => _ListingTag(
  listingId: json['listing_id'] as String,
  tagId: (json['tag_id'] as num).toInt(),
);

Map<String, dynamic> _$ListingTagToJson(_ListingTag instance) =>
    <String, dynamic>{
      'listing_id': instance.listingId,
      'tag_id': instance.tagId,
    };

_Order _$OrderFromJson(Map<String, dynamic> json) => _Order(
  id: json['id'] as String,
  code: json['code'] as String,
  customerId: json['customer_id'] as String?,
  customerName: json['customer_name'] as String,
  restaurantId: json['restaurant_id'] as String,
  pickupWindowId: json['pickup_window_id'] as String,
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  total: numericFromJson(json['total']),
  commissionRate: numericFromJson(json['commission_rate']),
  commissionAmount: numericFromJson(json['commission_amount']),
  cancelReason: $enumDecodeNullable(
    _$CancelReasonEnumMap,
    json['cancel_reason'],
  ),
  cancelNote: json['cancel_note'] as String?,
  cancelledBy: json['cancelled_by'] as String?,
  reminderSentAt: json['reminder_sent_at'] == null
      ? null
      : DateTime.parse(json['reminder_sent_at'] as String),
  reservedAt: DateTime.parse(json['reserved_at'] as String),
  collectedAt: json['collected_at'] == null
      ? null
      : DateTime.parse(json['collected_at'] as String),
  cancelledAt: json['cancelled_at'] == null
      ? null
      : DateTime.parse(json['cancelled_at'] as String),
  expiredAt: json['expired_at'] == null
      ? null
      : DateTime.parse(json['expired_at'] as String),
);

Map<String, dynamic> _$OrderToJson(_Order instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'customer_id': instance.customerId,
  'customer_name': instance.customerName,
  'restaurant_id': instance.restaurantId,
  'pickup_window_id': instance.pickupWindowId,
  'status': _$OrderStatusEnumMap[instance.status]!,
  'total': numericToJson(instance.total),
  'commission_rate': numericToJson(instance.commissionRate),
  'commission_amount': numericToJson(instance.commissionAmount),
  'cancel_reason': _$CancelReasonEnumMap[instance.cancelReason],
  'cancel_note': instance.cancelNote,
  'cancelled_by': instance.cancelledBy,
  'reminder_sent_at': instance.reminderSentAt?.toIso8601String(),
  'reserved_at': instance.reservedAt.toIso8601String(),
  'collected_at': instance.collectedAt?.toIso8601String(),
  'cancelled_at': instance.cancelledAt?.toIso8601String(),
  'expired_at': instance.expiredAt?.toIso8601String(),
};

const _$OrderStatusEnumMap = {
  OrderStatus.reserved: 'reserved',
  OrderStatus.collected: 'collected',
  OrderStatus.cancelled: 'cancelled',
  OrderStatus.expired: 'expired',
};

const _$CancelReasonEnumMap = {
  CancelReason.soldOut: 'sold_out',
  CancelReason.closingEarly: 'closing_early',
  CancelReason.customerRequest: 'customer_request',
  CancelReason.other: 'other',
};

_OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => _OrderItem(
  orderId: json['order_id'] as String,
  listingId: json['listing_id'] as String,
  name: json['name'] as String,
  unitPrice: numericFromJson(json['unit_price']),
  originalPrice: numericFromJson(json['original_price']),
  quantity: (json['quantity'] as num).toInt(),
  lineTotal: numericFromJson(json['line_total']),
);

Map<String, dynamic> _$OrderItemToJson(_OrderItem instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'listing_id': instance.listingId,
      'name': instance.name,
      'unit_price': numericToJson(instance.unitPrice),
      'original_price': numericToJson(instance.originalPrice),
      'quantity': instance.quantity,
      'line_total': numericToJson(instance.lineTotal),
    };

_DeviceToken _$DeviceTokenFromJson(Map<String, dynamic> json) => _DeviceToken(
  userId: json['user_id'] as String,
  token: json['token'] as String,
  platform: json['platform'] as String,
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$DeviceTokenToJson(_DeviceToken instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'token': instance.token,
      'platform': instance.platform,
      'updated_at': instance.updatedAt.toIso8601String(),
    };

_PublicSettings _$PublicSettingsFromJson(Map<String, dynamic> json) =>
    _PublicSettings(
      currency: json['currency'] as String,
      maxUnitsPerListing: (json['max_units_per_listing'] as num).toInt(),
      maxActiveOrders: (json['max_active_orders'] as num).toInt(),
      supportEmail: json['support_email'] as String,
      pricesIncludeVat: json['prices_include_vat'] as bool,
      searchRadiusM: (json['search_radius_m'] as num).toInt(),
    );

Map<String, dynamic> _$PublicSettingsToJson(_PublicSettings instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'max_units_per_listing': instance.maxUnitsPerListing,
      'max_active_orders': instance.maxActiveOrders,
      'support_email': instance.supportEmail,
      'prices_include_vat': instance.pricesIncludeVat,
      'search_radius_m': instance.searchRadiusM,
    };
