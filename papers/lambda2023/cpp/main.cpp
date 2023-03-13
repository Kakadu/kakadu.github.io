#define DOCTEST_CONFIG_IMPLEMENT

#include "doctest.h"
#include "lambda.h"
#include <iostream>
#include <sstream>

void trace(struct ulc* root) {
    return;
    std::stringstream o;
    pp(o, root);
    std::cout << o.str() << std::endl;
}

int main(int argc, char **argv) {
    doctest::Context context;
    context.applyCommandLine(argc, argv);

    int res = context.run(); // run doctest

    // important - query flags (and --exit) rely on the user doing this
    if (context.shouldExit()) {
        // propagate the result of the tests
        return res;
    }

    printf("%s\n", "Hello, World!");
}

int factorial(const int number) {
    return number < 1 ? 1 : number <= 1 ? number : factorial(number - 1) * number;
}

TEST_CASE("testing the factorial function") {
    CHECK(factorial(0) == 1);
    CHECK(factorial(1) == 1);
    CHECK(factorial(2) == 2);
    CHECK(factorial(3) == 6);
    CHECK(factorial(10) == 3628800);
}

// TODO: Write properly
//#pragma GCC diagnostic ignored "-Wwrite-strings"
char XX[] = "x";
char YY[] = "y";

bool test1() {
    auto id1 = app(abs(XX, var(XX)), abs(YY, var(YY)) );
    auto rez = applyStrategy(&CallByValue, id1);
    std::ostringstream o;
    pp(o, rez);
    std::cout << o.str() << std::endl;
    return o.str() == std::string("(λy -> y)");
}

bool test2() {
    auto vx = var("x"), vy = var("y"), vm=var("m"), vn=var("n"), vf=var("f");
    auto add = abs("m", abs ("n", abs("f", abs("x",
            app( app (vn, vf),
                 app(app (vm, vf), vx)
                                                       ))) ));
    auto one1 = abs("f", abs("x", app(vf, vx) ));
    auto zero1 = abs("f", abs("x", vx ));
    auto zero2 = abs("f", abs("y", vy ));
    auto one2 = abs("g", abs("y", app(var("g"), var("y") )));
    auto input =
        app(app(
             app(
                 app(add, one1)
                 , one2)
             , var("u") ), var("v"));
    std::cout << "input  is";
    auto rez = applyStrategy(&CallByValue, input);
    std::ostringstream o;
    pp(o, rez);
    std::cout << o.str() << std::endl;
    return o.str() == std::string("(u (u v))");
}

bool test3() {
    auto vx = var("x"), vy

                        = var("y"), vm=var("m"), vn=var("n"), vf=var("f");
    auto add = abs("m", abs ("n", abs("f", abs("x",
                                              app( app (vn, vf),
                                                  app(app (vm, vf), vx)
                                                  ))) ));
    auto zero1 = abs("f", abs("x", vx ));
    auto zero2 = abs("f", abs("y", vy ));
    auto input =
                app(
                    app(zero1, var("u"))
                    , app( zero1, var("v")))
                ;
    std::cout << "input  is";
    trace(input);
    auto rez = applyStrategy(&CallByValue, input);
    std::ostringstream o;
    pp(o, rez);
    std::cout << o.str() << std::endl;
    return o.str() == std::string("(λx -> x)");
}

TEST_CASE("lambdas") {
    CHECK(test1());
    CHECK(test2());
    CHECK(test3());
}

// running notes
// ./example_exe --no-run (run normal program)
// ./example_exe --exit (run tests then exit)
// ./example_exe (run tests then run program)
// ./example_exe --success (print successful test casts)
