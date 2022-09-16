# Weather App in Flutter using TDD Clean Architecture

This is a project i created while learning how to write a Flutter app using TDD Clean Architecture.

## Credits

This project is based on the following from [Reso Coder](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/).

## Changes that needed to be made to the original project:

### Latest equatable package requires a `props` method to be implemented rather than super constructor.

i.e.
@override
List<Object> get props => [text, number];
instead of : super([text, number])

### For test to work:

1.  This line had to be removed:
    class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

2.  and Main method needed to be annotated with this:
    @GenerateMocks([NumberTriviaRepository])
    PS. you need to import mockito/annotations.dart

3.  Run `flutter pub run build_runner build`

4.  Import the new generated class
    (MockNumberTriviaRepository)

### Data connection checker does not support null safety yet, so i had to use the following:

    internet_connection_checker: ^0.0.1+4
