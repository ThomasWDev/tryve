import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

class ProfileMenu {
  static List<ProfileMenuData> menus = [
    ProfileMenuData(
        icon: PhosphorIcons.bank,
        title: "Investing & Goals",
        desc: "Balance , List , Stats"),
    ProfileMenuData(
        icon: PhosphorIcons.currency_circle_dollar,
        title: "Transfers",
        desc: "Deposits , Withdrawals"),
    ProfileMenuData(
        icon: PhosphorIcons.newspaper,
        title: "Statements & History",
        desc: "DOCV , Tax , Activity"),
    ProfileMenuData(
        icon: PhosphorIcons.rows,
        title: "Sections",
        desc: "Notifications , Disclosure (Tes)"),
    ProfileMenuData(
        icon: PhosphorIcons.info,
        title: "Help",
        desc: "Notifications , Disclosure (Tes)"),
    ProfileMenuData(
        icon: PhosphorIcons.sign_out,
        title: "Logout",
        desc: "Sign out from tryve")
  ];
}

class ProfileMenuData {
  final IconData icon;
  final String title;
  final String desc;

  ProfileMenuData({this.icon, this.title, this.desc});
}
