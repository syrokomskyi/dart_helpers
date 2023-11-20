import 'package:dart_helpers/dart_helpers.dart';
import 'package:test/test.dart';

void main() {
  test('bittenOf() not empty string, in range', () {
    expect('abcdefgh'.bittenOf(2, 1), 'ab..h');
    expect('abcdefgh'.bittenOf(0, 1), '..h');
    expect('abcdefgh'.bittenOf(2, 0), 'ab..');
    expect('abcdefgh'.bittenOf(0, 0), '');

    expect('abcdefgh'.bittenOf(8, 0), 'abcdefgh');
    expect('abcdefgh'.bittenOf(0, 8), 'abcdefgh');

    expect('abcdefgh'.bittenOf(7, 0), 'abcdefg..');
    expect('abcdefgh'.bittenOf(0, 7), '..bcdefgh');

    expect('abcdefgh'.bittenOf(7, 1), 'abcdefgh');
    expect('abcdefgh'.bittenOf(1, 7), 'abcdefgh');

    expect('abcdefgh'.bittenOf(7, 5), 'abcdefgh');
    expect('abcdefgh'.bittenOf(5, 7), 'abcdefgh');
  });

  test('bittenOf() not empty string, with spaces on the edges', () {
    expect('   abcdefgh '.bittenOf(4, 2), '   a..h ');
    expect('   abc  fgh '.bittenOf(6, 5), '   abc.. fgh ');
    expect('   abc  fgh '.bittenOf(7, 5), '   abc  fgh ');
  });

  test('bittenOf() not empty string, out of range', () {
    expect('abcdefgh'.bittenOf(12, 1), 'abcdefgh');
    expect('abcdefgh'.bittenOf(1, 12), 'abcdefgh');
  });

  test('bittenOf() negative range', () {
    expect('abcdefgh'.bittenOf(-1, 1), '..h');
    expect('abcdefgh'.bittenOf(1, -1), 'a..');
    expect('abcdefgh'.bittenOf(-1, -1), '');
  });

  test('bittenOf() empty string', () {
    expect(''.bittenOf(0, 0), '');
    expect(''.bittenOf(1, 2), '');
    expect(''.bittenOf(-1, -2), '');
  });
}
