// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(time) => "Selected: ${time}";

  static String m1(hours, minutes) => "Total Duration: ${hours}h ${minutes}";

  static String m2(hours) => "${hours} hours";

  static String m3(country) => "Location: ${country}";

  static String m4(price) => "\$${price}";

  static String m5(rating, reviews) => "${rating} (${reviews} reviews)";

  static String m6(status) => "Booking status updated to ${status}";

  static String m7(hours) => "Duration must be at least ${hours} hours";

  static String m8(hours) => "Minimum: ${hours} hours";

  static String m9(hours) => "${hours} hours";

  static String m10(rate) => "\$${rate}/hour";

  static String m11(meters) => "Location accuracy: ±${meters} meters";

  static String m12(price, unit) => "\$${price}/${unit}";

  static String m13(startTime, endTime) =>
      "Available time slot: ${startTime} - ${endTime}";

  static String m14(price) => "\$${price}";

  static String m15(label) => "${label}";

  static String m16(registration) => "Business Registration: ${registration}";

  static String m17(message) => "Error: ${message}";

  static String m18(message) => "Error loading services: ${message}";

  static String m19(hours) => "${hours} hours";

  static String m20(price) => "\$${price}";

  static String m21(error) => "Failed to pick image: ${error}";

  static String m22(error) => "Failed to upload image: ${error}";

  static String m23(error) => "Failed to pick image: ${error}";

  static String m24(error) => "Failed to upload image: ${error}";

  static String m25(category) => "${category}";

  static String m26(count, favoriteText) => "${count} ${favoriteText}";

  static String m27(hours) => "${hours} hrs";

  static String m28(message) => "Error: ${message}";

  static String m29(name) => "Hi, ${name}";

  static String m30(location) => "${location}";

  static String m31(language) => "Language changed to ${language}";

  static String m32(count) => "All Reviews (${count})";

  static String m33(serviceName) =>
      "Are you sure you want to cancel your booking for ${serviceName}?";

  static String m34(message) => "Error: ${message}";

  static String m35(message) => "Failed to submit review: ${message}";

  static String m36(serviceName) => "How would you rate ${serviceName}?";

  static String m37(status) => "${status}";

  static String m38(userEmail) =>
      "We have sent verification code to ${userEmail}";

  static String m39(date) => "Last updated: ${date}";

  static String m40(message) => "Error: ${message}";

  static String m41(id) => "The Reference Id: ${id}";

  static String m42(price, duration) => "\$${price}/${duration} month(s)";

  static String m43(status) => "Status: ${status}";

  static String m44(hours) => "${hours} hrs";

  static String m45(query) => "Search Results for \"${query}\"";

  static String m46(hours) => "${hours} hours";

  static String m47(categoryName) =>
      "Browse our ${categoryName} services in this category.";

  static String m48(categoryName) => "${categoryName}";

  static String m49(category) =>
      "We currently have no ${category} services available";

  static String m50(count) => "${count} Services Available";

  static String m51(count) => "All Reviews (${count})";

  static String m52(count) => "Based on ${count} reviews";

  static String m53(hours) => "${hours} hours";

  static String m54(message) => "Error: ${message}";

  static String m55(rating, count) => "${rating} (${count} reviews)";

  static String m56(count) => "${count} reviews";

  static String m57(count) => "View all ${count} reviews";

  static String m58(duration, price) => "${duration} hrs • ${price}";

  static String m59(firstName) => "Call ${firstName}";

  static String m60(phoneNumber) => "Could not launch ${phoneNumber}";

  static String m61(message) => "Error: ${message}";

  static String m62(filter) => "No ${filter} bookings";

  static String m63(date) => "You have no scheduled services for ${date}";

  static String m64(status) => "Payment: ${status}";

  static String m65(clientName) => "with ${clientName}";

  static String m66(date) => "No bookings on ${date}";

  static String m67(key) => "${key}";

  static String m68(date) => "Last updated: ${date}";

  static String m69(jurisdiction) =>
      "These terms are governed by the laws of ${jurisdiction}. Any disputes shall be resolved in the courts of ${jurisdiction}.";

  static String m70(idThanSendOTPTo) =>
      "We have sent verification code to ${idThanSendOTPTo}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "actionButtonsActivate":
            MessageLookupByLibrary.simpleMessage("Activate Service"),
        "actionButtonsDeactivate":
            MessageLookupByLibrary.simpleMessage("Deactivate Service"),
        "actionButtonsDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "actionButtonsEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "addOption": MessageLookupByLibrary.simpleMessage("Add Option"),
        "addPaymentMethodScreenCardNumberError":
            MessageLookupByLibrary.simpleMessage("Card number is required"),
        "addPaymentMethodScreenCardNumberHint":
            MessageLookupByLibrary.simpleMessage("Enter Card Number"),
        "addPaymentMethodScreenCardNumberInvalidError":
            MessageLookupByLibrary.simpleMessage(
                "Enter a valid 16-digit card number"),
        "addPaymentMethodScreenCardNumberLabel":
            MessageLookupByLibrary.simpleMessage("Card Number"),
        "addPaymentMethodScreenContinueButton":
            MessageLookupByLibrary.simpleMessage("Continue"),
        "addPaymentMethodScreenCvvError":
            MessageLookupByLibrary.simpleMessage("CVV is required"),
        "addPaymentMethodScreenCvvHint":
            MessageLookupByLibrary.simpleMessage("CVV"),
        "addPaymentMethodScreenCvvInvalidError":
            MessageLookupByLibrary.simpleMessage(
                "Enter a valid 3 or 4-digit CVV"),
        "addPaymentMethodScreenCvvLabel":
            MessageLookupByLibrary.simpleMessage("CVV"),
        "addPaymentMethodScreenExpiryDateHint":
            MessageLookupByLibrary.simpleMessage("MM/YY"),
        "addPaymentMethodScreenExpiryDateLabel":
            MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "addPaymentMethodScreenNameError":
            MessageLookupByLibrary.simpleMessage("Name is required"),
        "addPaymentMethodScreenNameHint":
            MessageLookupByLibrary.simpleMessage("Enter Name"),
        "addPaymentMethodScreenNameLabel":
            MessageLookupByLibrary.simpleMessage("Name"),
        "addPaymentMethodScreenTermsError":
            MessageLookupByLibrary.simpleMessage(
                "You must agree to the Terms and Conditions"),
        "addPaymentMethodScreenTermsLabel":
            MessageLookupByLibrary.simpleMessage(
                "I agree to the Terms and Conditions"),
        "addPaymentMethodScreenTitle":
            MessageLookupByLibrary.simpleMessage("Add Payment Method"),
        "addServiceScreenAddTimeSlotButton":
            MessageLookupByLibrary.simpleMessage("Add Time Slot"),
        "addServiceScreenAddedTimeSlotsLabel":
            MessageLookupByLibrary.simpleMessage("Added Time Slots:"),
        "addServiceScreenAmLabel": MessageLookupByLibrary.simpleMessage("AM"),
        "addServiceScreenAvailabilitySection":
            MessageLookupByLibrary.simpleMessage("Availability"),
        "addServiceScreenAvailableDaysError":
            MessageLookupByLibrary.simpleMessage(
                "Please select at least one available day"),
        "addServiceScreenAvailableDaysLabel":
            MessageLookupByLibrary.simpleMessage("Available Days"),
        "addServiceScreenDayFriday":
            MessageLookupByLibrary.simpleMessage("Friday"),
        "addServiceScreenDayMonday":
            MessageLookupByLibrary.simpleMessage("Monday"),
        "addServiceScreenDaySaturday":
            MessageLookupByLibrary.simpleMessage("Saturday"),
        "addServiceScreenDaySunday":
            MessageLookupByLibrary.simpleMessage("Sunday"),
        "addServiceScreenDayThursday":
            MessageLookupByLibrary.simpleMessage("Thursday"),
        "addServiceScreenDayTuesday":
            MessageLookupByLibrary.simpleMessage("Tuesday"),
        "addServiceScreenDayWednesday":
            MessageLookupByLibrary.simpleMessage("Wednesday"),
        "addServiceScreenDescriptionEmptyError":
            MessageLookupByLibrary.simpleMessage("Please enter a description"),
        "addServiceScreenDescriptionHint": MessageLookupByLibrary.simpleMessage(
            "Describe your service in detail..."),
        "addServiceScreenDescriptionLabel":
            MessageLookupByLibrary.simpleMessage("Description"),
        "addServiceScreenDescriptionLengthError":
            MessageLookupByLibrary.simpleMessage(
                "Description should be at least 30 characters"),
        "addServiceScreenDurationSection":
            MessageLookupByLibrary.simpleMessage("Service Duration"),
        "addServiceScreenEndTimeLabel":
            MessageLookupByLibrary.simpleMessage("End Time"),
        "addServiceScreenEstimatedDurationLabel":
            MessageLookupByLibrary.simpleMessage("Estimated Service Duration"),
        "addServiceScreenFixedPriceLabel":
            MessageLookupByLibrary.simpleMessage("Fixed Price (\$)"),
        "addServiceScreenHourLabel":
            MessageLookupByLibrary.simpleMessage("Hour"),
        "addServiceScreenHoursLabel":
            MessageLookupByLibrary.simpleMessage("Hours"),
        "addServiceScreenMinuteLabel":
            MessageLookupByLibrary.simpleMessage("Minute"),
        "addServiceScreenMinutesLabel":
            MessageLookupByLibrary.simpleMessage("Minutes"),
        "addServiceScreenMonthlyPriceLabel":
            MessageLookupByLibrary.simpleMessage("Monthly Price (\$)"),
        "addServiceScreenPmLabel": MessageLookupByLibrary.simpleMessage("PM"),
        "addServiceScreenPriceEmptyError":
            MessageLookupByLibrary.simpleMessage("Please enter a price"),
        "addServiceScreenPriceInvalidError":
            MessageLookupByLibrary.simpleMessage("Please enter a valid number"),
        "addServiceScreenPricingFixedExample":
            MessageLookupByLibrary.simpleMessage(
                "Example: \$150 for a complete deep Service service"),
        "addServiceScreenPricingHourlyExample":
            MessageLookupByLibrary.simpleMessage(
                "Example: \$40/hour (typically 2-4 hours depending on home size)"),
        "addServiceScreenPricingMonthlyExample":
            MessageLookupByLibrary.simpleMessage(
                "Example: \$400 per month for comprehensive service"),
        "addServiceScreenPricingSection":
            MessageLookupByLibrary.simpleMessage("Pricing"),
        "addServiceScreenPricingWeeklyExample":
            MessageLookupByLibrary.simpleMessage(
                "Example: \$120 per week for regular maintenance"),
        "addServiceScreenPublishButton":
            MessageLookupByLibrary.simpleMessage("Publish Service"),
        "addServiceScreenRecurringDaysInfo":
            MessageLookupByLibrary.simpleMessage(
                "Recurring services are available all days of the week"),
        "addServiceScreenSelectedTime": m0,
        "addServiceScreenServiceNameError":
            MessageLookupByLibrary.simpleMessage("Please enter a service name"),
        "addServiceScreenServiceNameHint": MessageLookupByLibrary.simpleMessage(
            "e.g., Deep Service, Weekly Maintenance"),
        "addServiceScreenServiceNameLabel":
            MessageLookupByLibrary.simpleMessage("Service Name"),
        "addServiceScreenServiceTypeLabel":
            MessageLookupByLibrary.simpleMessage("Service Type"),
        "addServiceScreenServiceTypeOneTime":
            MessageLookupByLibrary.simpleMessage("One Time"),
        "addServiceScreenServiceTypeOneTimeExplanation":
            MessageLookupByLibrary.simpleMessage(
                "One-time service is performed once and completed. Ideal for specific Service needs like move-in/move-out Service."),
        "addServiceScreenServiceTypeRecurring":
            MessageLookupByLibrary.simpleMessage("Recurring"),
        "addServiceScreenServiceTypeRecurringExplanation":
            MessageLookupByLibrary.simpleMessage(
                "Recurring service repeats at regular intervals. Perfect for regular maintenance like weekly or monthly Service."),
        "addServiceScreenServiceTypeSection":
            MessageLookupByLibrary.simpleMessage("Service Type"),
        "addServiceScreenStartTimeLabel":
            MessageLookupByLibrary.simpleMessage("Start Time"),
        "addServiceScreenSubTypeDeep":
            MessageLookupByLibrary.simpleMessage("Deep Service"),
        "addServiceScreenSubTypeDeepExplanation":
            MessageLookupByLibrary.simpleMessage(
                "Thorough Service including hard-to-reach areas, grout Service, and detailed attention to all surfaces."),
        "addServiceScreenSubTypeMonthly":
            MessageLookupByLibrary.simpleMessage("Monthly Service"),
        "addServiceScreenSubTypeMonthlyExplanation":
            MessageLookupByLibrary.simpleMessage(
                "Comprehensive monthly Service with deeper attention to detail than weekly service."),
        "addServiceScreenSubTypeNormal":
            MessageLookupByLibrary.simpleMessage("Standard Service"),
        "addServiceScreenSubTypeNormalExplanation":
            MessageLookupByLibrary.simpleMessage(
                "Standard Service covering basic tasks like dusting, vacuuming, and surface wiping."),
        "addServiceScreenSubTypeWeekly":
            MessageLookupByLibrary.simpleMessage("Weekly Service"),
        "addServiceScreenSubTypeWeeklyExplanation":
            MessageLookupByLibrary.simpleMessage(
                "Regular weekly maintenance Service to keep your space consistently clean."),
        "addServiceScreenSuccessMessage":
            MessageLookupByLibrary.simpleMessage("Added Successfully"),
        "addServiceScreenTimeSlotsError": MessageLookupByLibrary.simpleMessage(
            "Please add at least one time slot"),
        "addServiceScreenTimeSlotsLabel":
            MessageLookupByLibrary.simpleMessage("Available Time Slots"),
        "addServiceScreenTitle":
            MessageLookupByLibrary.simpleMessage("Add a Service"),
        "addServiceScreenTotalDuration": m1,
        "addServiceScreenWeeklyPriceLabel":
            MessageLookupByLibrary.simpleMessage("Weekly Price (\$)"),
        "allServicesScreenTitle":
            MessageLookupByLibrary.simpleMessage("All Services"),
        "bookingDetailsScreenActionComplete":
            MessageLookupByLibrary.simpleMessage("Mark as Completed"),
        "bookingDetailsScreenActionConfirm":
            MessageLookupByLibrary.simpleMessage("Confirm Booking"),
        "bookingDetailsScreenActionDefault":
            MessageLookupByLibrary.simpleMessage("Action"),
        "bookingDetailsScreenActionReceipt":
            MessageLookupByLibrary.simpleMessage("View Receipt"),
        "bookingDetailsScreenActionReschedule":
            MessageLookupByLibrary.simpleMessage("Reschedule"),
        "bookingDetailsScreenActionStart":
            MessageLookupByLibrary.simpleMessage("Start Job"),
        "bookingDetailsScreenCancelButton":
            MessageLookupByLibrary.simpleMessage("Cancel Booking"),
        "bookingDetailsScreenCancelMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to cancel this booking? This action cannot be undone."),
        "bookingDetailsScreenCancelSuccess":
            MessageLookupByLibrary.simpleMessage("Booking has been cancelled"),
        "bookingDetailsScreenCancelTitle":
            MessageLookupByLibrary.simpleMessage("Cancel Booking"),
        "bookingDetailsScreenClientTitle":
            MessageLookupByLibrary.simpleMessage("👤 Client Information"),
        "bookingDetailsScreenCompleteMessage":
            MessageLookupByLibrary.simpleMessage(
                "Have you completed all the work?"),
        "bookingDetailsScreenCompleteTitle":
            MessageLookupByLibrary.simpleMessage("Complete Job"),
        "bookingDetailsScreenConfirmMessage":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to confirm this booking?"),
        "bookingDetailsScreenConfirmTitle":
            MessageLookupByLibrary.simpleMessage("Confirm Booking"),
        "bookingDetailsScreenDateLabel":
            MessageLookupByLibrary.simpleMessage("Scheduled Date"),
        "bookingDetailsScreenDescriptionLabel":
            MessageLookupByLibrary.simpleMessage("Service Description"),
        "bookingDetailsScreenDialogCancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "bookingDetailsScreenDialogConfirm":
            MessageLookupByLibrary.simpleMessage("Confirm"),
        "bookingDetailsScreenDialogGoBack":
            MessageLookupByLibrary.simpleMessage("Go Back"),
        "bookingDetailsScreenDirectionsButton":
            MessageLookupByLibrary.simpleMessage("Get Directions"),
        "bookingDetailsScreenDirectionsTooltip":
            MessageLookupByLibrary.simpleMessage("Open in Maps"),
        "bookingDetailsScreenDurationLabel":
            MessageLookupByLibrary.simpleMessage("Duration"),
        "bookingDetailsScreenDurationValue": m2,
        "bookingDetailsScreenEmailError":
            MessageLookupByLibrary.simpleMessage("Could not launch email"),
        "bookingDetailsScreenEmailLabel":
            MessageLookupByLibrary.simpleMessage("Email"),
        "bookingDetailsScreenInstructionsLabel":
            MessageLookupByLibrary.simpleMessage("Special Instructions"),
        "bookingDetailsScreenLocation": m3,
        "bookingDetailsScreenLocationTitle":
            MessageLookupByLibrary.simpleMessage("📍 Service Location"),
        "bookingDetailsScreenMapError": MessageLookupByLibrary.simpleMessage(
            "Showing approximate location"),
        "bookingDetailsScreenMapLoading":
            MessageLookupByLibrary.simpleMessage("Loading map..."),
        "bookingDetailsScreenMapNotAvailable":
            MessageLookupByLibrary.simpleMessage("Location not available"),
        "bookingDetailsScreenMapsError":
            MessageLookupByLibrary.simpleMessage("Could not open maps app"),
        "bookingDetailsScreenPaymentStatusLabel":
            MessageLookupByLibrary.simpleMessage("Payment Status"),
        "bookingDetailsScreenPaymentTitle":
            MessageLookupByLibrary.simpleMessage("💰 Payment Information"),
        "bookingDetailsScreenPhoneError":
            MessageLookupByLibrary.simpleMessage("Could not launch phone call"),
        "bookingDetailsScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Phone Number"),
        "bookingDetailsScreenPrice": m4,
        "bookingDetailsScreenRating": m5,
        "bookingDetailsScreenServiceFeeLabel":
            MessageLookupByLibrary.simpleMessage("Service Fee"),
        "bookingDetailsScreenServiceTitle":
            MessageLookupByLibrary.simpleMessage("🛠️ Service Details"),
        "bookingDetailsScreenStartMessage":
            MessageLookupByLibrary.simpleMessage(
                "Are you ready to start this job?"),
        "bookingDetailsScreenStartTitle":
            MessageLookupByLibrary.simpleMessage("Start Job"),
        "bookingDetailsScreenStatusCancelled":
            MessageLookupByLibrary.simpleMessage("Cancelled"),
        "bookingDetailsScreenStatusCompleted":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "bookingDetailsScreenStatusConfirmed":
            MessageLookupByLibrary.simpleMessage("Confirmed"),
        "bookingDetailsScreenStatusInProgress":
            MessageLookupByLibrary.simpleMessage("In Progress"),
        "bookingDetailsScreenStatusPending":
            MessageLookupByLibrary.simpleMessage("Pending"),
        "bookingDetailsScreenStatusUpdated": m6,
        "bookingDetailsScreenTaxLabel":
            MessageLookupByLibrary.simpleMessage("Tax"),
        "bookingDetailsScreenTaxValue":
            MessageLookupByLibrary.simpleMessage("\$0.00"),
        "bookingDetailsScreenTimeSlotLabel":
            MessageLookupByLibrary.simpleMessage("Time Slot"),
        "bookingDetailsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Booking Details"),
        "bookingDetailsScreenToolsClient":
            MessageLookupByLibrary.simpleMessage("Client has tools"),
        "bookingDetailsScreenToolsLabel":
            MessageLookupByLibrary.simpleMessage("Tools Required"),
        "bookingDetailsScreenToolsProvider":
            MessageLookupByLibrary.simpleMessage("Bring your own tools"),
        "bookingDetailsScreenTotalLabel":
            MessageLookupByLibrary.simpleMessage("Total Amount"),
        "bookingFormScreenAdditionalInfoSection":
            MessageLookupByLibrary.simpleMessage("Additional Information"),
        "bookingFormScreenAddressError": MessageLookupByLibrary.simpleMessage(
            "Please fill in all address fields"),
        "bookingFormScreenAddressSection":
            MessageLookupByLibrary.simpleMessage("Address Details"),
        "bookingFormScreenCategoryLabel":
            MessageLookupByLibrary.simpleMessage("Category"),
        "bookingFormScreenCityError":
            MessageLookupByLibrary.simpleMessage("City is required"),
        "bookingFormScreenCityHint":
            MessageLookupByLibrary.simpleMessage("Enter city"),
        "bookingFormScreenCityLabel":
            MessageLookupByLibrary.simpleMessage("City"),
        "bookingFormScreenCurrentLocation":
            MessageLookupByLibrary.simpleMessage("Current Location"),
        "bookingFormScreenDayError":
            MessageLookupByLibrary.simpleMessage("Please select a day"),
        "bookingFormScreenDayLabel":
            MessageLookupByLibrary.simpleMessage("Select Day"),
        "bookingFormScreenDetailsHint": MessageLookupByLibrary.simpleMessage(
            "Describe any specific requirements..."),
        "bookingFormScreenDetailsLabel":
            MessageLookupByLibrary.simpleMessage("Service Details (Optional)"),
        "bookingFormScreenDurationError": m7,
        "bookingFormScreenDurationLabel":
            MessageLookupByLibrary.simpleMessage("Duration:"),
        "bookingFormScreenDurationMinimum": m8,
        "bookingFormScreenDurationSelectorLabel":
            MessageLookupByLibrary.simpleMessage("Select Duration:"),
        "bookingFormScreenDurationValue": m9,
        "bookingFormScreenExtraFeesLabel":
            MessageLookupByLibrary.simpleMessage("Extra Fees"),
        "bookingFormScreenExtraFeesTotalLabel":
            MessageLookupByLibrary.simpleMessage("Total Extra Fees"),
        "bookingFormScreenFixedPriceNote": MessageLookupByLibrary.simpleMessage(
            "Fixed price - duration cannot be changed"),
        "bookingFormScreenHourlyRateLabel":
            MessageLookupByLibrary.simpleMessage("Hourly Rate:"),
        "bookingFormScreenHourlyRateValue": m10,
        "bookingFormScreenLoadingLocation":
            MessageLookupByLibrary.simpleMessage("Getting your location..."),
        "bookingFormScreenLocationAccuracy": m11,
        "bookingFormScreenLocationError": MessageLookupByLibrary.simpleMessage(
            "Unable to get your location. Please enable location services."),
        "bookingFormScreenLocationLabel":
            MessageLookupByLibrary.simpleMessage("Your Location"),
        "bookingFormScreenLocationRequired":
            MessageLookupByLibrary.simpleMessage(
                "Location is required for service booking."),
        "bookingFormScreenLocationRequiredError":
            MessageLookupByLibrary.simpleMessage(
                "Please enable location services to continue"),
        "bookingFormScreenMinDurationLabel":
            MessageLookupByLibrary.simpleMessage("Minimum Duration"),
        "bookingFormScreenNoTimeSteps": MessageLookupByLibrary.simpleMessage(
            "No available time steps in this slot"),
        "bookingFormScreenPricingDetailsLabel":
            MessageLookupByLibrary.simpleMessage("Pricing Details"),
        "bookingFormScreenPricingLabel":
            MessageLookupByLibrary.simpleMessage("Pricing"),
        "bookingFormScreenPricingValue": m12,
        "bookingFormScreenRecurrenceError":
            MessageLookupByLibrary.simpleMessage(
                "Please select recurrence type"),
        "bookingFormScreenRecurrenceLabel":
            MessageLookupByLibrary.simpleMessage("Recurrence Type"),
        "bookingFormScreenScheduleSection":
            MessageLookupByLibrary.simpleMessage("Schedule Details"),
        "bookingFormScreenShowMap":
            MessageLookupByLibrary.simpleMessage("Show on map"),
        "bookingFormScreenStartDateError":
            MessageLookupByLibrary.simpleMessage("Start date is required"),
        "bookingFormScreenStartDateHint":
            MessageLookupByLibrary.simpleMessage("Select booking date"),
        "bookingFormScreenStartDateLabel":
            MessageLookupByLibrary.simpleMessage("Start Date"),
        "bookingFormScreenStartDateRecurringHint":
            MessageLookupByLibrary.simpleMessage(
                "Select start date for recurrence"),
        "bookingFormScreenStartTimeError": MessageLookupByLibrary.simpleMessage(
            "Selected start time must be within the chosen time slot"),
        "bookingFormScreenStartTimeLabel":
            MessageLookupByLibrary.simpleMessage("Start Time"),
        "bookingFormScreenStartTimeSelectorLabel":
            MessageLookupByLibrary.simpleMessage("Select Start Time:"),
        "bookingFormScreenStateError":
            MessageLookupByLibrary.simpleMessage("State is required"),
        "bookingFormScreenStateHint":
            MessageLookupByLibrary.simpleMessage("Enter state"),
        "bookingFormScreenStateLabel":
            MessageLookupByLibrary.simpleMessage("State"),
        "bookingFormScreenStreetError":
            MessageLookupByLibrary.simpleMessage("Street address is required"),
        "bookingFormScreenStreetHint":
            MessageLookupByLibrary.simpleMessage("Enter street address"),
        "bookingFormScreenStreetLabel":
            MessageLookupByLibrary.simpleMessage("Street Address"),
        "bookingFormScreenSubmitButton":
            MessageLookupByLibrary.simpleMessage("Create Booking"),
        "bookingFormScreenSuccessMessage": MessageLookupByLibrary.simpleMessage(
            "Booking created successfully!"),
        "bookingFormScreenTimeIntervalInfo":
            MessageLookupByLibrary.simpleMessage("30-minute intervals"),
        "bookingFormScreenTimeSlotError":
            MessageLookupByLibrary.simpleMessage("Please select a time slot"),
        "bookingFormScreenTimeSlotInfo": m13,
        "bookingFormScreenTimeSlotLabel":
            MessageLookupByLibrary.simpleMessage("Select Time Slot"),
        "bookingFormScreenTimezoneEgypt":
            MessageLookupByLibrary.simpleMessage("Egypt (Cairo)"),
        "bookingFormScreenTimezoneError":
            MessageLookupByLibrary.simpleMessage("Please select a timezone"),
        "bookingFormScreenTimezoneLabel":
            MessageLookupByLibrary.simpleMessage("Timezone"),
        "bookingFormScreenTimezoneUae":
            MessageLookupByLibrary.simpleMessage("UAE (Dubai)"),
        "bookingFormScreenTitle":
            MessageLookupByLibrary.simpleMessage("Create Booking"),
        "bookingFormScreenToolsLabel": MessageLookupByLibrary.simpleMessage(
            "Do you have tools for this service?"),
        "bookingFormScreenToolsSubtitle": MessageLookupByLibrary.simpleMessage(
            "If not, the provider will bring their own"),
        "bookingFormScreenToolsTitle":
            MessageLookupByLibrary.simpleMessage("I have the required tools"),
        "bookingFormScreenTotalPriceLabel":
            MessageLookupByLibrary.simpleMessage("Total Price:"),
        "bookingFormScreenTotalPriceValue": m14,
        "bookingFormScreenTypeLabel":
            MessageLookupByLibrary.simpleMessage("Type"),
        "bookingFormScreenUnknownLocation":
            MessageLookupByLibrary.simpleMessage("Unknown location"),
        "bookingFormScreenZipCodeHint":
            MessageLookupByLibrary.simpleMessage("Enter zip code"),
        "bookingFormScreenZipCodeLabel":
            MessageLookupByLibrary.simpleMessage("Zip Code (Optional)"),
        "categoriesWidgetDeepCleanLabel":
            MessageLookupByLibrary.simpleMessage("Deep Clean"),
        "categoriesWidgetDefaultLabel": m15,
        "categoriesWidgetOneTimeLabel":
            MessageLookupByLibrary.simpleMessage("One-Time"),
        "categoriesWidgetRecurringLabel":
            MessageLookupByLibrary.simpleMessage("Recurring"),
        "categoriesWidgetTitle":
            MessageLookupByLibrary.simpleMessage("Categories"),
        "changeLanguageButton":
            MessageLookupByLibrary.simpleMessage("Change Language"),
        "changeLanguageConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to change the app language?"),
        "changeLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Change Language"),
        "clientLayoutScreenBookingsLabel":
            MessageLookupByLibrary.simpleMessage("Bookings"),
        "clientLayoutScreenFavoritesLabel":
            MessageLookupByLibrary.simpleMessage("Favorites"),
        "clientLayoutScreenHomeLabel":
            MessageLookupByLibrary.simpleMessage("Home"),
        "clientLayoutScreenProfileLabel":
            MessageLookupByLibrary.simpleMessage("Profile"),
        "clientRegisterationAlreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account ?"),
        "clientRegisterationBusinessReferenceId":
            MessageLookupByLibrary.simpleMessage("Business Reference ID"),
        "clientRegisterationConfirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "clientRegisterationEmail":
            MessageLookupByLibrary.simpleMessage("Email"),
        "clientRegisterationEnterEmailAddress":
            MessageLookupByLibrary.simpleMessage("Enter Email Address"),
        "clientRegisterationEnterFirstName":
            MessageLookupByLibrary.simpleMessage("Enter First Name"),
        "clientRegisterationEnterLastName":
            MessageLookupByLibrary.simpleMessage("Enter Last Name"),
        "clientRegisterationEnterPassword":
            MessageLookupByLibrary.simpleMessage("Enter Password"),
        "clientRegisterationFirstName":
            MessageLookupByLibrary.simpleMessage("First Name"),
        "clientRegisterationLastName":
            MessageLookupByLibrary.simpleMessage("Last Name"),
        "clientRegisterationLogin":
            MessageLookupByLibrary.simpleMessage("Login"),
        "clientRegisterationMustAgreeToTerms":
            MessageLookupByLibrary.simpleMessage(
                "You must agree to the terms before registering."),
        "clientRegisterationOtpEmailOptionSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Send OTP to your email address"),
        "clientRegisterationOtpEmailOptionTitle":
            MessageLookupByLibrary.simpleMessage("Email"),
        "clientRegisterationOtpPhoneOptionSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Send OTP to your WhatsApp number"),
        "clientRegisterationOtpPhoneOptionTitle":
            MessageLookupByLibrary.simpleMessage("Phone (WhatsApp)"),
        "clientRegisterationPassword":
            MessageLookupByLibrary.simpleMessage("Password"),
        "clientRegisterationPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Phone Number"),
        "clientRegisterationPleaseAddReferenceId":
            MessageLookupByLibrary.simpleMessage("Please add reference id"),
        "clientRegisterationPleaseEnterPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Please enter a phone number"),
        "clientRegisterationReceiveOtpVia":
            MessageLookupByLibrary.simpleMessage("Receive OTP via"),
        "clientRegisterationReferenceIdMustBeNumbersOnly":
            MessageLookupByLibrary.simpleMessage(
                "Reference ID must be numbers only"),
        "clientRegisterationSignUp":
            MessageLookupByLibrary.simpleMessage("Sign Up"),
        "clientRegisterationTitle":
            MessageLookupByLibrary.simpleMessage("Client Registration"),
        "confirmButton": MessageLookupByLibrary.simpleMessage("Confirm"),
        "continueBtn": MessageLookupByLibrary.simpleMessage("Continue"),
        "customerHomeScreenBusinessRegistration": m16,
        "customerHomeScreenCategoryCleaning":
            MessageLookupByLibrary.simpleMessage("cleaning"),
        "customerHomeScreenCategoryElectrical":
            MessageLookupByLibrary.simpleMessage("electrical"),
        "customerHomeScreenCategoryPainting":
            MessageLookupByLibrary.simpleMessage("painting"),
        "customerHomeScreenCategoryRepair":
            MessageLookupByLibrary.simpleMessage("repair"),
        "customerHomeScreenClaimOffer":
            MessageLookupByLibrary.simpleMessage("Claim Offer"),
        "customerHomeScreenFavoriteError": m17,
        "customerHomeScreenHotDeals":
            MessageLookupByLibrary.simpleMessage("🔥 Hot Deals"),
        "customerHomeScreenOfferEmergencyRepairDiscount":
            MessageLookupByLibrary.simpleMessage("15% OFF"),
        "customerHomeScreenOfferEmergencyRepairSubtitle":
            MessageLookupByLibrary.simpleMessage("Same-day service available"),
        "customerHomeScreenOfferEmergencyRepairTitle":
            MessageLookupByLibrary.simpleMessage("Emergency Repair"),
        "customerHomeScreenOfferLimitedTimeDiscount":
            MessageLookupByLibrary.simpleMessage("SPECIAL"),
        "customerHomeScreenOfferLimitedTimeSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Book now and get exclusive discounts"),
        "customerHomeScreenOfferLimitedTimeTitle":
            MessageLookupByLibrary.simpleMessage("Limited Time Offer"),
        "customerHomeScreenOfferNewCustomerDiscount":
            MessageLookupByLibrary.simpleMessage("\$25 OFF"),
        "customerHomeScreenOfferNewCustomerSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Get \$25 off your first booking"),
        "customerHomeScreenOfferNewCustomerTitle":
            MessageLookupByLibrary.simpleMessage("New Customer Bonus"),
        "customerHomeScreenOfferSpringCleaningDiscount":
            MessageLookupByLibrary.simpleMessage("20% OFF"),
        "customerHomeScreenOfferSpringCleaningSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Get 20% off on deep cleaning services"),
        "customerHomeScreenOfferSpringCleaningTitle":
            MessageLookupByLibrary.simpleMessage("Spring Cleaning Special"),
        "customerHomeScreenOfferWeeklyMaintenanceDiscount":
            MessageLookupByLibrary.simpleMessage("30% OFF"),
        "customerHomeScreenOfferWeeklyMaintenanceSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Subscribe & save 30% on recurring services"),
        "customerHomeScreenOfferWeeklyMaintenanceTitle":
            MessageLookupByLibrary.simpleMessage("Weekly Maintenance"),
        "customerHomeScreenServicesError": m18,
        "customerHomeScreenSpecialOffers":
            MessageLookupByLibrary.simpleMessage("Special Offers 🎉"),
        "dateAndTimeFormFieldWidgetDateLabel":
            MessageLookupByLibrary.simpleMessage("Date"),
        "dateAndTimeFormFieldWidgetSelectDateHint":
            MessageLookupByLibrary.simpleMessage("Select Date"),
        "dateAndTimeFormFieldWidgetSelectTimeHint":
            MessageLookupByLibrary.simpleMessage("Select Time"),
        "dateAndTimeFormFieldWidgetTimeLabel":
            MessageLookupByLibrary.simpleMessage("Time"),
        "detailSectionCategoryLabel":
            MessageLookupByLibrary.simpleMessage("Category"),
        "detailSectionDurationLabel":
            MessageLookupByLibrary.simpleMessage("Duration"),
        "detailSectionDurationValue": m19,
        "detailSectionPriceHourlyLabel":
            MessageLookupByLibrary.simpleMessage("Price of each hour"),
        "detailSectionPriceRecurringLabel":
            MessageLookupByLibrary.simpleMessage("Price of service"),
        "detailSectionPriceValue": m20,
        "detailSectionPricingModelLabel":
            MessageLookupByLibrary.simpleMessage("Pricing Model"),
        "detailSectionServiceTypeLabel":
            MessageLookupByLibrary.simpleMessage("Service Type"),
        "detailSectionSubTypeLabel":
            MessageLookupByLibrary.simpleMessage("Sub-Type"),
        "detailSectionTitle":
            MessageLookupByLibrary.simpleMessage("Service Details"),
        "editProfileScreenBusinessNameError":
            MessageLookupByLibrary.simpleMessage("Business name is required"),
        "editProfileScreenBusinessNameHint":
            MessageLookupByLibrary.simpleMessage("Enter your Business Name"),
        "editProfileScreenBusinessNameLabel":
            MessageLookupByLibrary.simpleMessage("Business Name"),
        "editProfileScreenCameraOption":
            MessageLookupByLibrary.simpleMessage("Take Photo"),
        "editProfileScreenCancelButton":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "editProfileScreenChooseFromGallery":
            MessageLookupByLibrary.simpleMessage("Choose from Gallery"),
        "editProfileScreenContactInfo":
            MessageLookupByLibrary.simpleMessage("Contact Information"),
        "editProfileScreenEmailEmptyError":
            MessageLookupByLibrary.simpleMessage("Email is required"),
        "editProfileScreenEmailErrorEmpty":
            MessageLookupByLibrary.simpleMessage("Email is required"),
        "editProfileScreenEmailErrorInvalid":
            MessageLookupByLibrary.simpleMessage("Enter a valid email address"),
        "editProfileScreenEmailHint":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "editProfileScreenEmailInvalidError":
            MessageLookupByLibrary.simpleMessage("Enter a valid email address"),
        "editProfileScreenEmailLabel":
            MessageLookupByLibrary.simpleMessage("Email Address"),
        "editProfileScreenFirstNameError":
            MessageLookupByLibrary.simpleMessage("First name is required"),
        "editProfileScreenFirstNameHint":
            MessageLookupByLibrary.simpleMessage("Enter your first name"),
        "editProfileScreenFirstNameLabel":
            MessageLookupByLibrary.simpleMessage("First Name"),
        "editProfileScreenGalleryOption":
            MessageLookupByLibrary.simpleMessage("Choose from Gallery"),
        "editProfileScreenImagePickError": m21,
        "editProfileScreenImageUploadError":
            MessageLookupByLibrary.simpleMessage("Failed to upload image"),
        "editProfileScreenImageUploadErrorDetailed": m22,
        "editProfileScreenLastNameError":
            MessageLookupByLibrary.simpleMessage("Last name is required"),
        "editProfileScreenLastNameHint":
            MessageLookupByLibrary.simpleMessage("Enter your last name"),
        "editProfileScreenLastNameLabel":
            MessageLookupByLibrary.simpleMessage("Last Name"),
        "editProfileScreenPersonalInfo":
            MessageLookupByLibrary.simpleMessage("Personal Information"),
        "editProfileScreenPhoneError":
            MessageLookupByLibrary.simpleMessage("Phone number is required"),
        "editProfileScreenPhoneHint":
            MessageLookupByLibrary.simpleMessage("Enter your phone number"),
        "editProfileScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Phone Number"),
        "editProfileScreenPickImageError": m23,
        "editProfileScreenSaveButton":
            MessageLookupByLibrary.simpleMessage("Save Changes"),
        "editProfileScreenSuccessMessage": MessageLookupByLibrary.simpleMessage(
            "Profile updated successfully!"),
        "editProfileScreenTakePhoto":
            MessageLookupByLibrary.simpleMessage("Take Photo"),
        "editProfileScreenTitle":
            MessageLookupByLibrary.simpleMessage("Edit Profile"),
        "editProfileScreenUploadImageError":
            MessageLookupByLibrary.simpleMessage("Failed to upload image"),
        "editProfileScreenUploadImageErrorDetail": m24,
        "extraPrice": MessageLookupByLibrary.simpleMessage("Extra Price"),
        "favoritesScreenCategory": m25,
        "favoritesScreenCategoryCleaning":
            MessageLookupByLibrary.simpleMessage("CLEANING"),
        "favoritesScreenCategoryDefault":
            MessageLookupByLibrary.simpleMessage("OTHER"),
        "favoritesScreenCategoryElectrical":
            MessageLookupByLibrary.simpleMessage("ELECTRICAL"),
        "favoritesScreenCategoryPainting":
            MessageLookupByLibrary.simpleMessage("PAINTING"),
        "favoritesScreenCategoryRepair":
            MessageLookupByLibrary.simpleMessage("REPAIR"),
        "favoritesScreenCount": m26,
        "favoritesScreenDuration": m27,
        "favoritesScreenEmptyMessage": MessageLookupByLibrary.simpleMessage(
            "Start saving your favorite services\nby tapping the heart icon"),
        "favoritesScreenEmptyTip": MessageLookupByLibrary.simpleMessage(
            "💡 Tip: You can favorite services from\nthe home screen or service details"),
        "favoritesScreenEmptyTitle":
            MessageLookupByLibrary.simpleMessage("No favorites yet"),
        "favoritesScreenError": m28,
        "favoritesScreenErrorTitle":
            MessageLookupByLibrary.simpleMessage("Oops! Something went wrong"),
        "favoritesScreenFavoritePlural":
            MessageLookupByLibrary.simpleMessage("Favorites"),
        "favoritesScreenFavoriteSingular":
            MessageLookupByLibrary.simpleMessage("Favorite"),
        "favoritesScreenLoading":
            MessageLookupByLibrary.simpleMessage("Loading your favorites..."),
        "favoritesScreenRemovedSuccess":
            MessageLookupByLibrary.simpleMessage("Removed from favorites"),
        "favoritesScreenTitle":
            MessageLookupByLibrary.simpleMessage("My Favorites"),
        "favoritesScreenTryAgain":
            MessageLookupByLibrary.simpleMessage("Try Again"),
        "forgetPasswordScreenEmailOrPhoneHint":
            MessageLookupByLibrary.simpleMessage("Enter Email or Phone Number"),
        "forgetPasswordScreenEmailOrPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Email or Phone Number"),
        "forgetPasswordScreenSendCodeButton":
            MessageLookupByLibrary.simpleMessage("Send Code"),
        "forgetPasswordScreenSuccessMessage":
            MessageLookupByLibrary.simpleMessage("Password reset OTP sent"),
        "forgetPasswordScreenTitle":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "helpCenterScreenContactChat":
            MessageLookupByLibrary.simpleMessage("Chat"),
        "helpCenterScreenContactDescription": MessageLookupByLibrary.simpleMessage(
            "Our support team is available 24/7 to assist you with any questions or concerns."),
        "helpCenterScreenContactEmail":
            MessageLookupByLibrary.simpleMessage("Email"),
        "helpCenterScreenContactPhone":
            MessageLookupByLibrary.simpleMessage("Call"),
        "helpCenterScreenContactTitle":
            MessageLookupByLibrary.simpleMessage("Still need help?"),
        "helpCenterScreenFAQBookServiceAnswer":
            MessageLookupByLibrary.simpleMessage(
                "To book a service, browse available services, select your preferred time slot, and proceed to payment."),
        "helpCenterScreenFAQBookServiceQuestion":
            MessageLookupByLibrary.simpleMessage("How do I book a service?"),
        "helpCenterScreenFAQCancelRescheduleAnswer":
            MessageLookupByLibrary.simpleMessage(
                "Yes, you can cancel or reschedule up to 24 hours before your appointment."),
        "helpCenterScreenFAQCancelRescheduleQuestion":
            MessageLookupByLibrary.simpleMessage(
                "Can I cancel or reschedule my booking?"),
        "helpCenterScreenFAQContactProviderAnswer":
            MessageLookupByLibrary.simpleMessage(
                "You can message your provider directly through the app after booking."),
        "helpCenterScreenFAQContactProviderQuestion":
            MessageLookupByLibrary.simpleMessage(
                "How do I contact my service provider?"),
        "helpCenterScreenFAQPaymentMethodsAnswer":
            MessageLookupByLibrary.simpleMessage(
                "We accept credit cards, debit cards, and mobile payment options."),
        "helpCenterScreenFAQPaymentMethodsQuestion":
            MessageLookupByLibrary.simpleMessage(
                "What payment methods are accepted?"),
        "helpCenterScreenFAQTitle":
            MessageLookupByLibrary.simpleMessage("Frequently Asked Questions"),
        "helpCenterScreenHeader":
            MessageLookupByLibrary.simpleMessage("How can we help you?"),
        "helpCenterScreenSearchHint":
            MessageLookupByLibrary.simpleMessage("Search for help..."),
        "helpCenterScreenSubheader": MessageLookupByLibrary.simpleMessage(
            "Find answers to common questions and get support"),
        "helpCenterScreenTitle":
            MessageLookupByLibrary.simpleMessage("Help Center"),
        "homeAppbarLeadingWidgetDefaultGreeting":
            MessageLookupByLibrary.simpleMessage("Hello"),
        "homeAppbarLeadingWidgetDefaultLocation":
            MessageLookupByLibrary.simpleMessage("Select Location"),
        "homeAppbarLeadingWidgetGreeting": m29,
        "homeAppbarLeadingWidgetLocation": m30,
        "labelWithViewAllButtonWidgetViewAll":
            MessageLookupByLibrary.simpleMessage("View All"),
        "landing2GetStarted":
            MessageLookupByLibrary.simpleMessage("Get Started"),
        "landing2Login": MessageLookupByLibrary.simpleMessage(
            "Already have an account? Sign In"),
        "landing2Subtitle": MessageLookupByLibrary.simpleMessage(
            "Experience professional home services with guaranteed satisfaction and competitive pricing"),
        "landing2Title": MessageLookupByLibrary.simpleMessage(
            "Welcome to\nMahu Home Services"),
        "landingBody1": MessageLookupByLibrary.simpleMessage(
            "Book trusted professionals for cleaning, repairs, and maintenance with just a few taps"),
        "landingBody2": MessageLookupByLibrary.simpleMessage(
            "Every service comes with our quality promise and customer satisfaction guarantee"),
        "landingChangeLanguage":
            MessageLookupByLibrary.simpleMessage("Change Language"),
        "landingGetStarted":
            MessageLookupByLibrary.simpleMessage("Get Started"),
        "landingNext": MessageLookupByLibrary.simpleMessage("Next"),
        "landingSkip": MessageLookupByLibrary.simpleMessage("Skip"),
        "landingTitle1": MessageLookupByLibrary.simpleMessage(
            "Professional Home Services\nAt Your Doorstep"),
        "landingTitle2": MessageLookupByLibrary.simpleMessage(
            "Quality Service\nGuaranteed Satisfaction"),
        "languageChangedMessage": m31,
        "loginScreenDontHaveAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "loginScreenEmailOrPhoneHint":
            MessageLookupByLibrary.simpleMessage("Enter Email or Phone Number"),
        "loginScreenEmailOrPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Email or Phone Number"),
        "loginScreenForgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "loginScreenLoginBtn": MessageLookupByLibrary.simpleMessage("Login"),
        "loginScreenPasswordHint":
            MessageLookupByLibrary.simpleMessage("Enter Password"),
        "loginScreenPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Password"),
        "loginScreenRememberMe":
            MessageLookupByLibrary.simpleMessage("Remember Me"),
        "loginScreenSignUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "loginScreenTitle": MessageLookupByLibrary.simpleMessage("Login"),
        "myBookingsScreenAddReview":
            MessageLookupByLibrary.simpleMessage("Add Review"),
        "myBookingsScreenAllReviews": m32,
        "myBookingsScreenAnonymous":
            MessageLookupByLibrary.simpleMessage("Anonymous"),
        "myBookingsScreenCancelBooking":
            MessageLookupByLibrary.simpleMessage("Cancel Booking"),
        "myBookingsScreenCancelButton":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "myBookingsScreenCancelDialogContent": m33,
        "myBookingsScreenCancelDialogTitle":
            MessageLookupByLibrary.simpleMessage("Cancel Booking?"),
        "myBookingsScreenCancelError": MessageLookupByLibrary.simpleMessage(
            "Failed to cancel booking please try later"),
        "myBookingsScreenCancelLoading":
            MessageLookupByLibrary.simpleMessage("Cancelling booking..."),
        "myBookingsScreenCancelSuccess": MessageLookupByLibrary.simpleMessage(
            "Booking cancelled successfully"),
        "myBookingsScreenDetailsAddress":
            MessageLookupByLibrary.simpleMessage("Address"),
        "myBookingsScreenDetailsButton":
            MessageLookupByLibrary.simpleMessage("Details"),
        "myBookingsScreenDetailsClose":
            MessageLookupByLibrary.simpleMessage("Close"),
        "myBookingsScreenDetailsDate":
            MessageLookupByLibrary.simpleMessage("Date"),
        "myBookingsScreenDetailsDuration":
            MessageLookupByLibrary.simpleMessage("Duration"),
        "myBookingsScreenDetailsEndTime":
            MessageLookupByLibrary.simpleMessage("End Time"),
        "myBookingsScreenDetailsService":
            MessageLookupByLibrary.simpleMessage("Service"),
        "myBookingsScreenDetailsStartTime":
            MessageLookupByLibrary.simpleMessage("Start Time"),
        "myBookingsScreenDetailsStatus":
            MessageLookupByLibrary.simpleMessage("Status"),
        "myBookingsScreenDetailsTitle":
            MessageLookupByLibrary.simpleMessage("Booking Details"),
        "myBookingsScreenDetailsTotal":
            MessageLookupByLibrary.simpleMessage("Total"),
        "myBookingsScreenError": m34,
        "myBookingsScreenHours": MessageLookupByLibrary.simpleMessage("hours"),
        "myBookingsScreenKeepBooking":
            MessageLookupByLibrary.simpleMessage("Keep Booking"),
        "myBookingsScreenLoadError":
            MessageLookupByLibrary.simpleMessage("Failed to load bookings"),
        "myBookingsScreenNoPrevious":
            MessageLookupByLibrary.simpleMessage("No previous bookings"),
        "myBookingsScreenNoUpcoming":
            MessageLookupByLibrary.simpleMessage("No upcoming bookings"),
        "myBookingsScreenNotAuthenticated":
            MessageLookupByLibrary.simpleMessage("User not authenticated"),
        "myBookingsScreenReviewCancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "myBookingsScreenReviewError": m35,
        "myBookingsScreenReviewErrorGeneric":
            MessageLookupByLibrary.simpleMessage("Failed to submit review"),
        "myBookingsScreenReviewExistsError":
            MessageLookupByLibrary.simpleMessage(
                "You have already reviewed this service"),
        "myBookingsScreenReviewFeedbackLabel":
            MessageLookupByLibrary.simpleMessage("Your feedback (optional)"),
        "myBookingsScreenReviewLoginError":
            MessageLookupByLibrary.simpleMessage(
                "Please login to add a review"),
        "myBookingsScreenReviewPrompt": m36,
        "myBookingsScreenReviewSubmit":
            MessageLookupByLibrary.simpleMessage("Submit Review"),
        "myBookingsScreenReviewSubmitting":
            MessageLookupByLibrary.simpleMessage("Submitting review..."),
        "myBookingsScreenReviewSuccess": MessageLookupByLibrary.simpleMessage(
            "Review submitted successfully!"),
        "myBookingsScreenReviewTitle":
            MessageLookupByLibrary.simpleMessage("Add Review"),
        "myBookingsScreenStatus": m37,
        "myBookingsScreenTabPrevious":
            MessageLookupByLibrary.simpleMessage("Previous"),
        "myBookingsScreenTabUpcoming":
            MessageLookupByLibrary.simpleMessage("Upcoming"),
        "myBookingsScreenTitle":
            MessageLookupByLibrary.simpleMessage("My Bookings"),
        "myBookingsScreenTryAgain":
            MessageLookupByLibrary.simpleMessage("Try Again"),
        "myBookingsScreenUnknownService":
            MessageLookupByLibrary.simpleMessage("Unknown Service"),
        "newPasswordScreenConfirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Enter Password"),
        "newPasswordScreenConfirmPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "newPasswordScreenOtpLabel":
            MessageLookupByLibrary.simpleMessage("OTP"),
        "newPasswordScreenPasswordHint":
            MessageLookupByLibrary.simpleMessage("Enter Password"),
        "newPasswordScreenPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Password"),
        "newPasswordScreenSaveChangesButton":
            MessageLookupByLibrary.simpleMessage("Save Changes"),
        "newPasswordScreenTitle":
            MessageLookupByLibrary.simpleMessage("New Password"),
        "newPasswordScreenVerificationMessage": m38,
        "optionDescriptionOptional": MessageLookupByLibrary.simpleMessage(
            "Option description (optional)"),
        "optionName": MessageLookupByLibrary.simpleMessage("Option name"),
        "paymentCardDetailsWidgetCardHolderLabel":
            MessageLookupByLibrary.simpleMessage("Card Holder Name"),
        "paymentCardDetailsWidgetExpiryDateLabel":
            MessageLookupByLibrary.simpleMessage("Expiry Date"),
        "popularServicesWidgetTitle":
            MessageLookupByLibrary.simpleMessage("Popular Services"),
        "popularServicesWidgetViewAll":
            MessageLookupByLibrary.simpleMessage("View All"),
        "privacyPolicyScreenConsent": MessageLookupByLibrary.simpleMessage(
            "By using our services, you agree to the terms of this Privacy Policy."),
        "privacyPolicyScreenLastUpdated": m39,
        "privacyPolicyScreenSection1Content": MessageLookupByLibrary.simpleMessage(
            "We collect information you provide directly to us, including:\n- Personal information (name, email, phone number)\n- Service preferences and booking history\n- Payment information\n- Location data for service delivery"),
        "privacyPolicyScreenSection1Title":
            MessageLookupByLibrary.simpleMessage("1. Information We Collect"),
        "privacyPolicyScreenSection2Content": MessageLookupByLibrary.simpleMessage(
            "We use your information to:\n- Provide and improve our services\n- Process your bookings and payments\n- Communicate with you about services\n- Ensure safety and security\n- Comply with legal obligations"),
        "privacyPolicyScreenSection2Title":
            MessageLookupByLibrary.simpleMessage(
                "2. How We Use Your Information"),
        "privacyPolicyScreenSection3Content": MessageLookupByLibrary.simpleMessage(
            "We may share your information with:\n- Service providers to fulfill bookings\n- Payment processors for transaction processing\n- Legal authorities when required by law\n- Business partners with your consent"),
        "privacyPolicyScreenSection3Title":
            MessageLookupByLibrary.simpleMessage("3. Data Sharing"),
        "privacyPolicyScreenSection4Content": MessageLookupByLibrary.simpleMessage(
            "We implement security measures including:\n- Encryption of sensitive data\n- Secure servers and infrastructure\n- Regular security audits\n- Access controls and authentication"),
        "privacyPolicyScreenSection4Title":
            MessageLookupByLibrary.simpleMessage("4. Data Security"),
        "privacyPolicyScreenSection5Content": MessageLookupByLibrary.simpleMessage(
            "You have the right to:\n- Access your personal information\n- Correct inaccurate data\n- Request data deletion\n- Opt-out of marketing communications\n- Data portability"),
        "privacyPolicyScreenSection5Title":
            MessageLookupByLibrary.simpleMessage("5. Your Rights"),
        "privacyPolicyScreenSection6Content": MessageLookupByLibrary.simpleMessage(
            "If you have questions about this privacy policy, please contact us at:\n- Email: privacy@mahu.com\n- Phone: +1 (555) 123-4567\n- Address: 123 Service Street, City, Country"),
        "privacyPolicyScreenSection6Title":
            MessageLookupByLibrary.simpleMessage("6. Contact Us"),
        "privacyPolicyScreenTitle":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "profileScreenAddressBookSubtitle":
            MessageLookupByLibrary.simpleMessage("Manage your addresses"),
        "profileScreenAddressBookTitle":
            MessageLookupByLibrary.simpleMessage("Address Book"),
        "profileScreenCancelButton":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "profileScreenComingSoon": MessageLookupByLibrary.simpleMessage(
            "This feature is coming soon!"),
        "profileScreenEditProfile":
            MessageLookupByLibrary.simpleMessage("Edit Profile"),
        "profileScreenEmptyMessage": MessageLookupByLibrary.simpleMessage(
            "No profile information available"),
        "profileScreenEmptyTitle":
            MessageLookupByLibrary.simpleMessage("User Profile"),
        "profileScreenError": m40,
        "profileScreenErrorDefault":
            MessageLookupByLibrary.simpleMessage("Please try again later"),
        "profileScreenErrorTitle":
            MessageLookupByLibrary.simpleMessage("Failed to load profile"),
        "profileScreenHelpCenterSubtitle":
            MessageLookupByLibrary.simpleMessage("Get help and support"),
        "profileScreenHelpCenterTitle":
            MessageLookupByLibrary.simpleMessage("Help Center"),
        "profileScreenLanguageSubtitle":
            MessageLookupByLibrary.simpleMessage("Change app language"),
        "profileScreenLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Language"),
        "profileScreenLoading":
            MessageLookupByLibrary.simpleMessage("Loading your profile..."),
        "profileScreenLogOut": MessageLookupByLibrary.simpleMessage("Log Out"),
        "profileScreenLogOutButton":
            MessageLookupByLibrary.simpleMessage("Log Out"),
        "profileScreenLogOutConfirmation": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to log out?"),
        "profileScreenLogOutTitle":
            MessageLookupByLibrary.simpleMessage("Log Out"),
        "profileScreenLogoutCancel":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "profileScreenLogoutConfirm":
            MessageLookupByLibrary.simpleMessage("Log Out"),
        "profileScreenLogoutDialogContent":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to log out of your account?"),
        "profileScreenLogoutDialogTitle":
            MessageLookupByLibrary.simpleMessage("Log Out"),
        "profileScreenLogoutSubtitle":
            MessageLookupByLibrary.simpleMessage("Sign out of your account"),
        "profileScreenLogoutTitle":
            MessageLookupByLibrary.simpleMessage("Log Out"),
        "profileScreenNoEmail":
            MessageLookupByLibrary.simpleMessage("No email provided"),
        "profileScreenNoPhone":
            MessageLookupByLibrary.simpleMessage("No phone provided"),
        "profileScreenNoProfile":
            MessageLookupByLibrary.simpleMessage("No profile loaded"),
        "profileScreenNoSubscription": MessageLookupByLibrary.simpleMessage(
            "You are not subscribed to any plan yet."),
        "profileScreenPersonalInfoSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Update your personal details"),
        "profileScreenPersonalInfoTitle":
            MessageLookupByLibrary.simpleMessage("Personal Information"),
        "profileScreenPrivacyPolicySubtitle":
            MessageLookupByLibrary.simpleMessage("Read our privacy policy"),
        "profileScreenPrivacyPolicyTitle":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "profileScreenReferenceId": m41,
        "profileScreenResponseTimeTitle":
            MessageLookupByLibrary.simpleMessage("Avg. Response Time"),
        "profileScreenResponseTimeValue":
            MessageLookupByLibrary.simpleMessage("Within 1 hour"),
        "profileScreenReviews": MessageLookupByLibrary.simpleMessage("reviews"),
        "profileScreenSectionAccount":
            MessageLookupByLibrary.simpleMessage("ACCOUNT"),
        "profileScreenSectionSupport":
            MessageLookupByLibrary.simpleMessage("SUPPORT"),
        "profileScreenSettingsTitle":
            MessageLookupByLibrary.simpleMessage("Settings"),
        "profileScreenStatsAllJobs":
            MessageLookupByLibrary.simpleMessage("All Jobs"),
        "profileScreenStatsCompleted":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "profileScreenStatsTitle":
            MessageLookupByLibrary.simpleMessage("Stats"),
        "profileScreenStatsTotalEarnings":
            MessageLookupByLibrary.simpleMessage("Total Earnings"),
        "profileScreenSubscribeButton":
            MessageLookupByLibrary.simpleMessage("Subscribe Now"),
        "profileScreenSubscriptionEndDate":
            MessageLookupByLibrary.simpleMessage("End Date"),
        "profileScreenSubscriptionPlanTitle":
            MessageLookupByLibrary.simpleMessage("Subscription Plan"),
        "profileScreenSubscriptionPrice": m42,
        "profileScreenSubscriptionStartDate":
            MessageLookupByLibrary.simpleMessage("Start Date"),
        "profileScreenSubscriptionStatus": m43,
        "profileScreenTermsOfServiceSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Read our terms and conditions"),
        "profileScreenTermsOfServiceTitle":
            MessageLookupByLibrary.simpleMessage("Terms of Service"),
        "profileScreenTryAgain":
            MessageLookupByLibrary.simpleMessage("Try Again"),
        "profileScreenUnknownUser":
            MessageLookupByLibrary.simpleMessage("Unknown User"),
        "profileScreenUpgradePlanButton":
            MessageLookupByLibrary.simpleMessage("Upgrade Plan"),
        "providerLayoutScreenCalendarLabel":
            MessageLookupByLibrary.simpleMessage("Calendar"),
        "providerLayoutScreenHomeLabel":
            MessageLookupByLibrary.simpleMessage("Home"),
        "providerLayoutScreenJobsLabel":
            MessageLookupByLibrary.simpleMessage("Jobs"),
        "providerLayoutScreenProfileLabel":
            MessageLookupByLibrary.simpleMessage("Profile"),
        "providerRegisterAgreeTerms":
            MessageLookupByLibrary.simpleMessage("I agree the "),
        "providerRegisterAlreadyHaveAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "providerRegisterBusinessCategoryHint":
            MessageLookupByLibrary.simpleMessage("Please select a category"),
        "providerRegisterBusinessCategoryLabel":
            MessageLookupByLibrary.simpleMessage("Business Category"),
        "providerRegisterBusinessNameHint":
            MessageLookupByLibrary.simpleMessage("Enter Business Name"),
        "providerRegisterBusinessNameLabel":
            MessageLookupByLibrary.simpleMessage("Business Name"),
        "providerRegisterConfirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Enter Password"),
        "providerRegisterConfirmPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "providerRegisterEmailHint":
            MessageLookupByLibrary.simpleMessage("Enter Email Address"),
        "providerRegisterEmailLabel":
            MessageLookupByLibrary.simpleMessage("Email"),
        "providerRegisterFirstNameHint":
            MessageLookupByLibrary.simpleMessage("Enter First Name"),
        "providerRegisterFirstNameLabel":
            MessageLookupByLibrary.simpleMessage("First Name"),
        "providerRegisterLastNameHint":
            MessageLookupByLibrary.simpleMessage("Enter Last Name"),
        "providerRegisterLastNameLabel":
            MessageLookupByLibrary.simpleMessage("Last Name"),
        "providerRegisterLogin": MessageLookupByLibrary.simpleMessage("Login"),
        "providerRegisterOtpEmailOptionSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Send OTP to your email address"),
        "providerRegisterOtpEmailOptionTitle":
            MessageLookupByLibrary.simpleMessage("Email"),
        "providerRegisterOtpPhoneOptionSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Send OTP to your WhatsApp number"),
        "providerRegisterOtpPhoneOptionTitle":
            MessageLookupByLibrary.simpleMessage("Phone (WhatsApp)"),
        "providerRegisterPasswordHint":
            MessageLookupByLibrary.simpleMessage("Enter Password"),
        "providerRegisterPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Password"),
        "providerRegisterPhoneNumberHint":
            MessageLookupByLibrary.simpleMessage("Please enter a phone number"),
        "providerRegisterPhoneNumberLabel":
            MessageLookupByLibrary.simpleMessage("Phone Number"),
        "providerRegisterReceiveOtpVia":
            MessageLookupByLibrary.simpleMessage("Receive OTP via"),
        "providerRegisterSignUp":
            MessageLookupByLibrary.simpleMessage("Sign Up"),
        "providerRegisterTermsAndConditions":
            MessageLookupByLibrary.simpleMessage("Terms and Conditions"),
        "providerRegisterTitle":
            MessageLookupByLibrary.simpleMessage("Provider Registration"),
        "providerRegisterUploadLogoLabel":
            MessageLookupByLibrary.simpleMessage("Upload Your Logo"),
        "recommendedServicesWidgetTitle": MessageLookupByLibrary.simpleMessage(
            "Recommended services for you"),
        "roleCustomerDesc":
            MessageLookupByLibrary.simpleMessage("Book home services near you"),
        "roleCustomerTitle":
            MessageLookupByLibrary.simpleMessage("I\'m a Customer"),
        "roleJoinSubtitle": MessageLookupByLibrary.simpleMessage(
            "Select your role to get started"),
        "roleJoinTitle": MessageLookupByLibrary.simpleMessage("Join as a..."),
        "roleProviderDesc": MessageLookupByLibrary.simpleMessage(
            "Offer your services to customers"),
        "roleProviderTitle":
            MessageLookupByLibrary.simpleMessage("I\'m a Service Provider"),
        "searchBarWidgetHint":
            MessageLookupByLibrary.simpleMessage("Search for services..."),
        "searchResultsScreenCategoryCleaning":
            MessageLookupByLibrary.simpleMessage("CLEANING"),
        "searchResultsScreenCategoryDefault":
            MessageLookupByLibrary.simpleMessage("OTHER"),
        "searchResultsScreenCategoryElectrical":
            MessageLookupByLibrary.simpleMessage("ELECTRICAL"),
        "searchResultsScreenCategoryPainting":
            MessageLookupByLibrary.simpleMessage("PAINTING"),
        "searchResultsScreenCategoryRepair":
            MessageLookupByLibrary.simpleMessage("REPAIR"),
        "searchResultsScreenDuration": m44,
        "searchResultsScreenEmptyMessage": MessageLookupByLibrary.simpleMessage(
            "Try searching with different keywords"),
        "searchResultsScreenEmptyTitle":
            MessageLookupByLibrary.simpleMessage("No services found"),
        "searchResultsScreenServiceTypeBasic":
            MessageLookupByLibrary.simpleMessage("BASIC"),
        "searchResultsScreenServiceTypeDefault":
            MessageLookupByLibrary.simpleMessage("OTHER"),
        "searchResultsScreenServiceTypePremium":
            MessageLookupByLibrary.simpleMessage("PREMIUM"),
        "searchResultsScreenServiceTypeStandard":
            MessageLookupByLibrary.simpleMessage("STANDARD"),
        "searchResultsScreenTitle": m45,
        "selectAddressScreenAddNew":
            MessageLookupByLibrary.simpleMessage("Add New Address"),
        "selectAddressScreenContinue":
            MessageLookupByLibrary.simpleMessage("Continue"),
        "selectAddressScreenHomeLabel":
            MessageLookupByLibrary.simpleMessage("Home"),
        "selectAddressScreenSampleAddress":
            MessageLookupByLibrary.simpleMessage(
                "7421 Ajman Street, Ajman,\n floor 3, UAE"),
        "selectAddressScreenTitle":
            MessageLookupByLibrary.simpleMessage("Select Address"),
        "selectPaymentMethodScreenAddNew":
            MessageLookupByLibrary.simpleMessage("Add New Payment Method"),
        "selectPaymentMethodScreenCashLabel":
            MessageLookupByLibrary.simpleMessage("Cash"),
        "selectPaymentMethodScreenCashSection":
            MessageLookupByLibrary.simpleMessage("Cash"),
        "selectPaymentMethodScreenContinue":
            MessageLookupByLibrary.simpleMessage("Continue"),
        "selectPaymentMethodScreenMasterCardLabel":
            MessageLookupByLibrary.simpleMessage("Master Card 1"),
        "selectPaymentMethodScreenMoreOptionsSection":
            MessageLookupByLibrary.simpleMessage("More Payment Options"),
        "selectPaymentMethodScreenTitle":
            MessageLookupByLibrary.simpleMessage("Select Payment Method"),
        "selectRoomsScreenBathroomLabel":
            MessageLookupByLibrary.simpleMessage("Bathroom"),
        "selectRoomsScreenBedroomLabel":
            MessageLookupByLibrary.simpleMessage("Bedroom"),
        "selectRoomsScreenContinue":
            MessageLookupByLibrary.simpleMessage("Continue"),
        "selectRoomsScreenDiningRoomLabel":
            MessageLookupByLibrary.simpleMessage("Dining Room"),
        "selectRoomsScreenKitchenLabel":
            MessageLookupByLibrary.simpleMessage("Kitchen"),
        "selectRoomsScreenLivingRoomLabel":
            MessageLookupByLibrary.simpleMessage("Living Room"),
        "selectRoomsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Select Rooms"),
        "serviceCardCurrencySymbol": MessageLookupByLibrary.simpleMessage("\$"),
        "serviceCardDeepCleanName":
            MessageLookupByLibrary.simpleMessage("Deep Clean"),
        "serviceCardDuration": m46,
        "serviceCardMinDurationLabel":
            MessageLookupByLibrary.simpleMessage("Min Duration: "),
        "serviceCardOneTimeName":
            MessageLookupByLibrary.simpleMessage("One-Time"),
        "serviceCardRecurringName":
            MessageLookupByLibrary.simpleMessage("Recurring"),
        "serviceCategoryScreenDeepCleanDescription":
            MessageLookupByLibrary.simpleMessage(
                "Thorough cleaning of all areas including hard-to-reach spots. Perfect for deep sanitization and intensive cleaning needs."),
        "serviceCategoryScreenDeepCleanTitle":
            MessageLookupByLibrary.simpleMessage("Deep Clean"),
        "serviceCategoryScreenDefaultDescription": m47,
        "serviceCategoryScreenDefaultProvider":
            MessageLookupByLibrary.simpleMessage("Independent Provider"),
        "serviceCategoryScreenDefaultTitle": m48,
        "serviceCategoryScreenEmptyMessage": m49,
        "serviceCategoryScreenEmptyTitle":
            MessageLookupByLibrary.simpleMessage("No services found"),
        "serviceCategoryScreenOneTimeDescription":
            MessageLookupByLibrary.simpleMessage(
                "Single cleaning sessions for specific needs. Ideal for special occasions, move-ins/move-outs, or when you need a one-time refresh."),
        "serviceCategoryScreenOneTimeTitle":
            MessageLookupByLibrary.simpleMessage("One-Time"),
        "serviceCategoryScreenRecurringDescription":
            MessageLookupByLibrary.simpleMessage(
                "Regular scheduled cleaning services to maintain your space. Set your preferred frequency and enjoy consistent cleanliness."),
        "serviceCategoryScreenRecurringTitle":
            MessageLookupByLibrary.simpleMessage("Recurring"),
        "serviceCategoryScreenServiceTypeDefault":
            MessageLookupByLibrary.simpleMessage("Other"),
        "serviceCategoryScreenServiceTypeOneTime":
            MessageLookupByLibrary.simpleMessage("One-Time"),
        "serviceCategoryScreenServiceTypeRecurring":
            MessageLookupByLibrary.simpleMessage("Recurring"),
        "serviceCategoryScreenServicesCount": m50,
        "serviceCategoryScreenUnknownProvider":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "serviceDetailsScreenAboutTitle":
            MessageLookupByLibrary.simpleMessage("About This Service"),
        "serviceDetailsScreenActivateButton":
            MessageLookupByLibrary.simpleMessage("Activate"),
        "serviceDetailsScreenActivateConfirmation":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to activate this service? It will become visible to customers."),
        "serviceDetailsScreenActivateSuccess":
            MessageLookupByLibrary.simpleMessage(
                "Service activated successfully"),
        "serviceDetailsScreenActivateTitle":
            MessageLookupByLibrary.simpleMessage("Activate Service"),
        "serviceDetailsScreenAllReviewsTitle": m51,
        "serviceDetailsScreenAvailableDaysLabel":
            MessageLookupByLibrary.simpleMessage("Available Days:"),
        "serviceDetailsScreenAvailableTimeTitle":
            MessageLookupByLibrary.simpleMessage("Available Time"),
        "serviceDetailsScreenBasedOnReviews": m52,
        "serviceDetailsScreenBookNow":
            MessageLookupByLibrary.simpleMessage("Book Now"),
        "serviceDetailsScreenCancelButton":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "serviceDetailsScreenDeactivateButton":
            MessageLookupByLibrary.simpleMessage("Deactivate"),
        "serviceDetailsScreenDeactivateConfirmation":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to deactivate this service? It will no longer be visible to customers."),
        "serviceDetailsScreenDeactivateSuccess":
            MessageLookupByLibrary.simpleMessage(
                "Service deactivated successfully"),
        "serviceDetailsScreenDeactivateTitle":
            MessageLookupByLibrary.simpleMessage("Deactivate Service"),
        "serviceDetailsScreenDefaultProviderName":
            MessageLookupByLibrary.simpleMessage("Service Provider"),
        "serviceDetailsScreenDefaultProviderType":
            MessageLookupByLibrary.simpleMessage("Independent Provider"),
        "serviceDetailsScreenDuration": m53,
        "serviceDetailsScreenFavoriteError": m54,
        "serviceDetailsScreenNoReviewsMessage":
            MessageLookupByLibrary.simpleMessage(
                "Be the first to review this service!"),
        "serviceDetailsScreenNoReviewsTitle":
            MessageLookupByLibrary.simpleMessage("No reviews yet"),
        "serviceDetailsScreenRating": m55,
        "serviceDetailsScreenReadMore":
            MessageLookupByLibrary.simpleMessage(" Read more"),
        "serviceDetailsScreenReviewsCount": m56,
        "serviceDetailsScreenReviewsTitle":
            MessageLookupByLibrary.simpleMessage("Customer Reviews"),
        "serviceDetailsScreenServiceTypeDefault":
            MessageLookupByLibrary.simpleMessage("Other"),
        "serviceDetailsScreenServiceTypeOneTime":
            MessageLookupByLibrary.simpleMessage("One-Time"),
        "serviceDetailsScreenServiceTypeRecurring":
            MessageLookupByLibrary.simpleMessage("Recurring"),
        "serviceDetailsScreenShowLess":
            MessageLookupByLibrary.simpleMessage(" Show less"),
        "serviceDetailsScreenStartingFrom":
            MessageLookupByLibrary.simpleMessage("Starting from"),
        "serviceDetailsScreenStatusActive":
            MessageLookupByLibrary.simpleMessage("Active"),
        "serviceDetailsScreenStatusInactive":
            MessageLookupByLibrary.simpleMessage("Inactive"),
        "serviceDetailsScreenStatusUpdateFailed":
            MessageLookupByLibrary.simpleMessage(
                "Failed to update service status"),
        "serviceDetailsScreenTimeSlotsLabel":
            MessageLookupByLibrary.simpleMessage("Time Slots:"),
        "serviceDetailsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Service Details"),
        "serviceDetailsScreenViewAllReviews": m57,
        "serviceListTileCleaningCategory":
            MessageLookupByLibrary.simpleMessage("Cleaning"),
        "serviceListTileCurrencySymbol":
            MessageLookupByLibrary.simpleMessage("\$"),
        "serviceListTileDeepCleanName":
            MessageLookupByLibrary.simpleMessage("Deep Clean"),
        "serviceListTileDurationAndPrice": m58,
        "serviceListTileOneTimeName":
            MessageLookupByLibrary.simpleMessage("One-Time"),
        "serviceListTilePaintingCategory":
            MessageLookupByLibrary.simpleMessage("Painting"),
        "serviceListTileRecurringName":
            MessageLookupByLibrary.simpleMessage("Recurring"),
        "serviceOptions":
            MessageLookupByLibrary.simpleMessage("Service Options"),
        "serviceProviderBookingsScreenActionComplete":
            MessageLookupByLibrary.simpleMessage("Complete"),
        "serviceProviderBookingsScreenActionConfirm":
            MessageLookupByLibrary.simpleMessage("Confirm"),
        "serviceProviderBookingsScreenActionDefault":
            MessageLookupByLibrary.simpleMessage("Action"),
        "serviceProviderBookingsScreenActionReschedule":
            MessageLookupByLibrary.simpleMessage("Reschedule"),
        "serviceProviderBookingsScreenActionStartJob":
            MessageLookupByLibrary.simpleMessage("Start Job"),
        "serviceProviderBookingsScreenActionViewDetails":
            MessageLookupByLibrary.simpleMessage("View Details"),
        "serviceProviderBookingsScreenCallClient": m59,
        "serviceProviderBookingsScreenCallError": m60,
        "serviceProviderBookingsScreenCancelButton":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "serviceProviderBookingsScreenCompleteDialog":
            MessageLookupByLibrary.simpleMessage("Mark as completed?"),
        "serviceProviderBookingsScreenConfirmActionTitle":
            MessageLookupByLibrary.simpleMessage("Confirm Action"),
        "serviceProviderBookingsScreenConfirmButton":
            MessageLookupByLibrary.simpleMessage("Confirm"),
        "serviceProviderBookingsScreenConfirmDialog":
            MessageLookupByLibrary.simpleMessage("Confirm this booking?"),
        "serviceProviderBookingsScreenContactButton":
            MessageLookupByLibrary.simpleMessage("Contact"),
        "serviceProviderBookingsScreenError": m61,
        "serviceProviderBookingsScreenFilterAll":
            MessageLookupByLibrary.simpleMessage("All Bookings"),
        "serviceProviderBookingsScreenFilterCancelled":
            MessageLookupByLibrary.simpleMessage("Cancelled"),
        "serviceProviderBookingsScreenFilterCompleted":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "serviceProviderBookingsScreenFilterConfirmed":
            MessageLookupByLibrary.simpleMessage("Confirmed"),
        "serviceProviderBookingsScreenFilterInProgress":
            MessageLookupByLibrary.simpleMessage("In Progress"),
        "serviceProviderBookingsScreenFilterPending":
            MessageLookupByLibrary.simpleMessage("Pending"),
        "serviceProviderBookingsScreenNoBookingsDay":
            MessageLookupByLibrary.simpleMessage("No bookings for this day"),
        "serviceProviderBookingsScreenNoBookingsFilter": m62,
        "serviceProviderBookingsScreenNoBookingsSubtitle": m63,
        "serviceProviderBookingsScreenPaymentStatus": m64,
        "serviceProviderBookingsScreenPaymentStatusFailed":
            MessageLookupByLibrary.simpleMessage("Failed"),
        "serviceProviderBookingsScreenPaymentStatusPaid":
            MessageLookupByLibrary.simpleMessage("Paid"),
        "serviceProviderBookingsScreenPaymentStatusPending":
            MessageLookupByLibrary.simpleMessage("Pending"),
        "serviceProviderBookingsScreenStartJobDialog":
            MessageLookupByLibrary.simpleMessage("Start this job?"),
        "serviceProviderBookingsScreenStatsCompleted":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "serviceProviderBookingsScreenStatsConfirmed":
            MessageLookupByLibrary.simpleMessage("Confirmed"),
        "serviceProviderBookingsScreenStatsTotal":
            MessageLookupByLibrary.simpleMessage("Total"),
        "serviceProviderBookingsScreenStatusCancelled":
            MessageLookupByLibrary.simpleMessage("Cancelled"),
        "serviceProviderBookingsScreenStatusCompleted":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "serviceProviderBookingsScreenStatusConfirmed":
            MessageLookupByLibrary.simpleMessage("Confirmed"),
        "serviceProviderBookingsScreenStatusInProgress":
            MessageLookupByLibrary.simpleMessage("In Progress"),
        "serviceProviderBookingsScreenStatusPending":
            MessageLookupByLibrary.simpleMessage("Pending"),
        "serviceProviderBookingsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Bookings"),
        "serviceProviderBookingsScreenTodayButton":
            MessageLookupByLibrary.simpleMessage("Today"),
        "serviceProviderBookingsScreenWeekdayFriday":
            MessageLookupByLibrary.simpleMessage("F"),
        "serviceProviderBookingsScreenWeekdayMonday":
            MessageLookupByLibrary.simpleMessage("M"),
        "serviceProviderBookingsScreenWeekdaySaturday":
            MessageLookupByLibrary.simpleMessage("S"),
        "serviceProviderBookingsScreenWeekdaySunday":
            MessageLookupByLibrary.simpleMessage("S"),
        "serviceProviderBookingsScreenWeekdayThursday":
            MessageLookupByLibrary.simpleMessage("T"),
        "serviceProviderBookingsScreenWeekdayTuesday":
            MessageLookupByLibrary.simpleMessage("T"),
        "serviceProviderBookingsScreenWeekdayWednesday":
            MessageLookupByLibrary.simpleMessage("W"),
        "serviceProviderBookingsScreenWithClient": m65,
        "serviceProviderDashboardScreenAddServiceButton":
            MessageLookupByLibrary.simpleMessage("Add Service"),
        "serviceProviderDashboardScreenCalendarButton":
            MessageLookupByLibrary.simpleMessage("Calendar"),
        "serviceProviderDashboardScreenCompletedJobsTitle":
            MessageLookupByLibrary.simpleMessage("Completed Jobs"),
        "serviceProviderDashboardScreenCompletionRateTitle":
            MessageLookupByLibrary.simpleMessage("Completion Rate"),
        "serviceProviderDashboardScreenDefaultProviderName":
            MessageLookupByLibrary.simpleMessage("Service Provider"),
        "serviceProviderDashboardScreenDeletionSuccess":
            MessageLookupByLibrary.simpleMessage(
                "Service deleted successfully"),
        "serviceProviderDashboardScreenErrorSubtitle":
            MessageLookupByLibrary.simpleMessage("Please try again later"),
        "serviceProviderDashboardScreenErrorTitle":
            MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "serviceProviderDashboardScreenNoServicesSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Add your first service to get started"),
        "serviceProviderDashboardScreenNoServicesTitle":
            MessageLookupByLibrary.simpleMessage("No services yet"),
        "serviceProviderDashboardScreenPerformanceOverview":
            MessageLookupByLibrary.simpleMessage(
                "Here\'s your performance overview"),
        "serviceProviderDashboardScreenPricingFixed":
            MessageLookupByLibrary.simpleMessage("fixed"),
        "serviceProviderDashboardScreenPricingHourly":
            MessageLookupByLibrary.simpleMessage("/hr"),
        "serviceProviderDashboardScreenPricingSquareFoot":
            MessageLookupByLibrary.simpleMessage("/sqft"),
        "serviceProviderDashboardScreenRatingTitle":
            MessageLookupByLibrary.simpleMessage("Rating"),
        "serviceProviderDashboardScreenRetryButton":
            MessageLookupByLibrary.simpleMessage("Retry"),
        "serviceProviderDashboardScreenServiceActive":
            MessageLookupByLibrary.simpleMessage("Active"),
        "serviceProviderDashboardScreenServiceInactive":
            MessageLookupByLibrary.simpleMessage("Inactive"),
        "serviceProviderDashboardScreenServicesTitle":
            MessageLookupByLibrary.simpleMessage("Your Services"),
        "serviceProviderDashboardScreenTitle":
            MessageLookupByLibrary.simpleMessage("Dashboard"),
        "serviceProviderDashboardScreenTotalEarningsTitle":
            MessageLookupByLibrary.simpleMessage("Total Earnings"),
        "serviceProviderDashboardScreenWelcome":
            MessageLookupByLibrary.simpleMessage("Welcome back,"),
        "serviceProviderJobsScreenDayFriday":
            MessageLookupByLibrary.simpleMessage("FRI"),
        "serviceProviderJobsScreenDayMonday":
            MessageLookupByLibrary.simpleMessage("MON"),
        "serviceProviderJobsScreenDaySaturday":
            MessageLookupByLibrary.simpleMessage("SAT"),
        "serviceProviderJobsScreenDaySunday":
            MessageLookupByLibrary.simpleMessage("SUN"),
        "serviceProviderJobsScreenDayThursday":
            MessageLookupByLibrary.simpleMessage("THU"),
        "serviceProviderJobsScreenDayTuesday":
            MessageLookupByLibrary.simpleMessage("TUE"),
        "serviceProviderJobsScreenDayWednesday":
            MessageLookupByLibrary.simpleMessage("WED"),
        "serviceProviderJobsScreenFilterAll":
            MessageLookupByLibrary.simpleMessage("All Bookings"),
        "serviceProviderJobsScreenFilterCompleted":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "serviceProviderJobsScreenFilterInProgress":
            MessageLookupByLibrary.simpleMessage("In Progress"),
        "serviceProviderJobsScreenFilterUpcoming":
            MessageLookupByLibrary.simpleMessage("Upcoming"),
        "serviceProviderJobsScreenMonthApril":
            MessageLookupByLibrary.simpleMessage("APR"),
        "serviceProviderJobsScreenMonthAugust":
            MessageLookupByLibrary.simpleMessage("AUG"),
        "serviceProviderJobsScreenMonthDecember":
            MessageLookupByLibrary.simpleMessage("DEC"),
        "serviceProviderJobsScreenMonthFebruary":
            MessageLookupByLibrary.simpleMessage("FEB"),
        "serviceProviderJobsScreenMonthJanuary":
            MessageLookupByLibrary.simpleMessage("JAN"),
        "serviceProviderJobsScreenMonthJuly":
            MessageLookupByLibrary.simpleMessage("JUL"),
        "serviceProviderJobsScreenMonthJune":
            MessageLookupByLibrary.simpleMessage("JUN"),
        "serviceProviderJobsScreenMonthMarch":
            MessageLookupByLibrary.simpleMessage("MAR"),
        "serviceProviderJobsScreenMonthMay":
            MessageLookupByLibrary.simpleMessage("MAY"),
        "serviceProviderJobsScreenMonthNovember":
            MessageLookupByLibrary.simpleMessage("NOV"),
        "serviceProviderJobsScreenMonthOctober":
            MessageLookupByLibrary.simpleMessage("OCT"),
        "serviceProviderJobsScreenMonthSeptember":
            MessageLookupByLibrary.simpleMessage("SEP"),
        "serviceProviderJobsScreenNoBookingsSubtitle": m66,
        "serviceProviderJobsScreenNoBookingsTitle":
            MessageLookupByLibrary.simpleMessage("No bookings found"),
        "serviceProviderJobsScreenPaymentStatusFailed":
            MessageLookupByLibrary.simpleMessage("Failed"),
        "serviceProviderJobsScreenPaymentStatusPaid":
            MessageLookupByLibrary.simpleMessage("Paid"),
        "serviceProviderJobsScreenPaymentStatusPending":
            MessageLookupByLibrary.simpleMessage("Pending"),
        "serviceProviderJobsScreenStatsLabel": m67,
        "serviceProviderJobsScreenStatusCancelled":
            MessageLookupByLibrary.simpleMessage("Cancelled"),
        "serviceProviderJobsScreenStatusCompleted":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "serviceProviderJobsScreenStatusInProgress":
            MessageLookupByLibrary.simpleMessage("In Progress"),
        "serviceProviderJobsScreenStatusUpcoming":
            MessageLookupByLibrary.simpleMessage("Upcoming"),
        "serviceProviderJobsScreenTitle":
            MessageLookupByLibrary.simpleMessage("My Bookings"),
        "serviceSummaryCardCurrencySymbol":
            MessageLookupByLibrary.simpleMessage("AED"),
        "serviceSummaryCardHomeCleaningDescription":
            MessageLookupByLibrary.simpleMessage(
                "Professional home cleaning service"),
        "serviceSummaryCardHomeCleaningName":
            MessageLookupByLibrary.simpleMessage("Home Cleaning"),
        "serviceSummaryCardPerHour":
            MessageLookupByLibrary.simpleMessage("/hour"),
        "termsOfServiceScreenAcknowledgment": MessageLookupByLibrary.simpleMessage(
            "By using Mahu Home Services, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service."),
        "termsOfServiceScreenDefaultJurisdiction":
            MessageLookupByLibrary.simpleMessage("Your Jurisdiction"),
        "termsOfServiceScreenIntro": MessageLookupByLibrary.simpleMessage(
            "Please read these Terms of Service carefully before using our services."),
        "termsOfServiceScreenLastUpdated": m68,
        "termsOfServiceScreenSection1Content": MessageLookupByLibrary.simpleMessage(
            "By accessing or using Mahu Home Services, you agree to be bound by these Terms of Service and our Privacy Policy. If you do not agree to these terms, please do not use our services."),
        "termsOfServiceScreenSection1Title":
            MessageLookupByLibrary.simpleMessage("1. Acceptance of Terms"),
        "termsOfServiceScreenSection2Content": MessageLookupByLibrary.simpleMessage(
            "Mahu Home Services connects users with service providers for various home services including cleaning, repair, painting, and electrical services. We act as an intermediary platform."),
        "termsOfServiceScreenSection2Title":
            MessageLookupByLibrary.simpleMessage("2. Service Description"),
        "termsOfServiceScreenSection3Content": MessageLookupByLibrary.simpleMessage(
            "You must create an account to use our services. You are responsible for:\n- Maintaining account security\n- Providing accurate information\n- All activities under your account\n- Notifying us of unauthorized access"),
        "termsOfServiceScreenSection3Title":
            MessageLookupByLibrary.simpleMessage("3. User Accounts"),
        "termsOfServiceScreenSection4Content": MessageLookupByLibrary.simpleMessage(
            "- Bookings are subject to provider availability\n- Payments are processed through secure channels\n- Cancellation policies vary by service type\n- Refunds are subject to our refund policy"),
        "termsOfServiceScreenSection4Title":
            MessageLookupByLibrary.simpleMessage("4. Booking and Payments"),
        "termsOfServiceScreenSection5Content": MessageLookupByLibrary.simpleMessage(
            "You agree not to:\n- Use the service for illegal purposes\n- Harass service providers or other users\n- Post false or misleading information\n- Attempt to circumvent the platform\n- Damage the reputation of the service"),
        "termsOfServiceScreenSection5Title":
            MessageLookupByLibrary.simpleMessage("5. User Conduct"),
        "termsOfServiceScreenSection6Content": MessageLookupByLibrary.simpleMessage(
            "Mahu Home Services is not liable for:\n- Quality of services provided by third parties\n- Damages or losses during service provision\n- Disputes between users and service providers\n- Technical issues beyond our control"),
        "termsOfServiceScreenSection6Title":
            MessageLookupByLibrary.simpleMessage("6. Limitation of Liability"),
        "termsOfServiceScreenSection7Content": MessageLookupByLibrary.simpleMessage(
            "We may terminate or suspend your account at our discretion if you violate these terms. You may also terminate your account at any time."),
        "termsOfServiceScreenSection7Title":
            MessageLookupByLibrary.simpleMessage("7. Termination"),
        "termsOfServiceScreenSection8Content": MessageLookupByLibrary.simpleMessage(
            "We may modify these terms at any time. Continued use of the service constitutes acceptance of modified terms."),
        "termsOfServiceScreenSection8Title":
            MessageLookupByLibrary.simpleMessage("8. Changes to Terms"),
        "termsOfServiceScreenSection9Content": m69,
        "termsOfServiceScreenSection9Title":
            MessageLookupByLibrary.simpleMessage("9. Governing Law"),
        "termsOfServiceScreenTitle":
            MessageLookupByLibrary.simpleMessage("Terms of Service"),
        "updateServiceScreenAvailableDaysError":
            MessageLookupByLibrary.simpleMessage(
                "Please select at least one day"),
        "updateServiceScreenAvailableDaysLabel":
            MessageLookupByLibrary.simpleMessage("Available Days"),
        "updateServiceScreenDayFriday":
            MessageLookupByLibrary.simpleMessage("Friday"),
        "updateServiceScreenDayMonday":
            MessageLookupByLibrary.simpleMessage("Monday"),
        "updateServiceScreenDaySaturday":
            MessageLookupByLibrary.simpleMessage("Saturday"),
        "updateServiceScreenDaySunday":
            MessageLookupByLibrary.simpleMessage("Sunday"),
        "updateServiceScreenDayThursday":
            MessageLookupByLibrary.simpleMessage("Thursday"),
        "updateServiceScreenDayTuesday":
            MessageLookupByLibrary.simpleMessage("Tuesday"),
        "updateServiceScreenDayWednesday":
            MessageLookupByLibrary.simpleMessage("Wednesday"),
        "updateServiceScreenDescriptionEmptyError":
            MessageLookupByLibrary.simpleMessage("Please enter a description"),
        "updateServiceScreenDescriptionHint":
            MessageLookupByLibrary.simpleMessage(
                "Describe your cleaning service in detail..."),
        "updateServiceScreenDescriptionLabel":
            MessageLookupByLibrary.simpleMessage("Description"),
        "updateServiceScreenDescriptionLengthError":
            MessageLookupByLibrary.simpleMessage(
                "Description should be at least 30 characters"),
        "updateServiceScreenDurationEmptyError":
            MessageLookupByLibrary.simpleMessage("Please enter duration"),
        "updateServiceScreenDurationHint":
            MessageLookupByLibrary.simpleMessage("e.g., 2 hours"),
        "updateServiceScreenDurationInvalidError":
            MessageLookupByLibrary.simpleMessage("Please enter a valid number"),
        "updateServiceScreenDurationLabel":
            MessageLookupByLibrary.simpleMessage("Minimum Duration"),
        "updateServiceScreenPriceEmptyError":
            MessageLookupByLibrary.simpleMessage("Please enter a price"),
        "updateServiceScreenPriceInvalidError":
            MessageLookupByLibrary.simpleMessage("Please enter a valid number"),
        "updateServiceScreenPricingHint":
            MessageLookupByLibrary.simpleMessage("Pricing Rate"),
        "updateServiceScreenPricingLabel":
            MessageLookupByLibrary.simpleMessage("Pricing Rate"),
        "updateServiceScreenPublishButton":
            MessageLookupByLibrary.simpleMessage("Publish Service"),
        "updateServiceScreenServiceNameError":
            MessageLookupByLibrary.simpleMessage("Please enter a service name"),
        "updateServiceScreenServiceNameHint":
            MessageLookupByLibrary.simpleMessage(
                "e.g., Deep Cleaning, Weekly Maintenance"),
        "updateServiceScreenServiceNameLabel":
            MessageLookupByLibrary.simpleMessage("Service Name"),
        "updateServiceScreenSuccessMessage":
            MessageLookupByLibrary.simpleMessage("Updated Successfully"),
        "updateServiceScreenTimeSlotsError":
            MessageLookupByLibrary.simpleMessage(
                "Please add at least one time slot"),
        "updateServiceScreenTimeSlotsLabel":
            MessageLookupByLibrary.simpleMessage("Available Time Slots"),
        "updateServiceScreenTitle":
            MessageLookupByLibrary.simpleMessage("Edit Service"),
        "verifyAccountScreenNoOtpQuestion":
            MessageLookupByLibrary.simpleMessage("Don\'t receive OTP?"),
        "verifyAccountScreenOtpResendSuccess":
            MessageLookupByLibrary.simpleMessage("OTP sent, check your email"),
        "verifyAccountScreenResendButton":
            MessageLookupByLibrary.simpleMessage("Re-send Code"),
        "verifyAccountScreenTitle":
            MessageLookupByLibrary.simpleMessage("Verify Account"),
        "verifyAccountScreenVerificationMessage": m70,
        "verifyAccountScreenVerifyButton":
            MessageLookupByLibrary.simpleMessage("Verify")
      };
}
