import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';

part 'core_models.freezed.dart';
part 'core_models.g.dart';

enum UserRole { customer, restaurant, admin }

enum CustomerStatus { active, warned, suspended }

enum RestaurantStatus { active, suspended }

enum ListingStatus { draft, live, removed }

enum OrderStatus { reserved, collected, cancelled, expired }

@JsonEnum(fieldRename: FieldRename.snake)
enum CancelReason { soldOut, closingEarly, customerRequest, other }

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String id,
    required UserRole role,
    String? fullName,
    String? email,
    String? phone,
    DateTime? termsAcceptedAt,
    required CustomerStatus status,
    DateTime? statusChangedAt,
    DateTime? suspensionLiftedAt,
    required bool isActive,
    required DateTime createdAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}

@freezed
abstract class Area with _$Area {
  const factory Area({
    required int id,
    required String name,
    @JsonKey(fromJson: geoPointRequiredFromJson, toJson: geoPointRequiredToJson)
    required GeoPoint location,
    required int sort,
  }) = _Area;

  factory Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);
}

@freezed
abstract class Restaurant with _$Restaurant {
  const factory Restaurant({
    required String id,
    required String userId,
    required String name,
    String? logoPath,
    String? address,
    String? placeId,
    @JsonKey(fromJson: geoPointFromJson, toJson: geoPointToJson)
    GeoPoint? location,
    String? phone,
    required String loginEmail,
    required int areaId,
    required RestaurantStatus status,
    DateTime? termsAcceptedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
}

@freezed
abstract class OpeningHours with _$OpeningHours {
  const factory OpeningHours({
    required String restaurantId,
    required int weekday,
    String? opensAt,
    String? closesAt,
    required bool isClosed,
  }) = _OpeningHours;

  factory OpeningHours.fromJson(Map<String, dynamic> json) =>
      _$OpeningHoursFromJson(json);
}

@freezed
abstract class Category with _$Category {
  const factory Category({
    required int id,
    required String name,
    required int sort,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
abstract class DietaryTag with _$DietaryTag {
  const factory DietaryTag({
    required int id,
    required String name,
    required int sort,
  }) = _DietaryTag;

  factory DietaryTag.fromJson(Map<String, dynamic> json) =>
      _$DietaryTagFromJson(json);
}

@freezed
abstract class PickupWindow with _$PickupWindow {
  const factory PickupWindow({
    required String id,
    required String restaurantId,
    required String date,
    required DateTime startsAt,
    required DateTime endsAt,
  }) = _PickupWindow;

  factory PickupWindow.fromJson(Map<String, dynamic> json) =>
      _$PickupWindowFromJson(json);
}

@freezed
abstract class Listing with _$Listing {
  const factory Listing({
    required String id,
    required String restaurantId,
    required String date,
    required String name,
    required int categoryId,
    @JsonKey(fromJson: numericFromJson, toJson: numericToJson)
    required String originalPrice,
    @JsonKey(fromJson: numericFromJson, toJson: numericToJson)
    required String discountedPrice,
    required int quantity,
    required int quantityReserved,
    String? photoPath,
    required ListingStatus status,
    String? copiedFromId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Listing;

  factory Listing.fromJson(Map<String, dynamic> json) =>
      _$ListingFromJson(json);
}

@freezed
abstract class ListingTag with _$ListingTag {
  const factory ListingTag({
    required String listingId,
    required int tagId,
  }) = _ListingTag;

  factory ListingTag.fromJson(Map<String, dynamic> json) =>
      _$ListingTagFromJson(json);
}

@freezed
abstract class Order with _$Order {
  const factory Order({
    required String id,
    required String code,
    String? customerId,
    required String customerName,
    required String restaurantId,
    required String pickupWindowId,
    required OrderStatus status,
    @JsonKey(fromJson: numericFromJson, toJson: numericToJson)
    required String total,
    @JsonKey(fromJson: numericFromJson, toJson: numericToJson)
    required String commissionRate,
    @JsonKey(fromJson: numericFromJson, toJson: numericToJson)
    required String commissionAmount,
    CancelReason? cancelReason,
    String? cancelNote,
    String? cancelledBy,
    DateTime? reminderSentAt,
    required DateTime reservedAt,
    DateTime? collectedAt,
    DateTime? cancelledAt,
    DateTime? expiredAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
abstract class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String orderId,
    required String listingId,
    required String name,
    @JsonKey(fromJson: numericFromJson, toJson: numericToJson)
    required String unitPrice,
    @JsonKey(fromJson: numericFromJson, toJson: numericToJson)
    required String originalPrice,
    required int quantity,
    @JsonKey(fromJson: numericFromJson, toJson: numericToJson)
    required String lineTotal,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

@freezed
abstract class DeviceToken with _$DeviceToken {
  const factory DeviceToken({
    required String userId,
    required String token,
    required String platform,
    required DateTime updatedAt,
  }) = _DeviceToken;

  factory DeviceToken.fromJson(Map<String, dynamic> json) =>
      _$DeviceTokenFromJson(json);
}

/// The keys returned by `public_settings()`. Commission is not in this object.
@freezed
abstract class PublicSettings with _$PublicSettings {
  const factory PublicSettings({
    required String currency,
    required int maxUnitsPerListing,
    required int maxActiveOrders,
    required String supportEmail,
    required bool pricesIncludeVat,
    required int searchRadiusM,
  }) = _PublicSettings;

  factory PublicSettings.fromJson(Map<String, dynamic> json) =>
      _$PublicSettingsFromJson(json);
}
