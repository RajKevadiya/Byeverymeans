enum AppPage {
  home('Home'),
  services('Services'),
  process('Process'),
  work('Work Stories'),
  contact('Contact');

  const AppPage(this.label);
  final String label;

  static const navItems = [
    AppPage.home,
    AppPage.services,
    AppPage.process,
    AppPage.work,
  ];
}
