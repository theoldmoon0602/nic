module ast;

import std.stdio;
import std.math;
import exception;

abstract class AST {
  public:
    double calc();
}

class OpAST : AST {
  protected:
    char op;
    AST[] args;

  public:
    this(char op, AST[] args) {
      this.op = op;
      this.args = args;
    }
    override double calc() {
      if (op == '*') {
        double a = args[0].calc();
        double b = args[1].calc();

        if (approxEqual(a, 21) && approxEqual(b, 21)) {
          writeln("441, 吉井ですね！");
        }
        return a * b;
      } else if (op == '/') {
        return args[0].calc() / args[1].calc();
      } else if (op == '+') {
        return args[0].calc() + args[1].calc();
      } else if (op == '-') {
        return args[0].calc() - args[1].calc();
      }
      
      throw new CalcException("unknown operator");
    }
}

class NumAST : AST {
  protected:
    double v;

  public:
    this (double v) {
      this.v = v;
    }

    override double calc() {
      if (this.v == 1130) {
        writeln("1130は西田くんの誕生日です！　1130が来るたびに西田くんがまた一歩解脱に近づいたことを祝しましょう！");
      }
      return v;
    }

}
