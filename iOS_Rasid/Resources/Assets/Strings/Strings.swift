// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  /// Edit
  internal static let branchDetailsEditButtonTitle = Strings.tr("Localizable", "branchDetailsEditButtonTitle", fallback: "Edit")
  /// Localizable.strings
  ///   iOS_Rasid
  /// 
  ///   Created by Fintech on 07/11/2022.
  internal static let branchListHeader = Strings.tr("Localizable", "branchListHeader", fallback: "Branchs")
  /// Make Report
  internal static let reportButtonTitleString = Strings.tr("Localizable", "reportButtonTitleString", fallback: "Make Report")
  internal enum AddBranch {
    /// Branch Manager
    internal static let branchManagerTitle = Strings.tr("Localizable", "addBranch.BranchManagerTitle", fallback: "Branch Manager")
    /// Branch Name
    internal static let branchNameTitle = Strings.tr("Localizable", "addBranch.BranchNameTitle", fallback: "Branch Name")
    /// Add
    internal static let buttonTitle = Strings.tr("Localizable", "addBranch.ButtonTitle", fallback: "Add")
    /// Choose City
    internal static let cityPlaceholder = Strings.tr("Localizable", "addBranch.CityPlaceholder", fallback: "Choose City")
    /// City
    internal static let cityTitle = Strings.tr("Localizable", "addBranch.CityTitle", fallback: "City")
    /// Choose Distrect
    internal static let distrectPlaceholder = Strings.tr("Localizable", "addBranch.DistrectPlaceholder", fallback: "Choose Distrect")
    /// Distrect
    internal static let distrectTitle = Strings.tr("Localizable", "addBranch.DistrectTitle", fallback: "Distrect")
    /// Choose Branch Manager
    internal static let managerPlaceholder = Strings.tr("Localizable", "addBranch.ManagerPlaceholder", fallback: "Choose Branch Manager")
    /// Enter Branch Name
    internal static let namePlaceholder = Strings.tr("Localizable", "addBranch.NamePlaceholder", fallback: "Enter Branch Name")
    /// Choose Nouborhood
    internal static let nouborhoodPlaceholder = Strings.tr("Localizable", "addBranch.NouborhoodPlaceholder", fallback: "Choose Nouborhood")
    /// Nouborhood
    internal static let nouborhoodTitle = Strings.tr("Localizable", "addBranch.NouborhoodTitle", fallback: "Nouborhood")
    /// Enter Phone Number
    internal static let phonePlaceholder = Strings.tr("Localizable", "addBranch.PhonePlaceholder", fallback: "Enter Phone Number")
    /// Phone Number
    internal static let phoneTitle = Strings.tr("Localizable", "addBranch.PhoneTitle", fallback: "Phone Number")
    /// Enter Sellers Count
    internal static let sellersCountPlaceholder = Strings.tr("Localizable", "addBranch.SellersCountPlaceholder", fallback: "Enter Sellers Count")
    /// Sellers Count
    internal static let sellersCountTitle = Strings.tr("Localizable", "addBranch.SellersCountTitle", fallback: "Sellers Count")
    /// Choose Street
    internal static let streetPlaceholder = Strings.tr("Localizable", "addBranch.StreetPlaceholder", fallback: "Choose Street")
    /// Street
    internal static let streetTitle = Strings.tr("Localizable", "addBranch.StreetTitle", fallback: "Street")
    /// Add Branch
    internal static let title = Strings.tr("Localizable", "addBranch.Title", fallback: "Add Branch")
  }
  internal enum Branchs {
    internal enum Filter {
      /// Branch Name
      internal static let branchNamePlaceholder = Strings.tr("Localizable", "branchs.Filter.branchNamePlaceholder", fallback: "Branch Name")
      /// Branch Name
      internal static let branchNameTitle = Strings.tr("Localizable", "branchs.Filter.branchNameTitle", fallback: "Branch Name")
      /// From
      internal static let from = Strings.tr("Localizable", "branchs.Filter.from", fallback: "From")
      /// From
      internal static let fromPlaceholder = Strings.tr("Localizable", "branchs.Filter.fromPlaceholder", fallback: "From")
      /// Manager Name
      internal static let managerNamePlaceholder = Strings.tr("Localizable", "branchs.Filter.managerNamePlaceholder", fallback: "Manager Name")
      /// Manager Name
      internal static let managerNameTitle = Strings.tr("Localizable", "branchs.Filter.managerNameTitle", fallback: "Manager Name")
      /// Search
      internal static let searchButtonTitle = Strings.tr("Localizable", "branchs.Filter.searchButtonTitle", fallback: "Search")
      /// To
      internal static let to = Strings.tr("Localizable", "branchs.Filter.to", fallback: "To")
      /// To
      internal static let toPlaceholder = Strings.tr("Localizable", "branchs.Filter.toPlaceholder", fallback: "To")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
