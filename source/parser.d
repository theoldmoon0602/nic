module parser;

import ast;
import exception;
import std.conv;

class Parser {
  protected:
    string source;
    long p = 0;

  public:
    this(string source) {
      this.source = source;
      p = 0;
    }

    void skipspace() {
      while (source[p] == ' ') {
        p++;
      }
    }

    AST parseNum() {
      skipspace();

      auto start = p;
      int dotcnt = 0;
      while (p < source.length && ('0' <= source[p] && source[p] <= '9' || (dotcnt == 0 && source[p] == '.'))) {
        if (source[p] == '.') {
          dotcnt++;
        }
        p++;
      }

      if (start != p) {
        return new NumAST(source[start..p].to!double);
      }
      return null;
    }

    AST parseFactor() {
      skipspace();

      if (source[p] == '(') {
        p++;

        auto e = parseExpr();

        if (source[p] != ')') {
          throw new ParseException(") required");
        }
        p++;

        return e;
      }

      return parseNum();
    }

    AST parseExpr() {
      return parseAddSub();
    }

    AST parseAddSub() {
      auto a = parseMulDiv();
      if (a is null) {
        return null;
      }

      while (p < source.length) {
        skipspace();
        if (source[p] != '+' && source[p] != '-') {
          break;
        }
        auto op = source[p];
        p++;

        auto b = parseMulDiv();        
        if (b is null) {
          throw new ParseException("number required");
        }

        a = new OpAST(op, [a, b]);
      }

      return a;
    }

    AST parseMulDiv() {
      auto a = parseFactor();

      if (a is null) {
        return null;
      }

      while (p < source.length) {
        skipspace();
        if (source[p] != '*' && source[p] != '/') {
          break;
        }
        auto op = source[p];
        p++;

        auto b = parseFactor();        
        if (b is null) {
          throw new ParseException("number required");
        }

        a = new OpAST(op, [a, b]);
      }

      return a;
    }
}

