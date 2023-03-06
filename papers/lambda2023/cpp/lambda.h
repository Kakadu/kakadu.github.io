#pragma once

#include <ostream>
#include "doctest.h"

struct ulc;
struct ulc* var(char* name);
struct ulc* app(struct ulc *f, struct ulc *arg);
struct ulc* abs(char* name, struct ulc *body);

struct Strategy;
struct ulc* applyStrategy(Strategy *s, struct ulc *root);
extern struct Strategy CallByValue;

void trace(struct ulc* root);
void pp(std::ostream& out, struct ulc *root);
