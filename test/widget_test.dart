import 'package:flutter_test/flutter_test.dart';
import 'package:spotify_inspired_music_streaming_app/main.dart';

void main() {
  testWidgets('app loads and shows login screen', (tester) async {
    await tester.pumpWidget(const MusicStreamingApp());

    expect(find.text('Sign up for free'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
  });
}
