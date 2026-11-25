/// A certification group exactly as the CV lists it (DESIGN.md 3.9).
///
/// The group title comes from l10n (`cert_group_<id>`); [meta] carries the
/// issuer and/or year shared by the whole group when the CV states one.
class CertificationGroup {
  const CertificationGroup({
    required this.id,
    required this.items,
    this.itemsEn,
    this.meta,
    this.metaEn,
  });

  final String id;
  final List<String> items;
  final List<String>? itemsEn;
  final String? meta;
  final String? metaEn;

  List<String> localizedItems(String languageCode) =>
      languageCode == 'en' ? (itemsEn ?? items) : items;

  String? localizedMeta(String languageCode) =>
      languageCode == 'en' ? (metaEn ?? meta) : meta;
}
