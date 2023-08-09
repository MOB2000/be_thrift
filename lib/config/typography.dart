import 'package:flutter/material.dart';

TextStyle transactionTitleStyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

TextStyle transactionSubtitleStyle = const TextStyle(
  fontSize: 12,
  color: Colors.grey,
  fontWeight: FontWeight.w400,
);

TextStyle transactionAmountStyle(Color color) => TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: FontWeight.w700,
    );
