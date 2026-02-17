#include "lambda.h"

#include <cstring>
#include <cassert>
#include <ostream>

// ULC === Untyped Lambda Calculus

enum Tag { VAR, APP, ABS };
struct ulc {
    Tag tag;
    union {
        struct { char* name; } Var;
        struct { ulc* f; ulc* arg; } App;
        struct { char* name; ulc* body; } Abs;
    };
};

// TODO: Add memory managment
// TODO: Add hashconsing of ULC values

inline struct ulc* var(char *name) {
    assert(name);
    assert(strlen(name) != 0);
    return new ulc { VAR, { .Var = { .name = name } } };
}

inline struct ulc* app(struct ulc *f, struct ulc *arg) {
    assert(f);
    assert(arg);
    return new ulc { APP, { .App = { .f = f, .arg = arg } } };
}

inline struct ulc* abs(char* name, struct ulc *body) {
    assert(name);
    assert(strlen(name) != 0);
    assert(body);
    return new ulc { ABS, { .Abs = { .name = name, .body = body } } };
}

struct ulc *subst(struct ulc *what, char* name, struct ulc *where) {
    assert(what);
    assert(name);
    assert(strlen(name) != 0);
    assert(where);
    trace(where);
    switch (where->tag) {
    case VAR: {
        if (strcmp(name, where->Var.name) == 0)
            return what;
        else return where;
    }
    case APP: {
        auto f = subst(what, name, where->App.f);
        auto arg = subst(what, name, where->App.arg);
        return app(f, arg);
    }
    case ABS: {
        if (strcmp(name, where->Abs.name) == 0)
            return where;
        else {
            auto body = subst(what, name, where->Abs.body);
            auto name2 = where->Abs.name;
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

struct ulc* applyStrategy(Strategy *self, struct ulc *root) {
    switch (root->tag) {
    case VAR:
        return self->onvar(self, root->Var.name);
    case APP:
        return self->onApp(self, root->App.f, root->App.arg);
    case ABS:
        return self->onAbs(self, root->Abs.name, root->Abs.body);
    }
    assert(false);
    return nullptr;
}

struct ulc *evalVar(Strategy *, char* name) {
    return var(name);
}

struct ulc *dontReduceUnderAbstraction(Strategy*, char* name, struct ulc* body) {
    return abs(name, body);
}

struct ulc *dontReduceApplication(Strategy*, struct ulc* f, struct ulc* arg) {
    return app(f, arg);
}

struct Strategy NoStrategy = {
    .onvar = evalVar,
    .onApp = dontReduceApplication,
    .onAbs = dontReduceUnderAbstraction,
};

struct ulc *evalApplyByValue(Strategy *strat, struct ulc *f, struct ulc *arg) {
    auto f2 = applyStrategy(strat, f);
    switch (f2->tag) {
    case VAR:
    case APP: return app(f2, arg);
    case ABS: {
        auto arg2 = applyStrategy(strat, arg);
        auto rez = subst(arg2, f2->Abs.name, f2->Abs.body);
        return applyStrategy(strat, rez);
    }
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
        out << root->Var.name;
        break;
    case APP:
        out << "(";
        pp(out, root->App.f);
        out << " ";
        pp(out, root->App.arg);
        out << ")";
        break;
    case ABS:
        out << "(λ" << root->Abs.name << " -> ";
        pp(out, root->Abs.body);
        out << ")";
        break;
    }
}
