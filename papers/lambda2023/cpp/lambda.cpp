#include "lambda.h"
#include <cstring>
#include <string>
#include <memory>
#include <cassert>
#include <ostream>

using namespace std;
/*
class ULC {};

class Var : public ULC {
    string name;
};

typedef std::shared_ptr<ULC> ulc;

struct App final : public ULC {
    std::shared_ptr<ULC> f;
    std::shared_ptr<ULC> arg;
};
struct Abs final : public ULC {
    string varname;
    std::shared_ptr<ULC> body;
};

struct strategy {
    virtual shared_ptr<ULC> onVar(string name) = 0;
    virtual shared_ptr<ULC> onApp(const ulc f, ulc r) = 0;
    virtual shared_ptr<ULC> onAbs(const string varname, const ulc body) = 0;
};

struct CallByValue : public strategy {

};
*/
enum Tag { VAR, APP, ABS };
struct ulc {
    Tag tag;
    union body {
        struct Var { char* name; } Var;
        struct App { ulc* f; ulc* arg; } App;
        struct Abs { char* name; ulc* body; } Abs;
    } body;
};

inline struct ulc* var(char *name) {
    assert(name);
    assert(strlen(name) != 0);
    return new ulc { .tag = VAR, .body = { .Var = { .name = name } } };
}

inline struct ulc* app(struct ulc *f, struct ulc *arg) {
    assert(f);
    assert(arg);
    return new ulc { .tag = APP, .body = { .App = { .f = f, .arg = arg } } };
}

inline struct ulc* abs(char* name, struct ulc *body) {
    assert(name);
    assert(body);
    assert(strlen(name) != 0);
    return new ulc { .tag = ABS, .body = { .Abs = { .name = name, .body = body } } };
}

struct ulc *subst(struct ulc *what, char* name, struct ulc *where) {
    assert(what);
    assert(name);
    assert(strlen(name) != 0);
    assert(where);
    //printf("name = %s, where = ", name);
    trace(where);
    switch (where->tag) {
    case VAR: {
        if (strcmp(name, where->body.Var.name) == 0)
            return what;
        else return where;
    }
    case APP: {
        auto f = subst(what, name, where->body.App.f);
        auto arg = subst(what, name, where->body.App.arg);
        return app(f, arg);
    }
    case ABS: {
        if (strcmp(name, where->body.Abs.name) == 0)
            return where;
        else {
            auto body = subst(what, name, where->body.Abs.body);
            auto name2 = where->body.Abs.name;
            //printf("new body:");
            trace(body);
            return abs(name2, body);
        }
    }
    }
    assert (false);
    return nullptr;
}


struct Strategy {
    ulc* (*onvar)(Strategy* self, char* name);
    ulc* (*onApp)(Strategy* self, ulc* f, ulc* arg);
    ulc* (*onAbs)(Strategy* self, char* name, ulc* arg);
};

struct ulc* applyStrategy(Strategy *s, struct ulc *root) {
    switch (root->tag) {
    case VAR:
        return s->onvar(s, root->body.Var.name);
    case APP:
        return s->onApp(s, root->body.App.f, root->body.App.arg);
    case ABS:
        return s->onAbs(s, root->body.Abs.name, root->body.Abs.body);
    }
    assert(false);
    return nullptr;
}

struct ulc *evalVar(Strategy*, char* name) {
    return var(name);
}
struct ulc *dontReduceUnderAbstraction(Strategy*, char* name, ulc* body) {
    return abs(name, body);
}

struct ulc *evalApplyByValue(Strategy *strat, ulc *f, ulc *arg) {
    auto f2 = applyStrategy(strat, f);
    switch (f2->tag) {
    case VAR:
    case APP: {
        //printf("can't apply to the end\n");
        auto rez = app(f2, arg);
        trace(rez);
        return rez;
    }
    case ABS:
        auto arg2 = applyStrategy(strat, arg);
        printf("Evaluated arg: ");
        trace(arg2);
        auto rez = subst(arg2, f2->body.Abs.name, f2->body.Abs.body);
//        printf("Substitution rezult: ");
//        trace(rez);
        return applyStrategy(strat, rez);
    }
    assert(false);
    return nullptr;
}

struct Strategy CallByValue = {
    .onvar = evalVar,
    .onApp = evalApplyByValue,
    .onAbs = dontReduceUnderAbstraction,
};

void pp(std::ostream& out, struct ulc *root) {
    switch (root->tag) {
    case VAR:
        out << root->body.Var.name;
        break;
    case APP:
        out << "(";
        pp(out, root->body.App.f);
        out << " ";
        pp(out, root->body.App.arg);
        out << ")";
        break;
    case ABS:
        out << "(λ" << root->body.Abs.name << " -> ";
        pp(out, root->body.Abs.body);
        out << ")";
        break;
    }
}
