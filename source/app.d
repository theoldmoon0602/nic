import std.stdio;
import std.string;
import std.random;

import ast;
import parser;
import exception;

void main()
{
  auto rnd = rndGen();
  write("> ");
  foreach (line; stdin.byLine) {
    string input = line.dup.strip;
    if (input.length == 0) {
      write("> ");
      continue;
    }
    auto parser = new Parser(input);
    auto ast = parser.parseExpr();

    auto v = ast.calc();
    if (uniform(0, 100, rnd) == 0) {
      v = v + uniform(0, 500, rnd);
      writeln(v);
      writeln("西田くんは計算を間違えてしまいました……");
    } else {
      writeln(v);
    }

    write("> ");
  }
}
