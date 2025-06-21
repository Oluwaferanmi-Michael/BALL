
class OnboardingData {
  final String title;
  final String subtitle;
  final String imagePath;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
  
  OnboardingData.empty() : title = '', subtitle = '', imagePath = '';
  
}