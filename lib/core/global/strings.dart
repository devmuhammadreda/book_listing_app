import 'enums.dart';

String getShippingMethodText(ShippingMethod shippingMethod) {
  switch (shippingMethod) {
    case ShippingMethod.homeDelivery:
      return "Home Delivery";
    case ShippingMethod.pickInStore:
      return "Pick in Store";
  }
}

String obscureCardNumber(String cardNumber) {
  // Remove any spaces or non-digit characters for processing
  final cleanedNumber = cardNumber.replaceAll(RegExp(r'\D'), '');

  // Validate card number length (Visa cards are typically 16 digits)
  if (cleanedNumber.length < 4) {
    return cardNumber; // Return original if too short to obscure
  }

  // Extract last 4 digits
  final lastFour = cleanedNumber.substring(cleanedNumber.length - 4);

  // Create obscured portion (e.g., "**** **** **** ")
  const obscureBlock = '**** ';
  final obscuredPart = obscureBlock * 3; // Repeat 3 times for 12 digits

  // Combine obscured part with last 4 digits
  return '$obscuredPart$lastFour';
}
